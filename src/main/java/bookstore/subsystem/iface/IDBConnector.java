package bookstore.subsystem.iface;

import java.sql.Connection;

public interface IDBConnector {
    public Connection getConnection();
}
