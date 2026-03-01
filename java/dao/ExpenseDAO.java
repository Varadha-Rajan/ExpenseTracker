package dao;

import model.Expense;
import utils.DBUtil;

import java.sql.*;
import java.util.*;

public class ExpenseDAO {

    public boolean addExpense(Expense e) throws SQLException {
        String sql = "INSERT INTO expenses(user_id, date, category, amount, notes) VALUES(?,?,?,?,?)";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, e.getUserId());
            ps.setDate(2, new java.sql.Date(e.getDate().getTime()));
            ps.setString(3, e.getCategory());
            ps.setDouble(4, e.getAmount());
            ps.setString(5, e.getNotes());
            return ps.executeUpdate() == 1;
        }
    }

    public List<Expense> getExpensesByUser(int userId) throws SQLException {
        String sql = "SELECT * FROM expenses WHERE user_id=? ORDER BY date DESC";
        List<Expense> list = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Expense e = new Expense();
                e.setId(rs.getInt("id"));
                e.setUserId(rs.getInt("user_id"));
                e.setDate(rs.getDate("date"));
                e.setCategory(rs.getString("category"));
                e.setAmount(rs.getDouble("amount"));
                e.setNotes(rs.getString("notes"));
                list.add(e);
            }
        }
        return list;
    }

    public Expense getById(int id, int userId) throws SQLException {
        String sql = "SELECT * FROM expenses WHERE id=? AND user_id=?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Expense e = new Expense();
                e.setId(rs.getInt("id"));
                e.setUserId(rs.getInt("user_id"));
                e.setDate(rs.getDate("date"));
                e.setCategory(rs.getString("category"));
                e.setAmount(rs.getDouble("amount"));
                e.setNotes(rs.getString("notes"));
                return e;
            }
        }
        return null;
    }

    public boolean updateExpense(Expense e) throws SQLException {
        String sql = "UPDATE expenses SET date=?, category=?, amount=?, notes=? WHERE id=? AND user_id=?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setDate(1, new java.sql.Date(e.getDate().getTime()));
            ps.setString(2, e.getCategory());
            ps.setDouble(3, e.getAmount());
            ps.setString(4, e.getNotes());
            ps.setInt(5, e.getId());
            ps.setInt(6, e.getUserId());
            return ps.executeUpdate() == 1;
        }
    }

    public boolean deleteExpense(int id, int userId) throws SQLException {
        String sql = "DELETE FROM expenses WHERE id=? AND user_id=?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            return ps.executeUpdate() == 1;
        }
    }
}
