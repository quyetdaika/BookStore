package bookstore.DAO;

import bookstore.entity.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

    @Override
    public User login(String email, String password) {
        User user = null;

        try {
            String sql = "select * from user where email = ? and password = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            while ((rs.next())){
                user = new User();
                user.setId(rs.getInt(1));
                user.setName(rs.getString(2));
                user.setEmail(rs.getString(3));
                user.setPassword(rs.getString(4));
                user.setPhone(rs.getString(5));
                user.setAddress(rs.getString(6));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
