package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbmanagement.Budgets;
import org.openmrs.module.mdrtbmanagement.BudgetsItems;
import org.openmrs.module.mdrtbmanagement.Charts;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.module.mdrtbmanagement.util.BudgetItemsModel;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

/**
 * Created by Dennys Henry
 * Created on 11/13/2017.
 */
public class BudgeteditPageController {
    MdrtbFinanceService financeService = Context.getService(MdrtbFinanceService.class);

    public String get(@RequestParam(value = "id") Integer id,
                      PageModel model,
                      UiSessionContext session){
        if (!session.isAuthenticated()){
            return "redirect: index.htm";
        }

        Budgets budget = financeService.getBudget(id);

        List<Integer> years = new ArrayList<Integer>();
        Calendar cal = Calendar.getInstance();
        Integer year = cal.get(Calendar.YEAR);

        List<Location> locations = Context.getService(MdrtbService.class).getLocationsByUser();
        Collections.sort(locations, new Comparator<Location>() {
            @Override
            public int compare(Location o1, Location o2) {
                return o1.getName().compareToIgnoreCase(o2.getName());
            }
        });

        years.add(year+1);
        years.add(year);
        years.add(year-1);
        years.add(year-2);
        years.add(year-3);
        years.add(year-3);

        List<BudgetsItems> items = financeService.getBudgetItems(budget);
        List<Charts> charts = financeService.getCharts();

        for(int i=0; i<charts.size();i++){
            if (charts.get(i).getHasChildren()){
                for (int x=0; x<charts.get(i).getChildren().size(); x++){
                    for (BudgetsItems item: items){
                        if (item.getItem().equals(charts.get(i).getChildren().get(x))){
                            charts.get(i).getChildren().get(x).setValue(item.getBudgetValue());
                            break;
                        }
                    }
                }
            }
            else {
                for (BudgetsItems item: items){
                    if (item.getItem().equals(charts.get(i))){
                        charts.get(i).setValue(item.getBudgetValue());
                        break;
                    }
                }
            }
        }

        String[] period = budget.getPeriod().split("-");

        model.addAttribute("budget", budget);
        model.addAttribute("years", years);
        model.addAttribute("year", Integer.parseInt(period[1]));
        model.addAttribute("qtrs", Integer.parseInt(period[0]));
        model.addAttribute("charts",  charts);
        model.addAttribute("locations", locations);

        return null;
    }
}
