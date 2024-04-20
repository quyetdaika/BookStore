package bookstore.user.servlet;

import java.io.*;

import bookstore.DAO.UserDAOImpl;
import bookstore.DB.DBConnect;
import bookstore.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String agreeTerms = request.getParameter("agreeTerms");


            System.out.println(name + " " + email + " " + password + " " + agreeTerms);

            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);

            HttpSession httpSession = request.getSession();

            UserDAOImpl userDAO = new UserDAOImpl(DBConnect.getConnection());
            boolean res = userDAO.userRegister(user);
            if(res) {
                httpSession.setAttribute("successMsg", "User Registration Success");
                response.sendRedirect("register.jsp");
            } else {
                httpSession.setAttribute("failedMsg", "Something wrong on server");
                response.sendRedirect("register.jsp");
            }
        } catch (Exception e) {

        }
    }
}