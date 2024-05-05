package bookstore.subsystem.iface;

import java.util.List;

public interface IWishlistDAO {
    public boolean addBookToWishlist(int userID, int bookID);
    public boolean removeBookFromWishlist(int userID, int bookID);
    public boolean addAllBookToWishlist(int userID, List<Integer> bookIDs);
    public boolean removeAllBookFromWishlist(int userID);
    public List<Integer> getBookIDs(int userID);
}
