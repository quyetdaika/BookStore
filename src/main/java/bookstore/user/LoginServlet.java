package bookstore.user;

import java.io.*;

import bookstore.subsystem.mysqlsubsystem.MySQLUserDAO;
import bookstore.subsystem.iface.IUserDAO;
import bookstore.subsystem.mysqlsubsystem.MySQLConnector;
import bookstore.entities.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            IUserDAO userDAO = new MySQLUserDAO((MySQLConnector.getConnection()));

            HttpSession httpSession = request.getSession();

            String email = request.getParameter("email");
            String password = request.getParameter("password");
            System.out.println(email + " " + password);

            // Lấy bookID nếu có từ request
            String bookID = request.getParameter("bookID");
            System.out.println("bookID : " + bookID);
            if (bookID != null && !bookID.isEmpty()) {
                // Lưu bookID vào session
                httpSession.setAttribute("bookID", bookID);
            }

            if(email.equals("admin@gmail.com") && password.equals("admin")){
                User user = new User();
                user.setEmail("admin@gmail.com");
                user.setPassword("admin");
                httpSession.setAttribute("userObj", user);
                response.sendRedirect("admin/home.jsp");
            } else {
                User user = userDAO.login(email, password);
                if(user != null){
                    httpSession.setAttribute("userObj", user);
                    httpSession.setAttribute("successMsg", "Log in successfully");
                    // Đăng nhập thành công, kiểm tra nếu có bookID thì chuyển hướng đến trang sản phẩm
                    if (bookID != null && !bookID.isEmpty()) {
                        response.sendRedirect("product-detail.jsp?bookID=" + bookID);
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                } else {
                    httpSession.setAttribute("failedMsg", "Email or Password incorrect");
                    response.sendRedirect("login.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
