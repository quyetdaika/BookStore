package bookstore.subsystem.iface;

import java.util.List;

public interface ICartDAO {
    public boolean addBookToCart(int userID, int bookID, int quantity);
    public boolean updateBookInCart(int userID, int bookID, int quantity);
    public boolean removeBookFromCart(int userID, int bookID);
    public boolean addAllBookToCart(int userID, List<Integer> bookIDs);
    public boolean removeAllBookFromCart(int userID, List<Integer> bookIDs);
    public List<Integer> getBookIDs(int userID);
    public int getBookQtyInCart(int userID, int bookID);
    public int getSumQuantity(int userID);
}
