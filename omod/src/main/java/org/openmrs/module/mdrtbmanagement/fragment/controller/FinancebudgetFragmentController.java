package org.openmrs.module.mdrtbmanagement.fragment.controller;

import org.apache.commons.lang.StringUtils;
import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.mdrtbmanagement.BudgetsItems;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.module.mdrtbmanagement.Budgets;
import org.openmrs.module.mdrtbmanagement.util.BudgetItemsModel;
import org.openmrs.module.mdrtbmanagement.util.BudgetResultWrapper;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.annotation.BindParams;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.util.*;

/**
 * Created by Dennys Henry
 * Created on 11/8/2017.
 */
public class FinancebudgetFragmentController {
    MdrtbFinanceService financeService = Context.getService(MdrtbFinanceService.class);

    public List<SimpleObject> listCurrentBudgets(@RequestParam(value = "draft") Boolean draft,
                                                 UiUtils ui){
        List<Location> locations = new ArrayList<Location>();
        List<Budgets> budgets = Context.getService(MdrtbFinanceService.class).getBudgets(null, draft);

        for (Location location: Context.getLocationService().getAllLocations()){
            locations.add(location);
        }

        if (budgets!=null){
            return SimpleObject.fromCollection(budgets, ui, "id", "location.name", "dated", "period", "amount");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }

    public SimpleObject addNewBudget(@BindParams("budget") BudgetResultWrapper wrapper,
                                     HttpServletRequest request)
            throws SecurityException, IllegalArgumentException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        Location location = Context.getLocationService().getLocation(wrapper.getFacility());

        //Save Items
        Budgets budget = new Budgets();
        budget.setDated(wrapper.getDate());
        budget.setLocation(location);
        budget.setPeriod("0"+wrapper.getQuarter() + "-" + wrapper.getYear());
        budget.setAmount(wrapper.getAmount());
        budget.setDescription(wrapper.getDescription());

        budget = financeService.saveBudgets(budget);

        for (Map.Entry<String, String[]> params : ((Map<String, String[]>) request.getParameterMap()).entrySet()) {
            if (StringUtils.contains(params.getKey(), "item.")) {
                String value = params.getValue()[0];
                if (StringUtils.isBlank(value) || value.equals("NaN")){
                   continue;
                }

                BudgetsItems bi = new BudgetsItems(budget);
                bi.setItem(financeService.getChart(Integer.parseInt(params.getKey().substring("item.".length()))));
                bi.setBudgetValue(Float.parseFloat(value));
                this.financeService.saveBudgetItems(bi);
            }
        }

        return SimpleObject.create("status", "success", "message", "Facility Budget has been added successfully");
    }
}
