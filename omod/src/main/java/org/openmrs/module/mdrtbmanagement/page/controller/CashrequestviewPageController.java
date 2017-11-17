package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtbmanagement.Disbursements;
import org.openmrs.module.mdrtbmanagement.DisbursementsDetails;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/17/2017.
 */
public class CashrequestviewPageController {
    MdrtbFinanceService financeService = Context.getService(MdrtbFinanceService.class);

    public String get(@RequestParam(value = "id") Integer id,
                      PageModel model,
                      UiSessionContext session) {
        if (!session.isAuthenticated()) {
            return "redirect: index.htm";
        }

        Disbursements disbursement = financeService.getDisbursement(id);
        List<DisbursementsDetails> details = financeService.getDisbursementsDetails(disbursement);

        Integer confirm = 0;
        Integer edit = 0;

        if (disbursement.getApprovedOn() == null){
            edit = 1;
        }

        if (edit == 0 && disbursement.getConfirmedOn() == null){
            confirm = 1;
        }

        model.addAttribute("disbursement", disbursement);
        model.addAttribute("details", details);
        model.addAttribute("edit", edit);
        model.addAttribute("confirm", confirm);

        return null;
    }
}
