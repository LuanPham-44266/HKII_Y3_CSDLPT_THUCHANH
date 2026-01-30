/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import javax.swing.table.DefaultTableModel;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.Vector;
import java.sql.SQLException;
/**
 *
 * @author PC
 */
public class EMP_Model {
    public EMP_Model(){
 String connectionString = "jdbc:sqlserver://192.168.11.124:1433;"
 + "user=user01;"
 + "password=123456;"
 + "encrypt=true;"
 + "trustServerCertificate=true;"
 + "databaseName=CSDLPT";
 DataModel.init("SERVER_1",connectionString);
}
public DefaultTableModel getEmployeeModel(String serverKey) {
 
 DefaultTableModel model = new DefaultTableModel();
 model.addColumn("Mã NV");
 model.addColumn("Họ Tên");
 model.addColumn("Chức Vụ");
 DataModel db = DataModel.getInstance(serverKey);
 if (db == null) return model;
 try (Connection conn = db.getConnection();
 CallableStatement cstmt = conn.prepareCall("{call sp_GetAllEmp}")) {
 ResultSet rs = cstmt.executeQuery();
 while (rs.next()) {
 Vector row = new Vector<Object>();
 row.add(rs.getString("ENO"));
 row.add(rs.getString("ENAME"));
 row.add(rs.getString("TITLE")); 
 model.addRow(row);
 }
 } catch (Exception e) {
 e.printStackTrace();
 } 
 return model;
 }
 public boolean addEmployee(String serverKey, String eno, String ename, String title) {
 String sql = "{call sp_AddEmp(?, ?, ?)}";
 DataModel db = DataModel.getInstance(serverKey); 
 try (Connection conn = db.getConnection();
 CallableStatement cstmt = conn.prepareCall(sql)) { 
 cstmt.setString(1, eno);
 cstmt.setString(2, ename);
 cstmt.setString(3, title); 
 return cstmt.executeUpdate() > 0; 
 } catch (SQLException e) {
 e.printStackTrace();
 return false;
 }
 }
}