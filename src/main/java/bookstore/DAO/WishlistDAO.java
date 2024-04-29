package bookstore.DAO;

import java.util.List;

public interface WishlistDAO {
    public boolean addBookToWishlist(int userID, int bookID);
    public boolean removeBookFromWishlist(int userID, int bookID);
    public boolean addAllBookToWishlist(int userID, List<Integer> bookIDs);
    public boolean removeAllBookFromWishlist(int userID);
    public List<Integer> getBookIDs(int userID);
}
