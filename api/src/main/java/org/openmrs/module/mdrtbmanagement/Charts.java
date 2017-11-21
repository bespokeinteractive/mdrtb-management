package org.openmrs.module.mdrtbmanagement;

import org.openmrs.User;
import java.util.Date;
import java.util.List;

/**
 * Created by Dennis Henry
 * Created on 11/6/2017.
 */
public class Charts {
    private static final long serialVersionUID = 1L;

    private int id;
    private String code;
    private String name;
    protected Charts chartsGroup;
    private Boolean listed;
    private Boolean voided;
    private User voidedBy;
    private Date voidedOn;
    private String voidReason;

    /*Not Persistence Properties*/
    private Boolean hasChildren;
    private List<Charts> children;
    private float value;

    private Double percentage = 0.0;
    private Double variance = 0.0;
    private Double budget = 0.0;
    private Double expenditure = 0.0;

    private Double budgetQ1 = 0.0;
    private Double budgetQ2 = 0.0;
    private Double budgetQ3 = 0.0;
    private Double budgetQ4 = 0.0;
    private Double budgetYT = 0.0;
    private Double budgetTT = 0.0;

    private Double expenditureQ1 = 0.0;
    private Double expenditureQ2 = 0.0;
    private Double expenditureQ3 = 0.0;
    private Double expenditureQ4 = 0.0;
    private Double expenditureYT = 0.0;
    private Double expenditureTT = 0.0;

    /*Getters and Setters*/
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Charts getChartsGroup() {
        return chartsGroup;
    }

    public void setChartsGroup(Charts chartsGroup) {
        this.chartsGroup = chartsGroup;
    }

    public Boolean getListed() {
        return listed;
    }

    public void setListed(Boolean listed) {
        this.listed = listed;
    }

    public Boolean getVoided() {
        return voided;
    }

    public void setVoided(Boolean voided) {
        this.voided = voided;
    }

    public User getVoidedBy() {
        return voidedBy;
    }

    public void setVoidedBy(User voidedBy) {
        this.voidedBy = voidedBy;
    }

    public Date getVoidedOn() {
        return voidedOn;
    }

    public void setVoidedOn(Date voidedOn) {
        this.voidedOn = voidedOn;
    }

    public String getVoidReason() {
        return voidReason;
    }

    public void setVoidReason(String voidReason) {
        this.voidReason = voidReason;
    }

    public List<Charts> getChildren() {
        return children;
    }

    public void setChildren(List<Charts> children) {
        this.children = children;
    }

    public Boolean getHasChildren() {
        return hasChildren;
    }

    public void setHasChildren(Boolean hasChildren) {
        this.hasChildren = hasChildren;
    }

    public float getValue() {
        return value;
    }

    public void setValue(float value) {
        this.value = value;
    }

    public Double getBudgetQ1() {
        return budgetQ1;
    }

    public void setBudgetQ1(Double budgetQ1) {
        this.budgetQ1 = budgetQ1;
    }

    public Double getBudgetQ2() {
        return budgetQ2;
    }

    public void setBudgetQ2(Double budgetQ2) {
        this.budgetQ2 = budgetQ2;
    }

    public Double getBudgetQ3() {
        return budgetQ3;
    }

    public void setBudgetQ3(Double budgetQ3) {
        this.budgetQ3 = budgetQ3;
    }

    public Double getBudgetQ4() {
        return budgetQ4;
    }

    public void setBudgetQ4(Double budgetQ4) {
        this.budgetQ4 = budgetQ4;
    }

    public Double getExpenditureQ1() {
        return expenditureQ1;
    }

    public void setExpenditureQ1(Double expenditureQ1) {
        this.expenditureQ1 = expenditureQ1;
    }

    public Double getExpenditureQ2() {
        return expenditureQ2;
    }

    public void setExpenditureQ2(Double expenditureQ2) {
        this.expenditureQ2 = expenditureQ2;
    }

    public Double getExpenditureQ3() {
        return expenditureQ3;
    }

    public void setExpenditureQ3(Double expenditureQ3) {
        this.expenditureQ3 = expenditureQ3;
    }

    public Double getExpenditureQ4() {
        return expenditureQ4;
    }

    public void setExpenditureQ4(Double expenditureQ4) {
        this.expenditureQ4 = expenditureQ4;
    }

    public Double getVariance() {
        return variance;
    }

    public void setVariance(Double variance) {
        this.variance = variance;
    }

    public Double getPercentage() {
        return percentage;
    }

    public void setPercentage(Double percentage) {
        this.percentage = percentage;
    }

    public Double getBudget() {
        return budget;
    }

    public void setBudget(Double budget) {
        this.budget = budget;
    }

    public Double getExpenditure() {
        return expenditure;
    }

    public void setExpenditure(Double expenditure) {
        this.expenditure = expenditure;
    }

    public Double getBudgetYT() {
        return budgetYT;
    }

    public void setBudgetYT(Double budgetYT) {
        this.budgetYT = budgetYT;
    }

    public Double getBudgetTT() {
        return budgetTT;
    }

    public void setBudgetTT(Double budgetTT) {
        this.budgetTT = budgetTT;
    }

    public Double getExpenditureYT() {
        return expenditureYT;
    }

    public void setExpenditureYT(Double expenditureYT) {
        this.expenditureYT = expenditureYT;
    }

    public Double getExpenditureTT() {
        return expenditureTT;
    }

    public void setExpenditureTT(Double expenditureTT) {
        this.expenditureTT = expenditureTT;
    }
}
