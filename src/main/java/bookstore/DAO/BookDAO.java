package bookstore.DAO;

import bookstore.entity.Book;

import java.util.List;

public interface BookDAO {
    public boolean addBook(Book newBook);

    public List<Book> getNewReleaseBooks();
    public List<Book> getSaleBooks();
}
