package servlet;

import dao.BudgetDAO;
import model.Budget;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/setBudget")
public class SetBudgetServlet extends HttpServlet {
    private final BudgetDAO dao = new BudgetDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // show set budget page (with optional existing value)
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) { resp.sendRedirect("login.jsp"); return; }
        req.getRequestDispatcher("/budgets/setBudget.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) { resp.sendRedirect("login.jsp"); return; }
        User u = (User) s.getAttribute("user");

        try {
            String category = req.getParameter("category").trim();
            int month = Integer.parseInt(req.getParameter("month"));
            int year = Integer.parseInt(req.getParameter("year"));
            double amount = Double.parseDouble(req.getParameter("amount"));

            Budget b = new Budget();
            b.setUserId(u.getId());
            b.setCategory(category);
            b.setPeriodMonth(month);
            b.setPeriodYear(year);
            b.setAmount(amount);

            dao.upsertBudget(b);
            resp.sendRedirect("viewBudgets?month=" + month + "&year=" + year);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
