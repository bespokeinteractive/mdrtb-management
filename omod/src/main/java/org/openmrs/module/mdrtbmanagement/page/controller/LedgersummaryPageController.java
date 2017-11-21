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

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Dennys Henry
 * Created on 11/20/2017.
 */
public class LedgersummaryPageController {
    MdrtbFinanceService service = Context.getService(MdrtbFinanceService.class);

    public String get(@RequestParam(value = "facility") Location location,
                      @RequestParam(value = "qtr") Integer qtr,
                      @RequestParam(value = "yr") Integer year,
                      PageModel model,
                      UiSessionContext session){
        LocationCentres centre = Context.getService(MdrtbService.class).getCentresByLocation(location);
        Format formatter = new SimpleDateFormat("dd-MMM-yyyy");

        String start;
        String ended;

        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.set(Calendar.MONTH, (qtr-1)*3);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        start = formatter.format(cal.getTime());

        cal.set(Calendar.MONTH, ((qtr-1)*3)+2);
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        ended = formatter.format(cal.getTime());

        List<Charts> charts = service.getCharts();
        List<LedgersSummary> summaries = service.getLedgersSummary(location, year);
        Set<Charts> chartSet = new HashSet<Charts>();

        for(LedgersSummary summary: summaries){
            Charts chart = summary.getItem();

            if (qtr == 1){
                chart.setBudget(summary.getBudgetQ1());
                chart.setExpenditure(summary.getExpenseQ1());

                chart.setBudgetYT(summary.getBudgetQ1());
                chart.setExpenditureYT(summary.getExpenseQ1());
            }
            else if (qtr == 2){
                chart.setBudget(summary.getBudgetQ2());
                chart.setExpenditure(summary.getExpenseQ2());

                chart.setBudgetYT(summary.getBudgetQ1()+ summary.getBudgetQ2());
                chart.setExpenditureYT(summary.getExpenseQ1() + summary.getExpenseQ2());
            }
            else if (qtr == 3){
                chart.setBudget(summary.getBudgetQ3());
                chart.setExpenditure(summary.getExpenseQ3());

                chart.setBudgetYT(summary.getBudgetQ1()+ summary.getBudgetQ2() + summary.getBudgetQ3());
                chart.setExpenditureYT(summary.getExpenseQ1() + summary.getExpenseQ2() + summary.getExpenseQ3());
            }
            else if (qtr == 4){
                chart.setBudget(summary.getBudgetQ4());
                chart.setExpenditure(summary.getExpenseQ4());

                chart.setBudgetYT(summary.getBudgetTotal());
                chart.setExpenditureYT(summary.getExpenseTotal());
            }

            chart.setBudgetTT(summary.getBudgetTotal());
            chart.setExpenditureTT(summary.getExpenseTotal());

            //Calculate Variances
            if (chart.getBudget()==0 && chart.getExpenditure()==0){
                chart.setVariance(0.0);
                chart.setPercentage(0.0);
            }
            else if (chart.getBudget() == 0){
                chart.setVariance(0-chart.getExpenditure());
                chart.setPercentage(0-100.0);
            }
            else if (chart.getExpenditure() == 0){
                chart.setVariance(chart.getExpenditure());
                chart.setPercentage(100.0);
            }
            else {
                chart.setVariance(chart.getBudget()-chart.getExpenditure());
                chart.setPercentage(((chart.getBudget()-chart.getExpenditure())/chart.getBudget())*100.0);
            }
        }

        for (Charts chart: charts){
            chartSet.add(chart);
        }

        charts = new ArrayList<Charts>(chartSet);

        Double expenditure = 0.0;
        Double expenditureYT = 0.0;
        Double expenditureTT = 0.0;

        Double budget = 0.0;
        Double budgetYT = 0.0;
        Double budgetTT = 0.0;

        Double percentage = 0.0;

        for (int i=0; i<charts.size(); i++){
            if (charts.get(i).getHasChildren()){
                charts.get(i).setBudget(0.0);
                charts.get(i).setBudgetYT(0.0);
                charts.get(i).setBudgetTT(0.0);
                charts.get(i).setExpenditure(0.0);
                charts.get(i).setExpenditureYT(0.0);
                charts.get(i).setExpenditureTT(0.0);

                for (Charts chart : charts.get(i).getChildren()){
                    charts.get(i).setBudget(charts.get(i).getBudget() + chart.getBudget());
                    charts.get(i).setBudgetYT(charts.get(i).getBudgetYT() + chart.getBudgetYT());
                    charts.get(i).setBudgetTT(charts.get(i).getBudgetTT() + chart.getBudgetTT());

                    charts.get(i).setExpenditure(charts.get(i).getExpenditure() + chart.getExpenditure());
                    charts.get(i).setExpenditureYT(charts.get(i).getExpenditureYT() + chart.getExpenditureYT());
                    charts.get(i).setExpenditureTT(charts.get(i).getExpenditureTT() + chart.getExpenditureTT());
                }

                charts.get(i).setVariance(charts.get(i).getBudget()-charts.get(i).getExpenditure());
                if (charts.get(i).getBudget()==0 && charts.get(i).getExpenditure()==0){
                    charts.get(i).setPercentage(0.0);
                }
                else if (charts.get(i).getBudget() == 0){
                    charts.get(i).setPercentage(0-100.0);
                }
                else if (charts.get(i).getExpenditure() == 0){
                    charts.get(i).setPercentage(100.0);
                }
                else {
                    charts.get(i).setPercentage(((charts.get(i).getBudget()-charts.get(i).getExpenditure())/charts.get(i).getBudget())*100.0);
                }
            }

            expenditureYT += charts.get(i).getExpenditureYT();
            expenditureTT += charts.get(i).getExpenditureTT();
            expenditure += charts.get(i).getExpenditure();
            budget += charts.get(i).getBudget();
            budgetYT += charts.get(i).getBudgetYT();
            budgetTT += charts.get(i).getBudgetTT();

            percentage = ((budget-expenditure)/budget)*100;
        }

        model.addAttribute("centre", centre);
        model.addAttribute("qtr", qtr);
        model.addAttribute("year", year);
        model.addAttribute("start", start);
        model.addAttribute("ended", ended);
        model.addAttribute("charts", charts);

        model.addAttribute("expenditure", expenditure);
        model.addAttribute("expenditureYT", expenditureYT);
        model.addAttribute("expenditureTT", expenditureTT);
        model.addAttribute("budget", budget);
        model.addAttribute("budgetYT", budgetYT);
        model.addAttribute("budgetTT", budgetTT);
        model.addAttribute("variance", budget-expenditure);
        model.addAttribute("percentage", percentage);

        return null;
    }
}
