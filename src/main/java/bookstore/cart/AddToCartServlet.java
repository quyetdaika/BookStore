package bookstore.cart;

import java.io.*;

import bookstore.subsystem.iface.ICartDAO;
import bookstore.subsystem.mysqlsubsystem.MySQLCartDAO;
import bookstore.subsystem.mysqlsubsystem.MySQLConnector;
import bookstore.entities.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy thông tin người dùng từ session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userObj");

            // Kiểm tra xem người dùng đã đăng nhập hay chưa
            if (user == null) {
                // Trả về mã lỗi nếu người dùng chưa đăng nhập
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }

            // Lấy bookId và quantity từ yêu cầu
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Thêm sản phẩm vào giỏ hàng
            ICartDAO cartDAO = new MySQLCartDAO(MySQLConnector.getConnection());
            boolean success = cartDAO.addBookToCart(user.getId(), bookId, quantity);

            // Trả về phản hồi thành công hoặc lỗi
            if (success) {
                int cartQty = cartDAO.getSumQuantity(user.getId());
                response.getWriter().write(String.valueOf(cartQty));

                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Trả về mã lỗi nếu có lỗi xảy ra
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}