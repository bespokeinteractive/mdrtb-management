package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtbmanagement.Budgets;
import org.openmrs.module.mdrtbmanagement.BudgetsItems;
import org.openmrs.module.mdrtbmanagement.Charts;
import org.openmrs.module.mdrtbmanagement.LedgersSummary;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by Dennys Henry
 * Created on 11/22/2017.
 */
public class BudgetviewPageController {
    MdrtbFinanceService service = Context.getService(MdrtbFinanceService.class);

    public String get(@RequestParam(value = "id") Integer id,
                      PageModel model,
                      UiSessionContext session){
        if (!session.isAuthenticated()){
            return "redirect: index.htm";
        }

        Budgets budget = service.getBudget(id);
        List<Charts> charts = service.getCharts();
        Set<Charts> chartSet = new HashSet<Charts>();
        List<BudgetsItems> items = service.getBudgetItems(budget);
        List<LedgersSummary> ledgers = service.getLedgersSummary(budget.getLocation(), Integer.parseInt(budget.getPeriod().substring(3)));

        for (BudgetsItems item: items){
            Charts chart = item.getItem();

            if (budget.getApprovedOn() == null){
                chart.setValue(item.getBudgetValue());
                chart.setComment(item.getBudgetComment());
            }
            else {
                chart.setValue(item.getApprovedValue());
                chart.setComment(item.getApprovedComment());
            }
        }

        for (LedgersSummary ledger : ledgers){
            Charts chart = ledger.getItem();
            chart.setBudget(ledger.getBudgetTotal());
        }

        for (Charts chart: charts){
            chartSet.add(chart);
        }

        charts = new ArrayList<Charts>(chartSet);

        for (int i=0; i<charts.size(); i++){
            if (charts.get(i).getHasChildren()){
                charts.get(i).setValue(0);
                charts.get(i).setBudget(0.0);

                for (Charts child : charts.get(i).getChildren()){
                    charts.get(i).setValue(charts.get(i).getValue() + child.getValue());
                    charts.get(i).setBudget(charts.get(i).getBudget() + child.getBudget());
                }
            }
        }

        model.addAttribute("budget", budget);
        model.addAttribute("charts", charts);

        return null;
    }
}
