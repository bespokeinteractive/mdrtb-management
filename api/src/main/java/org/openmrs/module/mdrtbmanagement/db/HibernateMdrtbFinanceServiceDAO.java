package org.openmrs.module.mdrtbmanagement.db;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.openmrs.Location;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.mdrtbmanagement.model.Budgets;
import org.openmrs.module.mdrtbmanagement.model.Charts;

import java.security.PublicKey;
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
    public List<Budgets> getFinalBudgets(List<Location> locations, Boolean finals){
        Criteria criteria = getSession().createCriteria(Budgets.class);
        if(finals){
            criteria.add(Restrictions.isNotNull("approvedBy"));
        }
        if(locations !=null){
            criteria.add(Restrictions.in("location",locations));
        }

        return criteria.list();

    }
}