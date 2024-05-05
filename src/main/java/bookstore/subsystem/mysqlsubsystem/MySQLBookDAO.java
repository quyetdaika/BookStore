package bookstore.subsystem.mysqlsubsystem;

import bookstore.entities.Book;
import bookstore.subsystem.iface.IBookDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MySQLBookDAO implements IBookDAO {
    private final Connection connection;

    public MySQLBookDAO(Connection connection) {
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

    List<Book> getBooksNoParameterIndex(String sql){
        List<Book> allBooks = new ArrayList<>();

        Book book = null;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                book = new Book();
                book.setId(rs.getInt("id"));
                book.setName(rs.getString("name"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(Double.parseDouble(rs.getString("price")));
                book.setCategory(rs.getString("category"));
                book.setPage(Integer.parseInt(rs.getString("page")));
                book.setDeepth(Double.parseDouble(rs.getString("deepth")));
                book.setHeight(Double.parseDouble(rs.getString("height")));
                book.setWidth(Double.parseDouble(rs.getString("width")));
                book.setFileName(rs.getString("file_name"));
                book.setSold(rs.getInt("sold"));

                allBooks.add(book);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return allBooks;
    }

    List<Book> getBooksWithParameterIndex(String sql, String... pamameters){
        List<Book> allBooks = new ArrayList<>();

        Book book = null;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            for(int i = 0; i < pamameters.length; i++){
                ps.setString(i + 1, pamameters[i]);
            }
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                book = new Book();
                book.setId(rs.getInt("id"));
                book.setName(rs.getString("name"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(Double.parseDouble(rs.getString("price")));
                book.setCategory(rs.getString("category"));
                book.setPage(Integer.parseInt(rs.getString("page")));
                book.setDeepth(Double.parseDouble(rs.getString("deepth")));
                book.setHeight(Double.parseDouble(rs.getString("height")));
                book.setWidth(Double.parseDouble(rs.getString("width")));
                book.setFileName(rs.getString("file_name"));
                book.setSold(rs.getInt("sold"));

                allBooks.add(book);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return allBooks;
    }

    @Override
    public List<Book> getAllBooks() {
        String sql = "select * from book";

        return getBooksNoParameterIndex(sql);
    }

    @Override
    public List<Book> getNewReleaseBooks() {
        String sql = "SELECT * from book order by id desc;";
        return getBooksNoParameterIndex(sql);
    }

    @Override
    public List<Book> getSaleBooks() {
        String sql = "select * from book where tag = ?";
        return getBooksWithParameterIndex(sql, "Sale Books");
    }

//    @Override
//    public List<String> getCategories() {
//        List<String> categories = new ArrayList<>();
//        String sql = "select distinct category from book";
//        List<Book> allBooks = getBooksNoParameterIndex(sql);
//        for(Book book : allBooks) categories.add(book.getCategory());
//        return categories;
//    }

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

    @Override
    public List<Book> getBestSellerBooks() {
        String sql = "select * from book order by sold desc";
        return getBooksNoParameterIndex(sql);
    }

    @Override
    public List<Book> getBookByKeyword(String keyword) {
        String sql = "select * from book where name like ?";
        String keywordWithWildcard = "%" + keyword + "%";
        return getBooksWithParameterIndex(sql, keywordWithWildcard);
    }

    @Override
    public Book getBookByID(int bookID) {
        List<Book> allBooks = new ArrayList<>();
        Book book = null;

        try {
            String sql = "select * from book where id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, bookID);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                book = new Book();
                book.setId(rs.getInt("id"));
                book.setName(rs.getString("name"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(Double.parseDouble(rs.getString("price")));
                book.setCategory(rs.getString("category"));
                book.setPage(Integer.parseInt(rs.getString("page")));
                book.setDeepth(Double.parseDouble(rs.getString("deepth")));
                book.setHeight(Double.parseDouble(rs.getString("height")));
                book.setWidth(Double.parseDouble(rs.getString("width")));
                book.setFileName(rs.getString("file_name"));
                book.setSold(rs.getInt("sold"));

                allBooks.add(book);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return allBooks.get(0);
    }
}
