/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author PC
 */
public class DataModel {
    private static final Map<String, DataModel> instances = new HashMap<>();
 private final SQLServerDataSource dataSource;
 private DataModel(String connectionString) {
 dataSource = new SQLServerDataSource(); 
 dataSource.setURL(connectionString);
}
public static void init(String key, String connectionString) {
 if (!instances.containsKey(key)) {
instances.put(key, new DataModel(connectionString));
 }
 } public static DataModel getInstance(String key) {
 return instances.get(key);
 }
 public Connection getConnection() throws SQLException {
 return dataSource.getConnection();
 }
}