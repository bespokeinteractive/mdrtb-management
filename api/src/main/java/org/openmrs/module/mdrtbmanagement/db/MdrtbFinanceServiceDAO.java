package org.openmrs.module.mdrtbmanagement.db;

import org.openmrs.Location;
import org.openmrs.module.mdrtbmanagement.Budgets;
import org.openmrs.module.mdrtbmanagement.BudgetsItems;
import org.openmrs.module.mdrtbmanagement.Charts;
import org.openmrs.module.mdrtbmanagement.Disbursements;

import java.util.List;

/**
 * Created by Dennis Henry
 * Created on 11/6/2017.
 */
public interface MdrtbFinanceServiceDAO {
    Charts getChart(Integer item);

    List<Charts> getParentCharts();
    List<Charts> getChildrenCharts(Charts chart);

    List<Budgets> getBudgets(List<Location> locations, Boolean drafts);
    Budgets getBudget(Integer id);
    Budgets getBudget(String period, Location location);
    Budgets saveBudgets(Budgets budget);

    List<BudgetsItems> getBudgetItems(Budgets budget);
    BudgetsItems getBudgetItem(Budgets budget, Charts item);
    BudgetsItems saveBudgetItems(BudgetsItems bi);
    void deleteBudgetItems(BudgetsItems bi);

    List<Disbursements> getDisbursements(List<Location> locations, Boolean approved);
    Disbursements getDisbursement(Integer id);
    Disbursements saveDisbursement(Disbursements disbursement);
}