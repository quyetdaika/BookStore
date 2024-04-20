package bookstore.DAO;

import bookstore.entity.User;

public interface UserDao {
    public boolean userRegister(User user);
    public User login(String email, String password);
}
