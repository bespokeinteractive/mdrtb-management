package org.openmrs.module.mdrtbmanagement.api;

import org.openmrs.Location;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.openmrs.module.mdrtbmanagement.BudgetsItems;
import org.openmrs.module.mdrtbmanagement.db.MdrtbFinanceServiceDAO;
import org.openmrs.module.mdrtbmanagement.Budgets;
import org.openmrs.module.mdrtbmanagement.Charts;

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

    public Budgets saveBudgets(Budgets budget){
        return dao.saveBudgets(budget);
    }

    public BudgetsItems saveBudgetItems(BudgetsItems bi){
        return dao.saveBudgetItems(bi);
    }
}
