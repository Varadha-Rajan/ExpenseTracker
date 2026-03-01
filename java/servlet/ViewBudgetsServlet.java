package servlet;

import dao.BudgetDAO;
import model.Budget;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.*;

@WebServlet("/viewBudgets")
public class ViewBudgetsServlet extends HttpServlet {
    private final BudgetDAO dao = new BudgetDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        User u = (User) s.getAttribute("user");

        int month, year;
        String sm = req.getParameter("month"), sy = req.getParameter("year");
        if (sm != null && sy != null) {
            month = Integer.parseInt(sm);
            year = Integer.parseInt(sy);
        } else {
            LocalDate now = LocalDate.now();
            month = now.getMonthValue();
            year = now.getYear();
        }

        try {
            List<Budget> budgets = dao.getBudgetsForUserMonth(u.getId(), month, year);

            // compute spent & percent for each budget and attach as maps
            Map<Integer, Double> spentMap = new HashMap<>();
            Map<Integer, Double> percentMap = new HashMap<>();
            for (Budget b : budgets) {
                double spent = dao.sumExpensesForCategory(u.getId(), b.getCategory(), month, year);
                spentMap.put(b.getId(), spent);
                double percent = 0.0;
                if (b.getAmount() > 0.0) {
                    percent = Math.min(100.0, (spent / b.getAmount()) * 100.0);
                }
                percentMap.put(b.getId(), percent);
            }

            req.setAttribute("budgets", budgets);
            req.setAttribute("month", month);
            req.setAttribute("year", year);
            req.setAttribute("spentMap", spentMap);
            req.setAttribute("percentMap", percentMap);

            req.getRequestDispatcher("/budgets/viewBudgets.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
