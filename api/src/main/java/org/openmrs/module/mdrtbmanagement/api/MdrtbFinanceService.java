package org.openmrs.module.mdrtbmanagement.api;

import org.openmrs.Location;
import org.openmrs.api.OpenmrsService;
import org.openmrs.module.mdrtbmanagement.model.Budgets;
import org.openmrs.module.mdrtbmanagement.model.Charts;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/6/2017.
 */

@Transactional
public interface MdrtbFinanceService
        extends OpenmrsService {
    List<Charts> getCharts();
    List<Charts> getParentCharts();
    List<Charts> getChildrenCharts(Charts chart);

    List<Budgets> getBudgets(List<Location> locations, Boolean drafts);
}
