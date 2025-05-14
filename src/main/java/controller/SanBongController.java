package controller;

import DAO.NguoiDungDAO;

import model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import DAO.*;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/sanBong/*")
public class SanBongController extends HttpServlet{

//    @WebServlet("/getAvailableFields")
//    public class GetAvailableFieldsServlet extends HttpServlet {
//        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
//            String timestampStr = request.getParameter("timestamp");
//            System.out.println("thoi gian: "+ timestampStr);// nhận từ JS
//            Timestamp timestamp = Timestamp.valueOf(timestampStr);
//
//            List<sanBong> availableFields = SanBongDAO.LayDanhSachSanCoSan(timestamp); // gọi service xử lý logic
//
//            response.setContentType("application/json");
//            response.setCharacterEncoding("UTF-8");
//
//            PrintWriter out = response.getWriter();
//            StringBuilder json = new StringBuilder();
//            json.append("{ \"fields\": [");
//
//            for (int i = 0; i < availableFields.size(); i++) {
//                sanBong field = availableFields.get(i);
//                json.append("{")
//                        .append("\"id\":\"").append(field.getId()).append("\",")
//                        .append("\"name\":\"").append(field.getTenSan()).append("\"")
//                        .append("}");
//
//                if (i < availableFields.size() - 1) {
//                    json.append(",");
//                }
//            }
//
//            json.append("] }");
//            out.print(json.toString());
//
//            out.flush();
//        }
//    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        System.out.println("Path: " + path);

        switch (path) {
            case "/getAvailableFields":
                getAvailableFields(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }


    }

    private void getAvailableFields(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String timestampStr = req.getParameter("timestamp");
            System.out.println("thoi gian: " + timestampStr);

            Timestamp timestamp = Timestamp.valueOf(timestampStr);

            List<sanBong> availableFields = SanBongDAO.LayDanhSachSanCoSan(timestamp);

            System.out.println("Available fields: " + availableFields.size());

            // Gán dữ liệu vào request để JSP có thể hiển thị
            req.setAttribute("availableFields", availableFields);
            req.setAttribute("selectedTime", timestampStr);

            // Forward về lại trang JSP để hiển thị dữ liệu
            req.getRequestDispatcher("/testDatSan.jsp").forward(req, resp);

        } catch (Exception e) {
            System.out.println("Đã xảy ra lỗi trong getAvailableFields:");
            e.printStackTrace();
            req.setAttribute("error", "Lỗi xử lý dữ liệu");
            req.getRequestDispatcher("/testDatSan.jsp").forward(req, resp);
        }
    }


}



