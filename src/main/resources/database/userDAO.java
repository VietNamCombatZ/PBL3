package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;


public class userDAO implements DAOInterface extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDao userDao = new UserDao();
        if (userDao.validateUser(email, password)) {
            response.sendRedirect("home.jsp");
        } else {
            response.sendRedirect("login.jsp?error=true");
        }
    }

}