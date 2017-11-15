package org.openmrs.module.mdrtbmanagement.fragment.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtbmanagement.Disbursements;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/14/2017.
 */
public class CashdisbursementFragmentController {
    MdrtbFinanceService financeService = Context.getService(MdrtbFinanceService.class);

    public List<SimpleObject> listCashDisbursements(@RequestParam(value = "approved") Boolean approved,
                                                    UiUtils ui){
        List<Location> locations = new ArrayList<Location>();
        for (Location location: Context.getLocationService().getAllLocations()){
            locations.add(location);
        }

        List<Disbursements> disbursements = financeService.getDisbursements(null, approved);
        if (disbursements!=null){
            return SimpleObject.fromCollection(disbursements, ui, "id", "agency.name", "date", "period", "amount", "estimate", "approved", "approvedOn", "confirmedOn");
        }


        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }

    public SimpleObject getDisbursementsDetails(@RequestParam(value = "id") Integer id){
        Disbursements disbursement = financeService.getDisbursement(id);
        return SimpleObject.create("name", disbursement.getAgency().getName(), "amount", disbursement.getApproved(), "estimate", disbursement.getEstimate());
    }

    public SimpleObject confirmDisbursement(@RequestParam(value = "id") Integer id,
                                            @RequestParam(value = "date") Date date,
                                            @RequestParam(value = "note", required = false) String note,
                                            UiSessionContext session){
        Disbursements disbursement = financeService.getDisbursement(id);
        disbursement.setConfirmedOn(date);
        disbursement.setConfirmedBy(session.getCurrentUser());
        this.financeService.saveDisbursement(disbursement);

        return SimpleObject.create("status", "success", "message", "Patient successfully voided");
    }
}
