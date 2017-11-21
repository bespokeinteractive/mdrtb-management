package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.model.LocationCentres;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbmanagement.Charts;
import org.openmrs.module.mdrtbmanagement.LedgersSummary;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

/**
 * Created by Dennys Henry
 * Created on 11/21/2017.
 */
public class LedgerstatementPageController {
    MdrtbFinanceService service = Context.getService(MdrtbFinanceService.class);

    public String get(@RequestParam(value = "facility") Location location,
                      @RequestParam(value = "yr") Integer year,
                      PageModel model,
                      UiSessionContext session){
        LocationCentres centre = Context.getService(MdrtbService.class).getCentresByLocation(location);
        List<Charts> charts = service.getCharts();
        List<LedgersSummary> summaries = service.getLedgersSummary(location, year);
        Set<Charts> chartSet = new HashSet<Charts>();

        for(LedgersSummary summary: summaries){
            Charts chart = summary.getItem();

            chart.setBudgetQ1(summary.getBudgetQ1());
            chart.setBudgetQ2(summary.getBudgetQ2());
            chart.setBudgetQ3(summary.getBudgetQ3());
            chart.setBudgetQ4(summary.getBudgetQ4());
            chart.setBudgetTT(summary.getBudgetTotal());

            chart.setExpenditureQ1(summary.getExpenseQ1());
            chart.setExpenditureQ2(summary.getExpenseQ2());
            chart.setExpenditureQ3(summary.getExpenseQ3());
            chart.setExpenditureQ4(summary.getExpenseQ4());
            chart.setExpenditureTT(summary.getExpenseTotal());
        }

        for (Charts chart: charts){
            chartSet.add(chart);
        }

        charts = new ArrayList<Charts>(chartSet);

        Double expenditureQ1 = 0.0;
        Double expenditureQ2 = 0.0;
        Double expenditureQ3 = 0.0;
        Double expenditureQ4 = 0.0;
        Double expenditureTT = 0.0;

        Double budgetQ1 = 0.0;
        Double budgetQ2 = 0.0;
        Double budgetQ3 = 0.0;
        Double budgetQ4 = 0.0;
        Double budgetTT = 0.0;

        for (int i=0; i<charts.size(); i++){
            if (charts.get(i).getHasChildren()){
                charts.get(i).setBudgetQ1(0.0);
                charts.get(i).setBudgetQ2(0.0);
                charts.get(i).setBudgetQ3(0.0);
                charts.get(i).setBudgetQ4(0.0);
                charts.get(i).setBudgetTT(0.0);

                charts.get(i).setExpenditureQ1(0.0);
                charts.get(i).setExpenditureQ2(0.0);
                charts.get(i).setExpenditureQ3(0.0);
                charts.get(i).setExpenditureQ4(0.0);
                charts.get(i).setExpenditureTT(0.0);

                for (Charts chart : charts.get(i).getChildren()){
                    charts.get(i).setBudgetQ1(charts.get(i).getBudgetQ1() + chart.getBudgetQ1());
                    charts.get(i).setBudgetQ2(charts.get(i).getBudgetQ2() + chart.getBudgetQ2());
                    charts.get(i).setBudgetQ3(charts.get(i).getBudgetQ3() + chart.getBudgetQ3());
                    charts.get(i).setBudgetQ4(charts.get(i).getBudgetQ4() + chart.getBudgetQ4());
                    charts.get(i).setBudgetTT(charts.get(i).getBudgetTT() + chart.getBudgetTT());

                    charts.get(i).setExpenditureQ1(charts.get(i).getExpenditureQ1() + chart.getExpenditureQ1());
                    charts.get(i).setExpenditureQ2(charts.get(i).getExpenditureQ2() + chart.getExpenditureQ2());
                    charts.get(i).setExpenditureQ3(charts.get(i).getExpenditureQ3() + chart.getExpenditureQ3());
                    charts.get(i).setExpenditureQ4(charts.get(i).getExpenditureQ4() + chart.getExpenditureQ4());
                    charts.get(i).setExpenditureTT(charts.get(i).getExpenditureTT() + chart.getExpenditureTT());
                }
            }

            budgetQ1 += charts.get(i).getBudgetQ1();
            budgetQ2 += charts.get(i).getBudgetQ2();
            budgetQ3 += charts.get(i).getBudgetQ3();
            budgetQ4 += charts.get(i).getBudgetQ4();
            budgetTT += charts.get(i).getBudgetTT();

            expenditureQ1 += charts.get(i).getExpenditureQ1();
            expenditureQ2 += charts.get(i).getExpenditureQ2();
            expenditureQ3 += charts.get(i).getExpenditureQ3();
            expenditureQ4 += charts.get(i).getExpenditureQ4();
            expenditureTT += charts.get(i).getExpenditureTT();
        }

        model.addAttribute("centre", centre);
        model.addAttribute("start", "01-Jan-"+year);
        model.addAttribute("ended", "31-Dec-"+year);
        model.addAttribute("charts", charts);

        model.addAttribute("budgetQ1", budgetQ1);
        model.addAttribute("budgetQ2", budgetQ2);
        model.addAttribute("budgetQ3", budgetQ3);
        model.addAttribute("budgetQ4", budgetQ4);
        model.addAttribute("budgetTT", budgetTT);

        model.addAttribute("expenditureQ1", expenditureQ1);
        model.addAttribute("expenditureQ2", expenditureQ2);
        model.addAttribute("expenditureQ3", expenditureQ3);
        model.addAttribute("expenditureQ4", expenditureQ4);
        model.addAttribute("expenditureTT", expenditureTT);

        return null;
    }
}
