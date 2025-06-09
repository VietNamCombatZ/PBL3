package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import model.nguoiDung;

import java.io.IOException;

@WebFilter("/datSan/*")
public class DatSanAccessFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        nguoiDung nd = (session != null) ? (nguoiDung) session.getAttribute("nguoiDung") : null;
        String vaiTro = (nd != null) ? String.valueOf(nd.getVaiTroNguoiDung()) : null;

        String path = req.getPathInfo();

        if (vaiTro == null) {
            session.setAttribute("error", "Bạn cần đăng nhập để thực hiện chức năng này.");
            resp.sendRedirect(req.getContextPath() + "/nguoiDung/dangNhap");
            return;
        }

        // Các chức năng chỉ dành cho KHÁCH_HANG
        if (isKhachHangOnly(path)) {
            if (!"KHACH_HANG".equals(vaiTro)) {
                resp.sendRedirect(req.getContextPath() + "/accessFilter/accessDenied");
                return;
            }
        } else {
            // Còn lại chỉ cho NHAN_VIEN hoặc QUAN_LY
            if (!("NHAN_VIEN".equals(vaiTro) || "QUAN_LY".equals(vaiTro))) {
                resp.sendRedirect(req.getContextPath() + "/accessFilter/accessDenied");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    private boolean isKhachHangOnly(String path) {
        return path != null && (
                path.equals("/lichDatCaNhan") ||
                        path.equals("/chinhSuaDatSan") ||
                        path.equals("/taoLichDat") ||
                        path.equals("/capNhatLichDatCuaToi") ||
                        path.equals("/huyDatSan")
        );
    }
}
