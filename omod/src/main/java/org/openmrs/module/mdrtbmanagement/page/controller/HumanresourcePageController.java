package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbmanagement.Charts;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.ui.framework.page.PageModel;

import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/21/2017.
 */
public class HumanresourcePageController {
    MdrtbService mdrtbService = Context.getService(MdrtbService.class);
    MdrtbFinanceService service = Context.getService(MdrtbFinanceService.class);

    public String get(UiSessionContext session,
                      PageModel model){
        if (!session.isAuthenticated()) {
            return "redirect: index.htm";
        }

        List<Charts> charts = service.getChildrenCharts(service.getChart(1));
        List<Location> locations = mdrtbService.getLocationsByUser();

        model.addAttribute("location", session.getSessionLocation());
        model.addAttribute("locations", locations);
        model.addAttribute("charts", charts);

        return null;
    }
}
