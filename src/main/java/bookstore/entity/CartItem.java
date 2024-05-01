package bookstore.entity;

public class CartItem {
    private int userID;
    private int bookID;
    private int quantity;

    public CartItem(int bookID, int quantity) {
        this.userID = 0;
        this.bookID = bookID;
        this.quantity = quantity;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public CartItem() {
    }

    public CartItem(int userID, int bookID, int quantity) {
        this.userID = userID;
        this.bookID = bookID;
        this.quantity = quantity;
    }
}
