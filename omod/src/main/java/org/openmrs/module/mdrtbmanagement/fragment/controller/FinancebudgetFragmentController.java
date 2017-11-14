package org.openmrs.module.mdrtbmanagement.fragment.controller;

import org.apache.commons.lang.StringUtils;
import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.mdrtbmanagement.BudgetsItems;
import org.openmrs.module.mdrtbmanagement.Charts;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.module.mdrtbmanagement.Budgets;
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
            return SimpleObject.fromCollection(budgets, ui, "id", "location.name", "dated", "period", "amount", "approved", "approvedOn");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }

    public SimpleObject addNewBudget(@BindParams("budget") BudgetResultWrapper wrapper,
                                     HttpServletRequest request)
            throws SecurityException, IllegalArgumentException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        Location location = Context.getLocationService().getLocation(wrapper.getFacility());
        String period = "0"+wrapper.getQuarter() + "-" + wrapper.getYear();

        //Save Items
        Budgets budget = financeService.getBudget(period, location);
        if (budget == null){
            budget = new Budgets();
        }
        else {
            return SimpleObject.create("status", "failed", "message", "Facility Budget for that period already exsists");
        }

        budget.setDated(wrapper.getDate());
        budget.setLocation(location);
        budget.setPeriod(period);
        budget.setAmount(new Double(wrapper.getAmount().replace(",", "")));
        budget.setDescription(wrapper.getDescription());

        budget = financeService.saveBudgets(budget);

        for (Map.Entry<String, String[]> params : ((Map<String, String[]>) request.getParameterMap()).entrySet()) {
            if (StringUtils.contains(params.getKey(), "item.")) {
                String value = params.getValue()[0].replace(",", "");
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

    public SimpleObject updateBudget(@BindParams("budget") BudgetResultWrapper wrapper,
                                     HttpServletRequest request){
        Location location = Context.getLocationService().getLocation(wrapper.getFacility());
        Budgets budget = financeService.getBudget(wrapper.getId());
        if (budget.getApprovedOn() != null){
            return SimpleObject.create("status", "failed", "message", "Facility Budget already approved. You can't edit an approved budget");
        }

        budget.setDated(wrapper.getDate());
        budget.setLocation(location);
        budget.setPeriod("0"+wrapper.getQuarter() + "-" + wrapper.getYear());
        budget.setAmount(new Double(wrapper.getAmount().replace(",", "")));
        budget.setDescription(wrapper.getDescription());

        List<BudgetsItems> model = new ArrayList<BudgetsItems>();

        for (Map.Entry<String, String[]> params : ((Map<String, String[]>) request.getParameterMap()).entrySet()) {
            if (StringUtils.contains(params.getKey(), "item.")) {
                Charts item = financeService.getChart(Integer.parseInt(params.getKey().substring("item.".length())));
                BudgetsItems bi = financeService.getBudgetItem(budget, item);
                String value = params.getValue()[0].replace(",", "");

                if (StringUtils.isBlank(value) || value.equals("NaN") || Float.parseFloat(value) == 0){
                    if (bi != null){
                        this.financeService.deleteBudgetItems(bi);
                    }
                }
                else {
                    if (bi == null){
                        bi = new BudgetsItems(budget);
                    }
                    bi.setItem(item);
                    bi.setBudgetValue(Float.parseFloat(value));
                    this.financeService.saveBudgetItems(bi);
                }
            }
        }

        this.financeService.saveBudgets(budget);
        return SimpleObject.create("status", "success", "message", "Facility Budget has been updated successfully");
    }
}
