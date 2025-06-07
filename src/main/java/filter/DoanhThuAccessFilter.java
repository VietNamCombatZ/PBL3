package filter;

import controller.BaseController;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.nguoiDung;

import java.io.IOException;

@WebFilter("/doanhThu/*")
public class DoanhThuAccessFilter implements Filter
{

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        nguoiDung nd = (session != null) ? (nguoiDung) session.getAttribute("nguoiDung") : null;

//        String vaiTro = (session != null) ? (String) session.getAttribute("vaiTro") : null;

        String vaiTro = (nd != null) ? String.valueOf(nd.getVaiTroNguoiDung()) : null; // Lấy vai trò từ đối tượng nguoiDung
        String path = req.getPathInfo(); // Ví dụ: /taoDanhGia, /xemDanhGiaCuaKhachHang

        // Nếu chưa đăng nhập
        if (vaiTro == null) {
            resp.sendRedirect(req.getContextPath() + "/accessFilter/accessDenied");
            return;
        }

        // Check theo từng chức năng cụ thể

            // Các chức năng còn lại chỉ cho NV/QL
            if (!vaiTro.equals("QUAN_LY")) {
                resp.sendRedirect(req.getContextPath() + "/accessFilter/accessDenied");
                return;
            }


        // Cho phép tiếp tục nếu hợp lệ
        chain.doFilter(request, response);
    }
}