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
 * Created by Davie Mukungi
 * Created on 11/21/2017.
 */
public class LedgerscashflowPageController {
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

                chart.setExpenditure(summary.getExpenseQ1());

            }
            else if (qtr == 2){

                chart.setExpenditure(summary.getExpenseQ2());

            }
            else if (qtr == 3){
                chart.setExpenditure(summary.getExpenseQ3());
            }
            else if (qtr == 4){
                chart.setExpenditure(summary.getExpenseQ4());

            }

            chart.setBudgetTT(summary.getBudgetTotal());
            chart.setExpenditureTT(summary.getExpenseTotal());
        }

        for (Charts chart: charts){
            chartSet.add(chart);
        }

        charts = new ArrayList<Charts>(chartSet);

        Double expenditure = 0.0;
        Double expenditureTT = 0.0;


        for (int i=0; i<charts.size(); i++){
            if (charts.get(i).getHasChildren()){
                charts.get(i).setExpenditure(0.0);

                for (Charts chart : charts.get(i).getChildren()){
                    charts.get(i).setExpenditure(charts.get(i).getExpenditure() + chart.getExpenditure());

                }

            }

            expenditure = charts.get(i).getExpenditure();
            expenditureTT += charts.get(i).getExpenditure();

        }

        model.addAttribute("centre", centre);
        model.addAttribute("qtr", qtr);
        model.addAttribute("year", year);
        model.addAttribute("start", start);
        model.addAttribute("ended", ended);
        model.addAttribute("charts", charts);

        model.addAttribute("expenditure", expenditure);
        model.addAttribute("expenditureTT", expenditureTT);


        return null;
    }
}
