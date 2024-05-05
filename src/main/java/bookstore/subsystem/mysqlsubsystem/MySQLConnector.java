package bookstore.subsystem.mysqlsubsystem;

import bookstore.subsystem.iface.IDBConnector;

import java.sql.Connection;
import java.sql.DriverManager;

public class MySQLConnector{
    private static Connection connection;

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "12345");
        } catch (Exception e){
            e.printStackTrace();
        }
        return connection;
    }
}
