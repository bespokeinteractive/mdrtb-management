package org.openmrs.module.mdrtbmanagement.fragment.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.module.mdrtbmanagement.model.Budgets;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/8/2017.
 */
public class FinancebudgetFragmentController {
    public List<SimpleObject> listCurrentBudgets(@RequestParam(value = "draft") Boolean draft,
                                                 UiUtils ui){
        List<Location> locations = new ArrayList<Location>();
        List<Budgets> budgets = Context.getService(MdrtbFinanceService.class).getBudgets(null, draft);

        System.out.println("Test" + budgets.size());

        for (Location location: Context.getLocationService().getAllLocations()){
            locations.add(location);
        }

        if (budgets!=null){
            return SimpleObject.fromCollection(budgets, ui, "id", "location.name", "dated", "period", "amount");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }
}
