package org.openmrs.module.mdrtbmanagement.db;

import org.openmrs.module.mdrtbmanagement.model.Charts;

import java.util.List;

/**
 * Created by Dennis Henry
 * Created on 11/6/2017.
 */
public interface MdrtbFinanceServiceDAO {
    List<Charts> getParentCharts();
    List<Charts> getChildrenCharts(Charts chart);
}