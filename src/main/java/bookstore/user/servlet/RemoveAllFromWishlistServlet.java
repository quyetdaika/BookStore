package bookstore.user.servlet;

import bookstore.DAO.WishlistDAOIplm;
import bookstore.DB.DBConnect;
import bookstore.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/RemoveAllFromWishlistServlet")
public class RemoveAllFromWishlistServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the user ID from the request parameter
            int userId = Integer.parseInt(request.getParameter("userId"));

            // Remove all books from the user's wishlist
            WishlistDAOIplm wishlistDAO = new WishlistDAOIplm(DBConnect.getConnection());
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