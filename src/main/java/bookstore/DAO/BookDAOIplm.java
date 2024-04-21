package bookstore.DAO;

import bookstore.entity.Book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    @Override
    public List<Book> getAllBooks() {
        List<Book> allBooks = new ArrayList<>();

        Book book = null;

        try {
            String sql = "select * from book";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                book = new Book();
                book.setId(rs.getInt(1));
                book.setName(rs.getString(2));
                book.setAuthor(rs.getString(3));
                book.setPrice(Double.parseDouble(rs.getString(4)));
                book.setCategory(rs.getString(5));
                book.setPage(Integer.parseInt(rs.getString(6)));
                book.setDeepth(Double.parseDouble(rs.getString(7)));
                book.setHeight(Double.parseDouble(rs.getString(8)));
                book.setWidth(Double.parseDouble(rs.getString(9)));
                book.setFileName(rs.getString(10));

                allBooks.add(book);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return allBooks;
    }

    @Override
    public List<Book> getNewReleaseBooks() {

        List<Book> newReleaseBooks = new ArrayList<>();

        Book book = null;

        try {
            String sql = "SELECT * from book order by id desc;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                book = new Book();
                book.setId(rs.getInt(1));
                book.setName(rs.getString(2));
                book.setAuthor(rs.getString(3));
                book.setPrice(Double.parseDouble(rs.getString(4)));
                book.setCategory(rs.getString(5));
                book.setPage(Integer.parseInt(rs.getString(6)));
                book.setDeepth(Double.parseDouble(rs.getString(7)));
                book.setHeight(Double.parseDouble(rs.getString(8)));
                book.setWidth(Double.parseDouble(rs.getString(9)));
                book.setFileName(rs.getString(10));

                newReleaseBooks.add(book);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return newReleaseBooks;
    }

    @Override
    public List<Book> getSaleBooks() {
        List<Book> newReleaseBooks = new ArrayList<>();

        Book book = null;

        try {
            String sql = "select * from book where tag = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "Sale Books");
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                book = new Book();
                book.setId(rs.getInt(1));
                book.setName(rs.getString(2));
                book.setAuthor(rs.getString(3));
                book.setPrice(Double.parseDouble(rs.getString(4)));
                book.setCategory(rs.getString(5));
                book.setPage(Integer.parseInt(rs.getString(6)));
                book.setDeepth(Double.parseDouble(rs.getString(7)));
                book.setHeight(Double.parseDouble(rs.getString(8)));
                book.setWidth(Double.parseDouble(rs.getString(9)));
                book.setFileName(rs.getString(10));

                newReleaseBooks.add(book);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return newReleaseBooks;
    }

    @Override
    public List<String> getCategories() {
        List<String> categories = new ArrayList<>();

        try {
            String sql = "select distinct category from book";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                categories.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categories;
    }

    @Override
    public List<Book> getBookByCategory(String category) {
        List<Book> res =new ArrayList<>();
        for(Book book : getAllBooks()){
            if(book.getCategory().equals(category)) res.add(book);
        }
        return res;
    }

    @Override
    public List<Book> getBookByName(String name) {
        List<Book> books = new ArrayList<>();

        for(Book book : getAllBooks()){
            if(book.getName().contains(name)) books.add(book);
        }
        return books;
    }
}
