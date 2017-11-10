package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.module.mdrtbmanagement.model.Charts;
import org.openmrs.ui.framework.page.PageModel;

import java.util.*;

/**
 * Created by Dennis Henry
 * Created on 11/8/2017.
 */
public class BudgetaddPageController {
    public String get(PageModel model,
                      UiSessionContext sessionContext){
        List<Integer> years = new ArrayList<Integer>();
        Calendar cal = Calendar.getInstance();
        Integer year = cal.get(Calendar.YEAR);
        Integer qtrs = (cal.get(Calendar.MONTH)/3)+1;

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

        List<Charts> charts = Context.getService(MdrtbFinanceService.class).getCharts();

        model.addAttribute("years", years);
        model.addAttribute("year", year);
        model.addAttribute("qtrs", qtrs);
        model.addAttribute("charts", charts);
        model.addAttribute("location", sessionContext.getSessionLocation());
        model.addAttribute("locations", locations);

        return null;
    }

}
