package org.openmrs.module.mdrtbmanagement;

/**
 * Created by Dennys Henry
 * Created on 11/13/2017.
 */
public class BudgetsItems {
    private int id;
    private Budgets budget;
    private Charts item;
    private float budgetValue;
    private float approvedValue;
    private String budgetComment;
    private String approvedComment;

    public BudgetsItems(){ }

    public BudgetsItems(Budgets budget){
        this.budget = budget;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Budgets getBudget() {
        return budget;
    }

    public void setBudget(Budgets budget) {
        this.budget = budget;
    }

    public Charts getItem() {
        return item;
    }

    public void setItem(Charts item) {
        this.item = item;
    }

    public float getBudgetValue() {
        return budgetValue;
    }

    public void setBudgetValue(float budgetValue) {
        this.budgetValue = budgetValue;
    }

    public float getApprovedValue() {
        return approvedValue;
    }

    public void setApprovedValue(float approvedValue) {
        this.approvedValue = approvedValue;
    }

    public String getBudgetComment() {
        return budgetComment;
    }

    public void setBudgetComment(String budgetComment) {
        this.budgetComment = budgetComment;
    }

    public String getApprovedComment() {
        return approvedComment;
    }

    public void setApprovedComment(String approvedComment) {
        this.approvedComment = approvedComment;
    }
}
