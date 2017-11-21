package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

/**
 * Created by Dennys Henry
 * Created on 11/1/2017.
 */
public class FinancedashboardPageController {
    public String get(@RequestParam(value = "view") String view,
                      PageModel model,
                      UiSessionContext session){
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

        years.add(year);
        years.add(year-1);
        years.add(year-2);
        years.add(year-3);
        years.add(year-4);

        model.addAttribute("view", view);
        model.addAttribute("qtrs", qtrs);
        model.addAttribute("year", year);
        model.addAttribute("years", years);
        model.addAttribute("location", session.getSessionLocation());
        model.addAttribute("locations", locations);

        return null;
    }
}
