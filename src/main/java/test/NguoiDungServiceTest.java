package test;
//
//import static org.junit.jupiter.api.Assertions.*;
//import static org.mockito.Mockito.*;
//
//import model.nguoiDung;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.MockitoAnnotations;
//import service.NguoiDungService;
//import DAO.NguoiDungDAO;
//import controller.*;

class NguoiDungServiceTest {

//    @Mock
//    private NguoiDungDAO nguoiDungDAO;
//
//    @InjectMocks
//    private NguoiDungService nguoiDungService;
//
//    @BeforeEach
//    void setUp() {
//        MockitoAnnotations.openMocks(this);
//    }
//
////    @Test
////    void testDangKyThanhCong() {
////        // Arrange
////        nguoiDung newUser = new nguoiDung();
////        newUser.setTenDangNhap("testuser");
////        newUser.setMatKhau("password123");
////        when(nguoiDungDAO.timNguoiDungTheoTenDangNhap("testuser")).thenReturn(null);
////        when(nguoiDungDAO.themNguoiDung(newUser)).thenReturn(true);
////
////        // Act
////        boolean result = nguoiDungService.dangKy(newUser);
////
////        // Assert
////        assertTrue(result, "Đăng ký nên thành công khi tên đăng nhập chưa tồn tại.");
////        verify(nguoiDungDAO, times(1)).themNguoiDung(newUser);
////    }
//
////    @Test
////    void testDangKyThatBai_TenDangNhapDaTonTai() {
////        // Arrange
////        nguoiDung existingUser = new nguoiDung();
////        existingUser.setTenDangNhap("testuser");
////        when(nguoiDungDAO.timNguoiDungTheoTenDangNhap("testuser")).thenReturn(existingUser);
////
////        nguoiDung newUser = new nguoiDung();
////        newUser.setTenDangNhap("testuser");
////        newUser.setMatKhau("password123");
////
////        // Act
////        boolean result = nguoiDungService.dangKy(newUser);
////
////        // Assert
////        assertFalse(result, "Đăng ký nên thất bại khi tên đăng nhập đã tồn tại.");
////        verify(nguoiDungDAO, never()).themNguoiDung(newUser);
////    }
//
//    @Test
//    void testDangNhapThanhCong_VoiEmailVaMatKhau() {
//        // Arrange
//        nguoiDung existingUser = new nguoiDung();
//        existingUser.setEmail("d@gmail.com");
//        existingUser.setMatKhau("123456");
//        when(nguoiDungDAO.timNguoiDungTheoEmail("d@gmail.com")).thenReturn(existingUser);
//
//        // Act
//        nguoiDung result = NguoiDungController.dangNhap("d@gmail.com", "123456");
//
//        // Assert
//        assertNotNull(result, "Đăng nhập nên thành công với email và mật khẩu hợp lệ.");
//        assertEquals("d@gmail.com", result.getEmail());
//    }
//
//    @Test
//    void testDangNhapThatBai_SaiMatKhau() {
//        // Arrange
//        nguoiDung existingUser = new nguoiDung();
//        existingUser.setTenDangNhap("testuser");
//        existingUser.setMatKhau("password123");
//        when(nguoiDungDAO.timNguoiDungTheoTenDangNhap("testuser")).thenReturn(existingUser);
//
//        // Act
//        nguoiDung result = nguoiDungService.dangNhap("testuser", "wrongpassword");
//
//        // Assert
//        assertNull(result, "Đăng nhập nên thất bại khi mật khẩu không đúng.");
//    }
//
//    @Test
//    void testDangNhapThatBai_TenDangNhapKhongTonTai() {
//        // Arrange
//        when(nguoiDungDAO.timNguoiDungTheoTenDangNhap("nonexistentuser")).thenReturn(null);
//
//        // Act
//        nguoiDung result = nguoiDungService.dangNhap("nonexistentuser", "password123");
//
//        // Assert
//        assertNull(result, "Đăng nhập nên thất bại khi tên đăng nhập không tồn tại.");
//    }
}
