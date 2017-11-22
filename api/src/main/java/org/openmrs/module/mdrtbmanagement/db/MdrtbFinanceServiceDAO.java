package org.openmrs.module.mdrtbmanagement.db;

import org.openmrs.Location;
import org.openmrs.module.mdrtb.model.LocationCentres;
import org.openmrs.module.mdrtb.model.LocationCentresAgencies;
import org.openmrs.module.mdrtbmanagement.*;

import java.util.Date;
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
    Disbursements getDisbursement(String period, LocationCentresAgencies agency);
    Disbursements saveDisbursement(Disbursements disbursement);

    List<DisbursementsDetails> getDisbursementsDetails(Disbursements disbursement);
    DisbursementsDetails getDisbursementsDetail(Integer id);
    DisbursementsDetails getDisbursementsDetail(Disbursements disbursement, LocationCentres centre);
    DisbursementsDetails saveDisbursementsDetails(DisbursementsDetails details);
    void deleteDisbursementsDetail(DisbursementsDetails dd);

    //Ledgers
    List<Ledgers> getLedgers(List<Location> locations, String period, Date startdate, Date endDate, Charts item);
    List<LedgersSummary> getLedgersSummary(Location location, Integer year);

    //Expenditure
    Expenditure saveExpenditure(Expenditure expenditure);

    //HR
    List<HumanResources> getStaffList(List<Location> locations, Boolean includeTransferred);
    HumanResources getStaff(Integer id);
    HumanResources saveStaff(HumanResources staff);

    //Assets
    List<Assets> getAssets(List<Location> locations);
    Assets getAssets(Integer id);
    Assets saveAssets(Assets asset);

}