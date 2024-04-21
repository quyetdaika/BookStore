package bookstore.admin.servlet;

import bookstore.DAO.BookDAOIplm;
import bookstore.DB.DBConnect;
import bookstore.entity.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/add_book")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AddBookServlet extends HttpServlet {

//    private static final String UPLOAD_DIRECTORY = "src/main/webapp/book";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        String category = request.getParameter("category");
        int page = Integer.parseInt(request.getParameter("page"));
        double deepth = Double.parseDouble(request.getParameter("deepth"));
        double height = Double.parseDouble(request.getParameter("height"));
        double width = Double.parseDouble(request.getParameter("width"));

        // Get the uploaded file
        Part filePart = request.getPart("bookImage");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));

        Book newBook = new Book(name, author, price, category, page, fileName, deepth, height, width);
        System.out.println(newBook);

        // Save the uploaded file
//        String filePath = UPLOAD_DIRECTORY + File.separator + System.currentTimeMillis() + fileExtension;
//        InputStream fileContent = filePart.getInputStream();
//        Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);

        // TODO: Save the book details and file path to the database
        BookDAOIplm bookDAO = new BookDAOIplm(DBConnect.getConnection());

        boolean f = bookDAO.addBook(newBook);

        HttpSession httpSession = request.getSession();
        if(f){
            httpSession.setAttribute("successMsg", "Add Book Successfully");
            response.sendRedirect("admin/add_book.jsp");
        } else {
            httpSession.setAttribute("failedMsg", "Something went wrong on server !");
            response.sendRedirect("admin/add_book.jsp");
        }

        // Redirect or render a success message
//        response.sendRedirect("admin_dashboard.jsp");
    }
}