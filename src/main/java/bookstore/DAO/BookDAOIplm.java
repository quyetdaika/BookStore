package bookstore.DAO;

import bookstore.entity.Book;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class BookDAOIplm implements BookDAO {
    private Connection connection;

    public BookDAOIplm(Connection connection) {
        super();
        this.connection = connection;
    }

    @Override
    public boolean addBook(Book newBook) {
        boolean f = false;
        try {
            String sql = "insert into book (name, author, price, category, page, deepth, height, width, file_name) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newBook.getName());
            ps.setString(2, newBook.getAuthor());
            ps.setDouble(3, newBook.getPrice());
            ps.setString(4, newBook.getCategory());
            ps.setInt(5, newBook.getPage());
            ps.setDouble(6, newBook.getDeepth());
            ps.setDouble(7, newBook.getHeight());
            ps.setDouble(8, newBook.getWidth());
            ps.setString(9, newBook.getFileName());

            f = ps.executeUpdate() == 1;

        } catch (Exception e){
            e.printStackTrace();
        }
        return f;
    }
}
