package org.openmrs.module.mdrtbmanagement;

import org.openmrs.Location;

/**
 * Created by Dennys Henry
 * Created on 11/19/2017.
 */
public class LedgersSummary {
    private String id;
    private Integer year;
    private Location location;
    private Charts item;
    private Double ExpenseQ1;
    private Double ExpenseQ2;
    private Double ExpenseQ3;
    private Double ExpenseQ4;
    private Double ExpenseTotal;
    private Double BudgetQ1;
    private Double BudgetQ2;
    private Double BudgetQ3;
    private Double BudgetQ4;
    private Double BudgetTotal;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public Charts getItem() {
        return item;
    }

    public void setItem(Charts item) {
        this.item = item;
    }

    public Double getExpenseQ1() {
        return ExpenseQ1;
    }

    public void setExpenseQ1(Double expenseQ1) {
        ExpenseQ1 = expenseQ1;
    }

    public Double getExpenseQ2() {
        return ExpenseQ2;
    }

    public void setExpenseQ2(Double expenseQ2) {
        ExpenseQ2 = expenseQ2;
    }

    public Double getExpenseQ3() {
        return ExpenseQ3;
    }

    public void setExpenseQ3(Double expenseQ3) {
        ExpenseQ3 = expenseQ3;
    }

    public Double getExpenseQ4() {
        return ExpenseQ4;
    }

    public void setExpenseQ4(Double expenseQ4) {
        ExpenseQ4 = expenseQ4;
    }

    public Double getExpenseTotal() {
        return ExpenseTotal;
    }

    public void setExpenseTotal(Double expenseTotal) {
        ExpenseTotal = expenseTotal;
    }

    public Double getBudgetQ1() {
        return BudgetQ1;
    }

    public void setBudgetQ1(Double budgetQ1) {
        BudgetQ1 = budgetQ1;
    }

    public Double getBudgetQ2() {
        return BudgetQ2;
    }

    public void setBudgetQ2(Double budgetQ2) {
        BudgetQ2 = budgetQ2;
    }

    public Double getBudgetQ3() {
        return BudgetQ3;
    }

    public void setBudgetQ3(Double budgetQ3) {
        BudgetQ3 = budgetQ3;
    }

    public Double getBudgetQ4() {
        return BudgetQ4;
    }

    public void setBudgetQ4(Double budgetQ4) {
        BudgetQ4 = budgetQ4;
    }

    public Double getBudgetTotal() {
        return BudgetTotal;
    }

    public void setBudgetTotal(Double budgetTotal) {
        BudgetTotal = budgetTotal;
    }
}
