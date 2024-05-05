package bookstore.subsystem.iface;

import bookstore.entities.User;

public interface IUserDAO {
    public boolean userRegister(User user);
    public User login(String email, String password);
    public boolean isEmailExist(String email);
}
