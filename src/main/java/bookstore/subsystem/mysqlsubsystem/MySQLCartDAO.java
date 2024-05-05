package bookstore.subsystem.mysqlsubsystem;

import bookstore.subsystem.iface.ICartDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MySQLCartDAO implements ICartDAO {
    private final Connection connection;

    public MySQLCartDAO(Connection connection) {
        super();
        this.connection = connection;
    }

    @Override
    public boolean addBookToCart(int userID, int bookID, int quantity) {
        boolean f = false;
        try {
            int currentQty = getBookQtyInCart(userID, bookID);
            System.out.println("current qty : " + currentQty);
            String sql;
            if(currentQty == 0){
                sql = "insert into cart(userID, bookID, quantity) values(?, ?, ?);";
            } else {
                sql = "update cart set quantity = ? where userID = ? and bookID = ?;";
            }

            PreparedStatement ps = connection.prepareStatement(sql);
            if(currentQty == 0){
                ps.setInt(1, userID);
                ps.setInt(2, bookID);
                ps.setInt(3, quantity);
            } else {
                ps.setInt(1, currentQty + quantity);
                ps.setInt(2, userID);
                ps.setInt(3, bookID);
            }

            f = ps.executeUpdate() == 1;
        } catch (Exception e){
            e.printStackTrace();
        }
        if(f) System.out.println("insert to Cart success");
        else System.out.println("insert to Cart failed");
        return f;
    }

    @Override
    public boolean updateBookInCart(int userID, int bookID, int quantity) {
        boolean f = false;
        try {
            String sql = "update cart set quantity = ? where userID = ? and bookID = ?;";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, userID);
            ps.setInt(3, bookID);

            f = ps.executeUpdate() == 1;
        } catch (Exception e){
            e.printStackTrace();
        }
        if(f) System.out.println("update book in Cart success");
        else System.out.println("update book in Cart failed");
        return f;
    }

    @Override
    public boolean removeBookFromCart(int userID, int bookID) {
        boolean f = false;
        try {
            String sql = "delete from cart where userid = ? and bookid = ?;";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, bookID);

            f = ps.executeUpdate() == 1;
        } catch (Exception e){
            e.printStackTrace();
        }
        if(f) System.out.println("delete from Cart success");
        else System.out.println("delete from Cart failed");
        return f;
    }

    @Override
    public boolean addAllBookToCart(int userID, List<Integer> bookIDs) {
        boolean f = false;
        for(int bookID : bookIDs) f = addBookToCart(userID, bookID, 1);
        if(f) System.out.println("insert all to Cart success");
        else System.out.println("insert all to Cart failed");
        return f;
    }

    @Override
    public boolean removeAllBookFromCart(int userID, List<Integer> bookIDs) {
        return false;
    }

    @Override
    public List<Integer> getBookIDs(int userID) {
        List<Integer> bookIDs = new ArrayList<>();
        try {
            String sql = "select bookID from cart where userID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                bookIDs.add(rs.getInt("bookID"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println("bookIDs size : " + bookIDs.size());
        return bookIDs;
    }

    @Override
    public int getBookQtyInCart(int userID, int bookID) {
        List<Integer> res = new ArrayList<>();
        try {
            String sql = "select quantity from cart where userID = ? and bookID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, bookID);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                res.add(rs.getInt("quantity"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res.isEmpty() ? 0 : res.get(0);
    }

    @Override
    public int getSumQuantity(int userID) {
        List<Integer> res = new ArrayList<>();
        try {
            String sql = "select sum(quantity) from cart where userID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                res.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res.isEmpty() ? 0 : res.get(0);
    }
}
