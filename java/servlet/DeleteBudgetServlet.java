package servlet;

import dao.BudgetDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/deleteBudget")
public class DeleteBudgetServlet extends HttpServlet {
    private final BudgetDAO dao = new BudgetDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) { resp.sendRedirect("login.jsp"); return; }
        User u = (User) s.getAttribute("user");
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            dao.deleteBudget(id, u.getId());
            resp.sendRedirect("viewBudgets");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
