package bookstore.wishlist;

import bookstore.subsystem.iface.ICartDAO;
import bookstore.subsystem.mysqlsubsystem.MySQLCartDAO;
import bookstore.subsystem.iface.IWishlistDAO;
import bookstore.subsystem.mysqlsubsystem.MySQLWishlistDAO;
import bookstore.subsystem.mysqlsubsystem.MySQLConnector;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/AddAllToCartServlet")
public class AddAllToCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the user ID and book IDs from the request parameters
            int userId = Integer.parseInt(request.getParameter("userId"));
            List<Integer> bookIds = Arrays.stream(request.getParameter("bookIds").split(","))
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());

            // Add all books to the user's cart
            ICartDAO cartDAO = new MySQLCartDAO(MySQLConnector.getConnection());
            IWishlistDAO wishlistDAO = new MySQLWishlistDAO(MySQLConnector.getConnection());
            cartDAO.addAllBookToCart(userId, bookIds);
            wishlistDAO.removeAllBookFromWishlist(userId);

            // Return the updated cart quantity
            int cartQuantity = cartDAO.getSumQuantity(userId);
            response.getWriter().write(String.valueOf(cartQuantity));
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            // Return an error response if an exception occurs
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}