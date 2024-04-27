package bookstore.user.servlet;

import java.io.*;

import bookstore.DAO.WishlistDAOIplm;
import bookstore.DB.DBConnect;
import bookstore.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/AddToWishlistServlet")
public class AddToWishlistServlet extends HttpServlet {

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

            // Lấy bookId từ yêu cầu
            int bookId = Integer.parseInt(request.getParameter("bookId"));

            // Thêm sản phẩm vào Wishlist
            WishlistDAOIplm wishlistDAO = new WishlistDAOIplm(DBConnect.getConnection());
            wishlistDAO.addBookToWishlist(user.getId(), bookId);

            // Trả về phản hồi thành công
            int wishlistCount = wishlistDAO.getBookIDs(user.getId()).size();
            response.getWriter().write(String.valueOf(wishlistCount));
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            // Trả về mã lỗi nếu có lỗi xảy ra
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}