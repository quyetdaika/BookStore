package bookstore.wishlist;

import bookstore.subsystem.iface.IWishlistDAO;
import bookstore.subsystem.mysqlsubsystem.MySQLWishlistDAO;
import bookstore.subsystem.mysqlsubsystem.MySQLConnector;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/RemoveAllFromWishlistServlet")
public class RemoveAllFromWishlistServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the user ID from the request parameter
            int userId = Integer.parseInt(request.getParameter("userId"));

            // Remove all books from the user's wishlist
            IWishlistDAO wishlistDAO = new MySQLWishlistDAO(MySQLConnector.getConnection());
            wishlistDAO.removeAllBookFromWishlist(userId);

            // Return a successful response
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            // Return an error response if an exception occurs
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}