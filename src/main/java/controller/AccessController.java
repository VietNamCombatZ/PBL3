package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/accessFilter")
public class AccessController extends BaseController {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        System.out.println("Path ở doGet: " + path);
//        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);

        switch (path) {
            case "/accessDenied":
                render(req, resp, "accessDenied");
                break;


            default:
                render(req, resp, "accessDenied");
                break;
        }
    }
}