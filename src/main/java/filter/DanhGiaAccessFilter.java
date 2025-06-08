package filter;

import controller.BaseController;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.nguoiDung;

import java.io.IOException;

@WebFilter("/danhGia/*")
public class DanhGiaAccessFilter implements Filter
 {

     public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
             throws IOException, ServletException {

         HttpServletRequest req = (HttpServletRequest) request;
         HttpServletResponse resp = (HttpServletResponse) response;

         HttpSession session = req.getSession(false);
         nguoiDung nd = (session != null) ? (nguoiDung) session.getAttribute("nguoiDung") : null;
         String vaiTro = (nd != null) ? String.valueOf(nd.getVaiTroNguoiDung()) : null;

         String path = req.getPathInfo();
         if (path == null) path = "";

         if (vaiTro == null) {
             resp.sendRedirect(req.getContextPath() + "/accessFilter/accessDenied");
             return;
         }

         boolean khachHang = "KHACH_HANG".equals(vaiTro);
         boolean nhanVienOrQuanLy = "NHAN_VIEN".equals(vaiTro) || "QUAN_LY".equals(vaiTro);

         if (isKhachHangOnly(path)) {
             if (!khachHang) {
                 resp.sendRedirect(req.getContextPath() + "/accessFilter/accessDenied");
                 return;
             }
         } else {
             if (!nhanVienOrQuanLy) {
                 resp.sendRedirect(req.getContextPath() + "/accessFilter/accessDenied");
                 return;
             }
         }

         chain.doFilter(request, response);
     }

     private boolean isKhachHangOnly(String path) {
         return path.equals("/taoDanhGia") ||
                 path.equals("/chinhSuaDanhGia") ||
                 path.equals("/xoaDanhGia");
     }

 }