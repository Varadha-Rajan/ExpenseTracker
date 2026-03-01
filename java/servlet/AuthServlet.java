package servlet;

import dao.UserDAO;
import model.User;
import utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        try {
            if ("register".equals(action)) register(req, resp);
            else if ("login".equals(action)) login(req, resp);
            else if ("changePassword".equals(action)) changePassword(req, resp);
            else resp.sendRedirect("login.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void register(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException, ServletException {

        String username = req.getParameter("username").trim();
        if (userDAO.findByUsername(username) != null) {
            req.setAttribute("error", "Username already exists.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        User u = new User();
        u.setUsername(username);
        u.setEmail(req.getParameter("email"));
        u.setFullName(req.getParameter("fullName"));
        u.setPasswordHash(PasswordUtil.hashPassword(req.getParameter("password")));
        u.setRole("USER");

        if (userDAO.createUser(u))
            resp.sendRedirect("login.jsp?msg=registered");
        else {
            req.setAttribute("error", "Registration failed.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }

    private void login(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException, ServletException {

        User u = userDAO.findByUsername(req.getParameter("username"));
        String pass = PasswordUtil.hashPassword(req.getParameter("password"));
        if (u == null || !u.getPasswordHash().equals(pass)) {
            req.setAttribute("error", "Invalid credentials.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        HttpSession s = req.getSession(true);
        s.setAttribute("user", u);
        s.setMaxInactiveInterval(30 * 60);
        resp.sendRedirect("profile.jsp");
    }

    private void changePassword(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException, ServletException {

        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        User u = (User) s.getAttribute("user");

        String current = PasswordUtil.hashPassword(req.getParameter("currentPassword"));
        String newPass = PasswordUtil.hashPassword(req.getParameter("newPassword"));

        if (!u.getPasswordHash().equals(current)) {
            req.setAttribute("errorChange", "Incorrect current password.");
        } else if (userDAO.changePassword(u.getId(), newPass)) {
            u.setPasswordHash(newPass);
            req.setAttribute("successChange", "Password changed successfully.");
        } else req.setAttribute("errorChange", "Failed to change password.");

        req.getRequestDispatcher("profile.jsp").forward(req, resp);
        
    }
}
