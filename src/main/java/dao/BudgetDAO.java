package dao;

import model.Budget;
import utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BudgetDAO {

    public boolean upsertBudget(Budget b) throws SQLException {
        // try update first
        String upd = "UPDATE budgets SET amount=?, updated_at=NOW() " +
                     "WHERE user_id=? AND period_month=? AND period_year=? AND category=?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(upd)) {
            ps.setDouble(1, b.getAmount());
            ps.setInt(2, b.getUserId());
            ps.setInt(3, b.getPeriodMonth());
            ps.setInt(4, b.getPeriodYear());
            ps.setString(5, b.getCategory());
            int affected = ps.executeUpdate();
            if (affected == 1) return true;
        }

        // insert if update didn't affect
        String ins = "INSERT INTO budgets(user_id, category, period_month, period_year, amount) VALUES(?,?,?,?,?)";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(ins, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, b.getUserId());
            ps.setString(2, b.getCategory());
            ps.setInt(3, b.getPeriodMonth());
            ps.setInt(4, b.getPeriodYear());
            ps.setDouble(5, b.getAmount());
            int affected = ps.executeUpdate();
            if (affected == 1) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) b.setId(rs.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    public List<Budget> getBudgetsForUserMonth(int userId, int month, int year) throws SQLException {
        String sql = "SELECT * FROM budgets WHERE user_id=? AND period_month=? AND period_year=? ORDER BY category";
        List<Budget> out = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, month);
            ps.setInt(3, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Budget b = mapRow(rs);
                    out.add(b);
                }
            }
        }
        return out;
    }

    public Budget getBudgetById(int id, int userId) throws SQLException {
        String sql = "SELECT * FROM budgets WHERE id=? AND user_id=?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean deleteBudget(int id, int userId) throws SQLException {
        String sql = "DELETE FROM budgets WHERE id=? AND user_id=?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            return ps.executeUpdate() == 1;
        }
    }

    private Budget mapRow(ResultSet rs) throws SQLException {
        Budget b = new Budget();
        b.setId(rs.getInt("id"));
        b.setUserId(rs.getInt("user_id"));
        b.setCategory(rs.getString("category"));
        b.setPeriodMonth(rs.getInt("period_month"));
        b.setPeriodYear(rs.getInt("period_year"));
        b.setAmount(rs.getDouble("amount"));
        return b;
    }

    /**
     * Helper: sum of expenses for a user/category in a month/year.
     * We'll query the expenses table (assumes it exists).
     */
    public double sumExpensesForCategory(int userId, String category, int month, int year) throws SQLException {
        String sql = "SELECT SUM(amount) total FROM expenses WHERE user_id=? AND category=? " +
                     "AND MONTH(date)=? AND YEAR(date)=?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, category);
            ps.setInt(3, month);
            ps.setInt(4, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble("total");
            }
        }
        return 0.0;
    }
}
