package servlet;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private final UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        User u = (User) s.getAttribute("user");
        u.setEmail(req.getParameter("email"));
        u.setFullName(req.getParameter("fullName"));
        try {
            if (dao.updateProfile(u))
                req.setAttribute("success", "Profile updated.");
            else req.setAttribute("error", "Update failed.");
            req.getRequestDispatcher("profile.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
