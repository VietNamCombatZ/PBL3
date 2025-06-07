package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import model.nguoiDung;

import java.io.IOException;

@WebFilter("/sanBong/*")
public class SanBongAccessFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        HttpSession session = req.getSession(false);

        nguoiDung nd = (session != null) ? (nguoiDung) session.getAttribute("nguoiDung") : null;
        String vaiTro = (nd != null) ? String.valueOf(nd.getVaiTroNguoiDung()) : null;

        // Các route không yêu cầu kiểm tra quyền
        if (path.equals("/danhSachSanCoSan")) {
            chain.doFilter(request, response);
            return;
        }

        // Nếu chưa đăng nhập
        if (vaiTro == null) {
            resp.sendRedirect(req.getContextPath() + "/accessFilter/accessDenied");
            return;
        }

        // Chỉ cho NHAN_VIEN hoặc QUAN_LY
        if (path.matches("^/(danhSachSanCoSanNhanVien|xemTinhTrangSan)$")) {
            if (!(vaiTro.equals("NHAN_VIEN") || vaiTro.equals("QUAN_LY"))) {
                resp.sendRedirect(req.getContextPath() + "/accessFilter/accessDenied");
                return;
            }
        }

        // Chỉ cho QUAN_LY
        if (path.matches("^/(taoSanBong|chinhSuaThongTinSan)$")) {
            if (!vaiTro.equals("QUAN_LY")) {
                resp.sendRedirect(req.getContextPath() + "/accessFilter/accessDenied");
                return;
            }
        }

        // Nếu mọi điều kiện hợp lệ
        chain.doFilter(request, response);
    }
}
