package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbmanagement.Charts;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/18/2017.
 */
public class LedgersPageController {
    MdrtbService mdrtbService = Context.getService(MdrtbService.class);
    MdrtbFinanceService service = Context.getService(MdrtbFinanceService.class);

    public String get(@RequestParam(value = "index", required = false) Integer index,
                      UiSessionContext session,
                      PageModel model){
        if (!session.isAuthenticated()) {
            return "redirect: index.htm";
        }

        List<Location> locations = mdrtbService.getLocationsByUser();
        List<Charts> charts = service.getCharts();

        model.addAttribute("index", index);
        model.addAttribute("charts", charts);
        model.addAttribute("location", session.getSessionLocation());
        model.addAttribute("locations", locations);
        return null;
    }
}
