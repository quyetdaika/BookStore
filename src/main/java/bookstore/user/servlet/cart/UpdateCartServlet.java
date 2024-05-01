package bookstore.user.servlet.cart;

import bookstore.DAO.CartDAOIplm;
import bookstore.DB.DBConnect;
import bookstore.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the user from the session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userObj");

            // Check if the user is logged in
            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }

            // Get the bookId and quantity from the request
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Update the cart
            CartDAOIplm cartDAO = new CartDAOIplm(DBConnect.getConnection());
            boolean success = cartDAO.updateBookInCart(user.getId(), bookId, quantity);

            // Return the response
            if (success) {
                int cartQty = cartDAO.getSumQuantity(user.getId());
                response.getWriter().write(String.valueOf(cartQty));

                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}