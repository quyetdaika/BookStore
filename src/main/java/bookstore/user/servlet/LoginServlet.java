package bookstore.user.servlet;

import java.io.*;

import bookstore.DAO.UserDAOImpl;
import bookstore.DB.DBConnect;
import bookstore.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            UserDAOImpl userDAO = new UserDAOImpl(DBConnect.getConnection());

            HttpSession httpSession = request.getSession();

            String email = request.getParameter("email");
            String password = request.getParameter("password");
            System.out.println(email + " " + password);

            if(email.equals("admin@gmail.com") && password.equals("admin")){
                User user = new User();
                httpSession.setAttribute("userObj", user);
                response.sendRedirect("admin/home.jsp");
            } else {
                User user = userDAO.login(email, password);
                if(user != null){
                    httpSession.setAttribute("userObj", user);
                    response.sendRedirect("home.jsp");
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