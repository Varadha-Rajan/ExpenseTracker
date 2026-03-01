package model;

public class Budget {
    private int id;
    private int userId;
    private String category;
    private int periodMonth;
    private int periodYear;
    private double amount;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public int getPeriodMonth() { return periodMonth; }
    public void setPeriodMonth(int periodMonth) { this.periodMonth = periodMonth; }
    public int getPeriodYear() { return periodYear; }
    public void setPeriodYear(int periodYear) { this.periodYear = periodYear; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
}
