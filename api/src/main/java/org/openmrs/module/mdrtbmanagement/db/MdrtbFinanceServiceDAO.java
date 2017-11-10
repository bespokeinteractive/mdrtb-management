package org.openmrs.module.mdrtbmanagement.db;

import com.sun.org.apache.xpath.internal.operations.Bool;
import org.openmrs.Location;
import org.openmrs.module.mdrtbmanagement.model.Budgets;
import org.openmrs.module.mdrtbmanagement.model.Charts;

import java.util.List;

/**
 * Created by Dennis Henry
 * Created on 11/6/2017.
 */
public interface MdrtbFinanceServiceDAO {
    List<Charts> getParentCharts();
    List<Charts> getChildrenCharts(Charts chart);

    List<Budgets> getBudgets(List<Location> locations, Boolean drafts);
    List<Budgets> getFinalBudget(List<Location> locations, Boolean finals);
}