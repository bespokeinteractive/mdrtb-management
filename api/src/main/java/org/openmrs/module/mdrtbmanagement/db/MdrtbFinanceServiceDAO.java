package org.openmrs.module.mdrtbmanagement.db;

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
    Budgets saveBudgets(Budgets budget);
}