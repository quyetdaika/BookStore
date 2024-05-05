package bookstore.subsystem.mysqlsubsystem;

import bookstore.subsystem.iface.IWishlistDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MySQLWishlistDAO implements IWishlistDAO {
    private Connection connection;

    public MySQLWishlistDAO(Connection connection) {
        super();
        this.connection = connection;
    }

    @Override
    public boolean addBookToWishlist(int userID, int bookID) {
        boolean f = false;
        try {
            String sql = "insert into Wishlist(userID, bookID) values(?, ?);";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, bookID);

            f = ps.executeUpdate() == 1;
        } catch (Exception e){
            e.printStackTrace();
        }
        if(f) System.out.println("insert to Wishlist success");
        else System.out.println("insert to Wishlist failed");
        return f;
    }

    @Override
    public boolean removeBookFromWishlist(int userID, int bookID) {
        boolean f = false;
        try {
            String sql = "delete from wishlist where userid = ? and bookid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, bookID);

            f = ps.executeUpdate() == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if(f) System.out.println("delete from Wishlist success");
        else System.out.println("delete from Wishlist failed");
        return f;
    }

    @Override
    public boolean addAllBookToWishlist(int userID, List<Integer> bookIDs) {
        return false;
    }

    @Override
    public boolean removeAllBookFromWishlist(int userID) {
        boolean f = false;
        try {
            String sql = "delete from wishlist where userid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            f = ps.executeUpdate() == 1;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if(f) System.out.println("delete all from Wishlist success");
        else System.out.println("delete all from Wishlist failed");
        return f;
    }

    @Override
    public List<Integer> getBookIDs(int userID) {
        List<Integer> bookIDs = new ArrayList<>();
        try {
            String sql = "select bookID from Wishlist where userID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                bookIDs.add(rs.getInt("bookID"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return bookIDs;
    }
}
