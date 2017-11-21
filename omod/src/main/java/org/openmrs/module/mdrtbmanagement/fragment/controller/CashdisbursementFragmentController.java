package org.openmrs.module.mdrtbmanagement.fragment.controller;

import org.apache.commons.lang.StringUtils;
import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.model.LocationCentres;
import org.openmrs.module.mdrtb.model.LocationCentresAgencies;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbmanagement.Disbursements;
import org.openmrs.module.mdrtbmanagement.DisbursementsDetails;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.module.mdrtbmanagement.util.RequestDisbursementWrapper;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.annotation.BindParams;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.util.*;

/**
 * Created by Dennys Henry
 * Created on 11/14/2017.
 */
public class CashdisbursementFragmentController {
    MdrtbFinanceService financeService = Context.getService(MdrtbFinanceService.class);
    MdrtbService mdrtbService = Context.getService(MdrtbService.class);

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

    public List<SimpleObject> getSubRecipientCentres(@RequestParam(value = "agency") Integer agency_id,
                                                     UiUtils ui){
        List<LocationCentres> centres = mdrtbService.getCentres(mdrtbService.getAgency(agency_id));
        if (centres!=null){
            Collections.sort(centres, new Comparator<LocationCentres>() {
                @Override
                public int compare(LocationCentres o1, LocationCentres o2) {
                    return o1.getLocation().getName().compareToIgnoreCase(o2.getLocation().getName());
                }
            });

            return SimpleObject.fromCollection(centres, ui, "id", "location.name", "region.name");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }

    public List<SimpleObject> getSubRecipientValues(@RequestParam(value = "id") Integer id,
                                                    @RequestParam(value = "agency") Integer agency_id,
                                                    UiUtils ui){
        Disbursements disbursement = financeService.getDisbursement(id);
        List<DisbursementsDetails> details = financeService.getDisbursementsDetails(disbursement);
        List<LocationCentres> centres = mdrtbService.getCentres(mdrtbService.getAgency(agency_id));
        if (centres!=null){
            Set<LocationCentres> centresSet = new HashSet<LocationCentres>();
            for (DisbursementsDetails dtl : details) {
                LocationCentres lc = dtl.getCentre();
                lc.setAmount(dtl.getAmount());
                lc.setComment(dtl.getNarration());
                centresSet.add(lc);
            }
            for (LocationCentres locationCentres : centres) {
                centresSet.add(locationCentres);
            }

            centres = new ArrayList<LocationCentres>(centresSet);
            Collections.sort(centres, new Comparator<LocationCentres>() {
                @Override
                public int compare(LocationCentres o1, LocationCentres o2) {
                    return o1.getLocation().getName().compareToIgnoreCase(o2.getLocation().getName());
                }
            });

            return SimpleObject.fromCollection(centres, ui, "id", "amount", "comment", "location.name", "region.name");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }

    public SimpleObject addNewDisbursementRequest(@BindParams("disbursement") RequestDisbursementWrapper wrapper,
                                                  HttpServletRequest request)
            throws SecurityException, IllegalArgumentException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        LocationCentresAgencies agency = mdrtbService.getAgency(wrapper.getAgency());
        String period = "0"+wrapper.getQuarter() + "-" + wrapper.getYear();

        Disbursements disbursement = financeService.getDisbursement(period, agency);
        if (disbursement != null){
            return SimpleObject.create("status", "failed", "message", "Facility Budget for that period already exsists");
        }
        disbursement = new Disbursements();
        disbursement.setPeriod(period);
        disbursement.setAgency(agency);
        disbursement.setDate(wrapper.getDate());

        disbursement.setAmount(new Double(wrapper.getAmount().replace(",", "")));
        disbursement.setEstimate(new Double(wrapper.getEstimate().replace(",", "")));
        disbursement.setDescription(wrapper.getDescription());

        disbursement = financeService.saveDisbursement(disbursement);

        for (Map.Entry<String, String[]> params : ((Map<String, String[]>) request.getParameterMap()).entrySet()) {
            if (StringUtils.contains(params.getKey(), "data.")) {
                String value = params.getValue()[0].replace(",", "");
                if (StringUtils.isBlank(value)){
                    continue;
                }

                Double amount = new Double(value);
                if (amount <= 0){
                    continue;
                }

                Integer key = Integer.parseInt(params.getKey().substring("item.".length()));
                String note = request.getParameterValues("note." + key)[0];

                LocationCentres centre = mdrtbService.getCentre(key);

                DisbursementsDetails details = new DisbursementsDetails(disbursement);
                details.setCentre(centre);
                details.setAmount(amount);
                details.setNarration(note);

                this.financeService.saveDisbursementsDetails(details);
            }
        }

        return SimpleObject.create("status", "success", "message", "Facility Budget has been added successfully");
    }

    public SimpleObject updateFundsRequest(@BindParams("disbursement") RequestDisbursementWrapper wrapper,
                                           HttpServletRequest request){
        Disbursements disbursement = financeService.getDisbursement(wrapper.getId());
        LocationCentresAgencies agency = mdrtbService.getAgency(wrapper.getAgency());


        String period = "0"+wrapper.getQuarter() + "-" + wrapper.getYear();

        disbursement.setPeriod(period);

        disbursement.setDate(wrapper.getDate());

        disbursement.setAmount(new Double(wrapper.getAmount().replace(",", "")));
        disbursement.setEstimate(new Double(wrapper.getEstimate().replace(",", "")));
        disbursement.setDescription(wrapper.getDescription());

        if (!disbursement.getAgency().equals(agency)){
            //Delete All the Current Facilities & Update New Agency
            financeService.deleteDisbursementsDetails(disbursement);
            disbursement.setAgency(agency);
        }

        //loop throough all id zero, delete else update/add
        for (Map.Entry<String, String[]> params : ((Map<String, String[]>) request.getParameterMap()).entrySet()) {
            if (StringUtils.contains(params.getKey(), "data.")) {
                String value = params.getValue()[0].replace(",", "");
                if (StringUtils.isBlank(value)){
                    value = "0";
                }

                Integer key = Integer.parseInt(params.getKey().substring("item.".length()));
                LocationCentres centre = mdrtbService.getCentre(key);
                Double amount = new Double(value);

                DisbursementsDetails details = financeService.getDisbursementsDetail(disbursement, centre);
                if (details == null && amount == 0){
                    continue;
                }
                else if (amount == 0){
                    this.financeService.deleteDisbursementsDetail(details);
                }
                else{
                    String note = request.getParameterValues("note." + key)[0];
                    if (details == null){
                        details = new DisbursementsDetails(disbursement);
                        details.setCentre(centre);
                    }

                    details.setAmount(amount);
                    details.setNarration(note);

                    this.financeService.saveDisbursementsDetails(details);
                }
            }
        }

        this.financeService.saveDisbursement(disbursement);
        return SimpleObject.create("status", "success", "message", "Facility Budget has been added successfully");
    }
}
