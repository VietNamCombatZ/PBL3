package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

abstract public class BaseController extends HttpServlet {
    protected void render(HttpServletRequest req, HttpServletResponse resp, String contentPage, String layout) throws ServletException, IOException {
        req.setAttribute("contentPage", "/WEB-INF/pages" + contentPage + "/index.jsp");
        System.out.println("/WEB-INF/pages" + contentPage + "/index.jsp");
        String path = "/WEB-INF/layouts/" + layout + ".jsp";
        req.getRequestDispatcher(path).forward(req, resp);
    }

    protected void render(HttpServletRequest req, HttpServletResponse resp, String file) throws ServletException, IOException {
        System.out.println("file: " + file);
        String path ="/WEB-INF/"+ file+".jsp";
        System.out.println("path: " + path);
        req.getRequestDispatcher(path).forward(req, resp);
    }
}
