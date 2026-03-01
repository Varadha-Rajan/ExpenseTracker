package servlet;

import dao.BudgetDAO;
import model.Budget;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/editBudget")
public class EditBudgetServlet extends HttpServlet {
    private final BudgetDAO dao = new BudgetDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) { resp.sendRedirect("login.jsp"); return; }
        User u = (User) s.getAttribute("user");
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            Budget b = dao.getBudgetById(id, u.getId());
            if (b == null) { resp.sendRedirect("viewBudgets"); return; }
            req.setAttribute("budget", b);
            req.getRequestDispatcher("/budgets/editBudget.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        User u = (User) s.getAttribute("user");
        try {
            Budget b = new Budget();
            b.setId(Integer.parseInt(req.getParameter("id")));
            b.setUserId(u.getId());
            b.setCategory(req.getParameter("category"));
            b.setPeriodMonth(Integer.parseInt(req.getParameter("month")));
            b.setPeriodYear(Integer.parseInt(req.getParameter("year")));
            b.setAmount(Double.parseDouble(req.getParameter("amount")));
            dao.upsertBudget(b);
            resp.sendRedirect("viewBudgets?month=" + b.getPeriodMonth() + "&year=" + b.getPeriodYear());
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
