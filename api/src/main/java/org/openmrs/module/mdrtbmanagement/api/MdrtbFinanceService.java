package org.openmrs.module.mdrtbmanagement.api;

import org.openmrs.Location;
import org.openmrs.api.OpenmrsService;
import org.openmrs.module.mdrtbmanagement.Budgets;
import org.openmrs.module.mdrtbmanagement.BudgetsItems;
import org.openmrs.module.mdrtbmanagement.Charts;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/6/2017.
 */

@Transactional
public interface MdrtbFinanceService
        extends OpenmrsService {
    Charts getChart(Integer item);
    List<Charts> getCharts();
    List<Charts> getParentCharts();
    List<Charts> getChildrenCharts(Charts chart);

    List<Budgets> getBudgets(List<Location> locations, Boolean drafts);
    Budgets saveBudgets(Budgets budget);
    BudgetsItems saveBudgetItems(BudgetsItems bi);
}
