package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.model.LocationCentresAgencies;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbmanagement.Charts;
import org.openmrs.module.mdrtbmanagement.Disbursements;
import org.openmrs.module.mdrtbmanagement.DisbursementsDetails;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

/**
 * Created by Dennys Henry
 * Created on 11/16/2017.
 */
public class CashrequesteditPageController {
    MdrtbFinanceService financeService = Context.getService(MdrtbFinanceService.class);
    MdrtbService mdrtbService = Context.getService(MdrtbService.class);

    public String get(@RequestParam(value = "id") Integer id,
                      PageModel model,
                      UiSessionContext session) {
        if (!session.isAuthenticated()) {
            return "redirect: index.htm";
        }

        Disbursements disbursement = financeService.getDisbursement(id);
        List<DisbursementsDetails> list = financeService.getDisbursementsDetails(disbursement);

        List<Integer> years = new ArrayList<Integer>();
        Calendar cal = Calendar.getInstance();
        Integer year = cal.get(Calendar.YEAR);

        List<Location> locations = mdrtbService.getLocationsByUser();
        List<LocationCentresAgencies> agencies = mdrtbService.getAgencies(locations);
        Collections.sort(agencies, new Comparator<LocationCentresAgencies>() {
            @Override
            public int compare(LocationCentresAgencies o1, LocationCentresAgencies o2) {
                return o1.getName().compareToIgnoreCase(o2.getName());
            }
        });

        years.add(year + 1);
        years.add(year);
        years.add(year - 1);
        years.add(year - 2);
        years.add(year - 3);

        String[] period = disbursement.getPeriod().split("-");

        model.addAttribute("disbursement", disbursement);
        model.addAttribute("years", years);
        model.addAttribute("year", Integer.parseInt(period[1]));
        model.addAttribute("qtrs", Integer.parseInt(period[0]));
        model.addAttribute("agencies", agencies);
        model.addAttribute("locations", locations);

        return null;
    }
}
