package bookstore.DAO;

import bookstore.entity.Book;

import java.util.List;

public interface BookDAO {
    public boolean addBook(Book newBook);
    public List<Book> getAllBooks();

    public List<Book> getNewReleaseBooks();
    public List<Book> getSaleBooks();
    public List<String> getCategories();
    public List<Book> getBookByCategory(String category);
    public List<Book> getBookByName(String name);
    public List<Book> getBestSellerBooks();
    public List<Book> getBookByKeyword(String keyword);
    public Book getBookByID(String bookID);
}
