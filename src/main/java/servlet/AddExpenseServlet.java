package servlet;

import dao.ExpenseDAO;
import model.Expense;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

@WebServlet("/addExpense")
public class AddExpenseServlet extends HttpServlet {
    private final ExpenseDAO dao = new ExpenseDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        User u = (User) s.getAttribute("user");
        try {
            Expense e = new Expense();
            e.setUserId(u.getId());
            e.setDate(new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("date")));
            e.setCategory(req.getParameter("category"));
            e.setAmount(Double.parseDouble(req.getParameter("amount")));
            e.setNotes(req.getParameter("notes"));
            dao.addExpense(e);
            resp.sendRedirect("viewExpenses");
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
}
