package bookstore.DAO;

import bookstore.entity.User;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserDAOImpl implements UserDao {
    private Connection connection;

    public UserDAOImpl(Connection connection) {
        super();
        this.connection = connection;
    }

    @Override
    public boolean userRegister(User user) {
        boolean res = false;

        try {
            String sql = "insert into user(name, email, password) values (?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());

            res = ps.executeUpdate() == 1;
        } catch (Exception e){
            e.printStackTrace();
        }
        return res;
    }
}
