package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

import model.User;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    // DB settings - change only if your DB host/port/name/user/password change
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/Expance_trackingdb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Varatha@1200";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ensure user logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        User u = (User) session.getAttribute("user");
        int userId = u.getId();

        Map<String, Double> categoryTotals = new LinkedHashMap<>();

        // DB query: sum of amounts per category for this user
        String sql = "SELECT category, SUM(amount) AS total " +
                     "FROM expenses WHERE user_id = ? GROUP BY category ORDER BY total DESC";

        try (Connection con = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String category = rs.getString("category");
                    double total = rs.getDouble("total");
                    categoryTotals.put(category != null ? category : "Uncategorized", total);
                }
            }
        } catch (SQLException ex) {
            // log and continue (we'll show empty data in UI)
            ex.printStackTrace();
            req.setAttribute("reportError", "Unable to load report data.");
        }

        req.setAttribute("data", categoryTotals);
        RequestDispatcher rd = req.getRequestDispatcher("/reports.jsp");
        rd.forward(req, resp);
    }
}
