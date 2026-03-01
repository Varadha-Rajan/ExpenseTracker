package servlet;

import dao.ExpenseDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/viewExpenses")
public class ViewExpenseServlet extends HttpServlet {
    private final ExpenseDAO dao = new ExpenseDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        User u = (User) s.getAttribute("user");
        try {
            req.setAttribute("expenses", dao.getExpensesByUser(u.getId()));
            req.getRequestDispatcher("expenses/viewExpenses.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
