--LAB 1 - 
--Tạo CSDL

CREATE DATABASE CSDLPT;
GO
USE CSDLPT;
CREATE TABLE PAY (
 TITLE NVARCHAR(50) PRIMARY KEY,
 SAL INT
);
CREATE TABLE EMP (
 ENO CHAR(5) PRIMARY KEY,
 ENAME NVARCHAR(100),
 TITLE NVARCHAR(50),
 CONSTRAINT FK_EMP_PAY FOREIGN KEY (TITLE) REFERENCES PAY(TITLE)
);
CREATE TABLE PROJ (
 PNO CHAR(5) PRIMARY KEY,
 PNAME NVARCHAR(100),
 BUDGET INT
);
CREATE TABLE ASG (
 ENO CHAR(5),
 PNO CHAR(5),
 RESP NVARCHAR(50),
 DUR INT,
 PRIMARY KEY (ENO, PNO),
 CONSTRAINT FK_ASG_EMP FOREIGN KEY (ENO) REFERENCES EMP(ENO),
 CONSTRAINT FK_ASG_PROJ FOREIGN KEY (PNO) REFERENCES PROJ(PNO)
);
INSERT INTO PAY (TITLE, SAL) VALUES
('Elect. Eng.', 40000),
('Syst. Anal.', 34000),
('Mech. Eng.', 27000),
('Programmer', 24000);
INSERT INTO PROJ (PNO, PNAME, BUDGET) VALUES
('P1', 'Instrumentation', 150000),
('P2', 'Database Develop.', 135000),
('P3', 'CAD/CAM', 250000),
('P4', 'Maintenance', 310000);
INSERT INTO EMP (ENO, ENAME, TITLE) VALUES
('E1', 'J. Doe', 'Elect. Eng.'),
('E2', 'M. Smith', 'Syst. Anal.'),
('E3', 'A. Lee', 'Mech. Eng.'),
('E4', 'J. Miller', 'Programmer'),
('E5', 'B. Casey', 'Syst. Anal.'),
('E6', 'L. Chu', 'Elect. Eng.'),
('E7', 'R. Davis', 'Mech. Eng.'),
('E8', 'J. Jones', 'Syst. Anal.');
INSERT INTO ASG (ENO, PNO, RESP, DUR) VALUES
('E1', 'P1', 'Manager', 12),
('E2', 'P1', 'Analyst', 24),
('E2', 'P2', 'Analyst', 6),
('E3', 'P3', 'Consultant', 10),
('E3', 'P4', 'Engineer', 48),
('E4', 'P2', 'Programmer', 18),
('E5', 'P2', 'Manager', 24),
('E6', 'P4', 'Manager', 48),
('E7', 'P3', 'Engineer', 36),
('E8', 'P3', 'Manager', 40);

--Các thủ tục thêm dữ liệu 
GO
CREATE PROCEDURE sp_AddPay
 @Title NVARCHAR(50),
 @Sal INT
AS
BEGIN
 INSERT INTO PAY (TITLE, SAL) VALUES (@Title, @Sal);
END;
GO
CREATE PROCEDURE sp_AddEmp
 @Eno CHAR(5),
 @Ename NVARCHAR(100),
 @Title NVARCHAR(50)
AS
BEGIN
 INSERT INTO EMP (ENO, ENAME, TITLE) VALUES (@Eno, @Ename, @Title);
END;
GO
CREATE PROCEDURE sp_AddProj
 @Pno CHAR(5),
 @Pname NVARCHAR(100),
 @Budget INT
AS
BEGIN
 INSERT INTO PROJ (PNO, PNAME, BUDGET) VALUES (@Pno, @Pname, @Budget);
END;
GO
CREATE PROCEDURE sp_AddAsg
 @Eno CHAR(5),
 @Pno CHAR(5),
 @Resp NVARCHAR(50),
 @Dur INT
AS
BEGIN
 INSERT INTO ASG (ENO, PNO, RESP, DUR) VALUES (@Eno, @Pno, @Resp, @Dur);
END;
--Các thủ tục hiển thị thông tin dữ liệu
CREATE PROCEDURE sp_GetAllPay AS SELECT * FROM PAY;
GO
CREATE PROCEDURE sp_GetAllEmp AS SELECT * FROM EMP;
GO
CREATE PROCEDURE sp_GetAllProj AS SELECT * FROM PROJ;
GO
CREATE PROCEDURE sp_GetAllAsg AS SELECT * FROM ASG;
GO

-- Tạo người dùng tương tác với hệ thống
CREATE LOGIN user01 WITH PASSWORD = '123456';
GO
CREATE USER user01 FOR LOGIN user01;
GO
GRANT INSERT, UPDATE, DELETE, SELECT, EXECUTE TO user01;