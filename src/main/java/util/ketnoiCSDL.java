package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ketnoiCSDL {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/quan_ly_san_bong";
    private static final String JDBC_USER = "root"; // Thay bằng username thật
    private static final String JDBC_PASSWORD = "Geeno20904"; // Thay bằng mật khẩu thật

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Nạp driver MySQL
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        System.out.println("Đang kết nối đến CSDL...");
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Đã đóng kết nối CSDL");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
