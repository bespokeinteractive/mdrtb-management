package org.openmrs.module.mdrtbmanagement.db;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.openmrs.Location;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.mdrtb.model.LocationCentres;
import org.openmrs.module.mdrtb.model.LocationCentresAgencies;
import org.openmrs.module.mdrtbmanagement.*;

import java.util.Date;
import java.util.List;

/**
 * Created by Dennis Henry
 * Created on 11/6/2017.
 */

public class HibernateMdrtbFinanceServiceDAO
        implements MdrtbFinanceServiceDAO {
    protected final Log log = LogFactory.getLog(getClass());
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) throws DAOException {
        this.sessionFactory = sessionFactory;
    }
    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }
    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public Charts getChart(Integer item){
        Criteria criteria = getSession().createCriteria(Charts.class);
        criteria.add(Restrictions.eq("id", item));

        return  (Charts)criteria.uniqueResult();
    }

    @Override
    public List<Charts> getParentCharts(){
        Criteria criteria = getSession().createCriteria(Charts.class);
        criteria.add(Restrictions.eq("listed", true));
        criteria.add(Restrictions.eq("voided", false));
        criteria.add(Restrictions.isNull("chartsGroup"));

        return criteria.list();
    }

    @Override
    public List<Charts> getChildrenCharts(Charts chart){
        Criteria criteria = getSession().createCriteria(Charts.class);
        criteria.add(Restrictions.eq("listed", true));
        criteria.add(Restrictions.eq("voided", false));
        criteria.add(Restrictions.eq("chartsGroup", chart));
        criteria.add(Restrictions.isNotNull("chartsGroup"));

        criteria.addOrder(Order.asc("code"));
        criteria.addOrder(Order.asc("name"));

        return criteria.list();
    }

    @Override
    public List<Budgets> getBudgets(List<Location> locations, Boolean drafts){
        Criteria criteria = getSession().createCriteria(Budgets.class);
        criteria.add(Restrictions.eq("voided", false));

        if (drafts){
            criteria.add(Restrictions.isNull("approvedOn"));
        }
        else if(!drafts){
            criteria.add(Restrictions.isNotNull("approvedOn"));
        }

        if (locations != null){
            criteria.add(Restrictions.in("location", locations));
        }

        return criteria.list();
    }

    @Override
    public Budgets getBudget(Integer id){
        Criteria criteria = getSession().createCriteria(Budgets.class);
        criteria.add(Restrictions.eq("id", id));

        return  (Budgets)criteria.uniqueResult();
    }

    @Override
    public Budgets getBudget(String period, Location location){
        Criteria criteria = getSession().createCriteria(Budgets.class);
        criteria.add(Restrictions.eq("period", period));
        criteria.add(Restrictions.eq("location", location));

        return  (Budgets)criteria.uniqueResult();
    }

    @Override
    public Disbursements getDisbursement(String period, LocationCentresAgencies agency){
        Criteria criteria = getSession().createCriteria(Disbursements.class);
        criteria.add(Restrictions.eq("period", period));
        criteria.add(Restrictions.eq("agency", agency));

        return  (Disbursements) criteria.uniqueResult();
    }

    @Override
    public Budgets saveBudgets(Budgets budget){
        return (Budgets)getSession().merge(budget);
    }

    @Override
    public List<BudgetsItems> getBudgetItems(Budgets budget){
        Criteria criteria = getSession().createCriteria(BudgetsItems.class);
        criteria.add(Restrictions.eq("budget", budget));

        return criteria.list();
    }

    @Override
    public BudgetsItems getBudgetItem(Budgets budget, Charts item){
        Criteria criteria = getSession().createCriteria(BudgetsItems.class);
        criteria.add(Restrictions.eq("budget", budget));
        criteria.add(Restrictions.eq("item", item));

        return (BudgetsItems)criteria.uniqueResult();
    }

    @Override
    public BudgetsItems saveBudgetItems(BudgetsItems bi){
        return (BudgetsItems)getSession().merge(bi);
    }

    @Override
    public void deleteBudgetItems(BudgetsItems bi){
        getSession().delete(bi);
    }

    @Override
    public List<Disbursements> getDisbursements(List<Location> locations, Boolean approved){
        Criteria criteria = getSession().createCriteria(Disbursements.class);
        criteria.add(Restrictions.eq("voided", false));

        if (approved != null && approved){
            criteria.add(Restrictions.isNotNull("approvedOn"));
        }
        else if(approved != null && !approved){
            criteria.add(Restrictions.isNull("approvedOn"));
        }

        if (locations != null){
            criteria.add(Restrictions.in("location", locations));
        }

        return criteria.list();
    }

    @Override
    public Disbursements getDisbursement(Integer id){
        Criteria criteria = getSession().createCriteria(Disbursements.class);
        criteria.add(Restrictions.eq("id", id));

        return (Disbursements)criteria.uniqueResult();
    }

    @Override
    public Disbursements saveDisbursement(Disbursements disbursement){
        return (Disbursements)getSession().merge(disbursement);
    }

    @Override
    public List<DisbursementsDetails> getDisbursementsDetails(Disbursements disbursement){
        Criteria criteria = getSession().createCriteria(DisbursementsDetails.class);
        criteria.add(Restrictions.eq("disbursement", disbursement));

        return criteria.list();
    }

    @Override
    public DisbursementsDetails getDisbursementsDetail(Integer id){
        Criteria criteria = getSession().createCriteria(DisbursementsDetails.class);
        criteria.add(Restrictions.eq("id", id));

        return  (DisbursementsDetails) criteria.uniqueResult();
    }

    @Override
    public DisbursementsDetails getDisbursementsDetail(Disbursements disbursement, LocationCentres centre){
        Criteria criteria = getSession().createCriteria(DisbursementsDetails.class);
        criteria.add(Restrictions.eq("disbursement", disbursement));
        criteria.add(Restrictions.eq("centre", centre));

        return  (DisbursementsDetails) criteria.uniqueResult();
    }

    @Override
    public DisbursementsDetails saveDisbursementsDetails(DisbursementsDetails details){
        return (DisbursementsDetails)getSession().merge(details);
    }

    @Override
    public void deleteDisbursementsDetail(DisbursementsDetails dd){
        getSession().delete(dd);
    }

    @Override
    public List<Ledgers> getLedgers(List<Location> locations, String period, Date startdate, Date enddate, Charts item){
        Criteria criteria = getSession().createCriteria(Ledgers.class);
        if (locations != null){
            criteria.add(Restrictions.in("location", locations));
        }
        //Period (AnyPart {QTR/YEAR})
        if (StringUtils.isNotBlank(period)){
            criteria.add(Restrictions.like("period", period, MatchMode.ANYWHERE));
        }
        //Date Range
        if (startdate != null && enddate != null){
            criteria.add(Restrictions.between("date", startdate, enddate));
        }
        else if(startdate != null){
            criteria.add(Restrictions.ge("date", startdate));
        }
        else if(enddate != null){
            criteria.add(Restrictions.le("date", enddate));
        }

        criteria.addOrder(Order.asc("date"));
        criteria.addOrder(Order.asc("order"));
        criteria.setMaxResults(200);

        return criteria.list();
    }

    @Override
    public Expenditure saveExpenditure(Expenditure expenditure){
        return (Expenditure)getSession().merge(expenditure);
    }

    @Override
    public List<LedgersSummary> getLedgersSummary(Location location, Integer year){
        Criteria criteria = getSession().createCriteria(LedgersSummary.class);
        criteria.add(Restrictions.eq("location", location));
        criteria.add(Restrictions.eq("year", year));

        return criteria.list();
    }

    @Override
    public Ledgers getLedgers(Integer id){
        Criteria criteria = getSession().createCriteria(Ledgers.class);
        criteria.add(Restrictions.eq("id", id));
        return (Ledgers) criteria.uniqueResult();
    }

    @Override
    public List<HumanResources> getStaffList(List<Location> locations, Boolean includeTransferred) {
        Criteria criteria = getSession().createCriteria(HumanResources.class);
        criteria.add(Restrictions.eq("voided", false));
        criteria.add(Restrictions.in("location", locations));

        if (includeTransferred){
            criteria.add(Restrictions.isNotNull("transferredOn"));
        }
        else {
            criteria.add(Restrictions.isNull("transferredOn"));
        }

        return criteria.list();
    }

    @Override
    public HumanResources getStaff(Integer id) {
        Criteria criteria = getSession().createCriteria(HumanResources.class);
        criteria.add(Restrictions.eq("id", id));

        return  (HumanResources) criteria.uniqueResult();
    }

    @Override
    public HumanResources saveStaff(HumanResources staff) {
        return (HumanResources)getSession().merge(staff);
    }

    @Override
    public List<Assets> getAssets(List<Location> locations) {
        Criteria criteria = getSession().createCriteria(Assets.class);
        criteria.add(Restrictions.eq("voided", false));
        criteria.add(Restrictions.in("location", locations));

        return criteria.list();
    }

    @Override
    public Assets getAssets(Integer id) {
        Criteria criteria = getSession().createCriteria(Assets.class);
        criteria.add(Restrictions.eq("id", id));

        return  (Assets) criteria.uniqueResult();
    }

    @Override
    public Assets saveAssets(Assets asset) {
        return (Assets)getSession().merge(asset);
    }
}