package org.openmrs.module.mdrtbmanagement.api;

import org.openmrs.Location;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.openmrs.module.mdrtb.model.LocationCentres;
import org.openmrs.module.mdrtb.model.LocationCentresAgencies;
import org.openmrs.module.mdrtbmanagement.*;
import org.openmrs.module.mdrtbmanagement.db.MdrtbFinanceServiceDAO;

import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/6/2017.
 */
public class MdrtbFinanceServiceImpl
        extends BaseOpenmrsService
        implements MdrtbFinanceService{

    private MdrtbFinanceServiceDAO dao;

    public MdrtbFinanceServiceDAO getDao() {
        return dao;
    }

    public void setDao(MdrtbFinanceServiceDAO dao) {
        this.dao = dao;
    }

    public Charts getChart(Integer item){
        return dao.getChart(item);
    }

    public List<Charts> getCharts(){
        List<Charts> charts = getParentCharts();

       for (int i=0; i<charts.size();i++){
           List<Charts> children = getChildrenCharts(charts.get(i));
           charts.get(i).setChildren(children);
           if (children != null && children.size()>0){
               charts.get(i).setHasChildren(true);
           }
           else {
               charts.get(i).setHasChildren(false);
           }
       }

        return charts;
    }

    public List<Charts> getParentCharts(){
        return dao.getParentCharts();
    }

    public List<Charts> getChildrenCharts(Charts chart){
        return dao.getChildrenCharts(chart);
    }

    public List<Budgets> getBudgets(List<Location> locations, Boolean drafts){
        return dao.getBudgets(locations, drafts);
    }

    public Budgets getBudget(Integer id){
        return dao.getBudget(id);
    }

    public Budgets getBudget(String period, Location location){
        return dao.getBudget(period, location);
    }

    public Disbursements getDisbursement(String period, LocationCentresAgencies agency){
        return dao.getDisbursement(period, agency);
    }

    public Budgets saveBudgets(Budgets budget){
        return dao.saveBudgets(budget);
    }

    public List<BudgetsItems> getBudgetItems(Budgets budget){
        return dao.getBudgetItems(budget);
    }

    public BudgetsItems getBudgetItem(Budgets budget, Charts item){
        return dao.getBudgetItem(budget, item);
    }

    public BudgetsItems saveBudgetItems(BudgetsItems bi){
        return dao.saveBudgetItems(bi);
    }

    public void deleteBudgetItems(BudgetsItems bi){
        dao.deleteBudgetItems(bi);
    }

    public List<Disbursements> getDisbursements(List<Location> locations, Boolean approved){
        return dao.getDisbursements(locations, approved);
    }

    public Disbursements getDisbursement(Integer id){
        return dao.getDisbursement(id);
    }

    public Disbursements saveDisbursement(Disbursements disbursement){
        return dao.saveDisbursement(disbursement);
    }

    public List<DisbursementsDetails> getDisbursementsDetails(Disbursements disbursement){
        return dao.getDisbursementsDetails(disbursement);
    }

    public DisbursementsDetails getDisbursementsDetail(Integer id){
        return dao.getDisbursementsDetail(id);
    }

    public DisbursementsDetails getDisbursementsDetail(Disbursements disbursement, LocationCentres centre){
        return dao.getDisbursementsDetail(disbursement, centre);
    }

    public DisbursementsDetails saveDisbursementsDetails(DisbursementsDetails details){
        return dao.saveDisbursementsDetails(details);
    }

    public void deleteDisbursementsDetail(DisbursementsDetails dd){
        dao.deleteDisbursementsDetail(dd);
    }

    public void deleteDisbursementsDetails(Disbursements disbursement){
        List <DisbursementsDetails> details = getDisbursementsDetails(disbursement);
        for (DisbursementsDetails dd : details){
            dao.deleteDisbursementsDetail(dd);
        }
    }
    //Ledgers
    public List<Ledgers> getLedgers(List<Location> locations, String period, Date startdate, Date endDate, Charts item){
        return dao.getLedgers(locations, period, startdate, endDate, item);
    }

    public List<LedgersSummary> getLedgersSummary(Location location, Integer year){
        return dao.getLedgersSummary(location, year);
    }
    public Ledgers getLedgers(Integer id){
        return dao.getLedgers(id);
    }

    //Expenditure
    public Expenditure saveExpenditure(Expenditure expenditure){
        return dao.saveExpenditure(expenditure);
    }

    @Override
    public List<HumanResources> getStaffList(List<Location> locations, Boolean includeTransferred) {
        return dao.getStaffList(locations, includeTransferred);
    }

    @Override
    public HumanResources getStaff(Integer id) {
        return dao.getStaff(id);
    }

    @Override
    public HumanResources saveStaff(HumanResources staff) {
        return dao.saveStaff(staff);
    }

    @Override
    public List<Assets> getAssets(List<Location> locations) {
        return dao.getAssets(locations);
    }

    @Override
    public Assets getAssets(Integer id) {
        return dao.getAssets(id);
    }

    @Override
    public Assets saveAssets(Assets asset) {
        return dao.saveAssets(asset);
    }
}
