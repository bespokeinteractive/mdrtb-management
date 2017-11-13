package org.openmrs.module.mdrtbmanagement.db;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.openmrs.Location;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.mdrtbmanagement.Budgets;
import org.openmrs.module.mdrtbmanagement.BudgetsItems;
import org.openmrs.module.mdrtbmanagement.Charts;
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
        criteria.add(Restrictions.eq("voided", false));
        criteria.add(Restrictions.isNull("chartsGroup"));

        return criteria.list();
    }

    @Override
    public List<Charts> getChildrenCharts(Charts chart){
        Criteria criteria = getSession().createCriteria(Charts.class);
        criteria.add(Restrictions.eq("voided", false));
        criteria.add(Restrictions.eq("chartsGroup", chart));
        criteria.add(Restrictions.isNotNull("chartsGroup"));

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
    public Budgets saveBudgets(Budgets budget){
        return (Budgets)getSession().merge(budget);
    }

    @Override
    public BudgetsItems saveBudgetItems(BudgetsItems bi){
        return (BudgetsItems)getSession().merge(bi);
    }
}