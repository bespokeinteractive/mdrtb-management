package org.openmrs.module.mdrtbmanagement.fragment.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbmanagement.Disbursements;
import org.openmrs.module.mdrtbmanagement.HumanResources;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.util.Format;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/21/2017.
 */
public class HumanResourcesFragmentController {
    MdrtbFinanceService service = Context.getService(MdrtbFinanceService.class);

    public List<SimpleObject> getStaffLists(@RequestParam(value = "location") Location location,
                                            UiUtils ui){
        List<Location> locations = new ArrayList<Location>();
        if (location == null) {
            locations = Context.getService(MdrtbService.class).getLocationsByUser();
        }
        else {
            locations.add(location);
        }

        List<HumanResources> staffList = service.getStaffList(locations, false);
        if (staffList != null){
            return SimpleObject.fromCollection(staffList, ui, "id", "date", "name", "location.name", "designation.name", "designation.code", "amount", "description");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }

    public SimpleObject getStaffDetails(@RequestParam(value = "id") Integer id){
        HumanResources staff = service.getStaff(id);
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat ff = new SimpleDateFormat("dd MMM yyyy");
        return SimpleObject.create("name", staff.getName(), "date", df.format(staff.getDate()), "disp", ff.format(staff.getDate()), "designation", staff.getDesignation().getId(), "desc", staff.getDesignation().getName(), "location", staff.getLocation().getId(), "loc",staff.getLocation().getName(), "amount", staff.getAmount(), "notes", staff.getDescription());
    }

    public SimpleObject updateStaffList(@RequestParam(value = "id") Integer id,
                                        @RequestParam(value = "date") Date date,
                                        @RequestParam(value = "name") String name,
                                        @RequestParam(value = "chart") Integer chart_id,
                                        @RequestParam(value = "location") Location location,
                                        @RequestParam(value = "amount") Double amount,
                                        @RequestParam(value = "note", required = false) String note){
        HumanResources staff = service.getStaff(id);
        if (staff == null || id == 0){
            staff = new HumanResources();
        }

        staff.setName(name);
        staff.setDate(date);
        staff.setDesignation(service.getChart(chart_id));
        staff.setLocation(location);
        staff.setAmount(amount);
        staff.setDescription(note);

        this.service.saveStaff(staff);

        return SimpleObject.create("status", "success", "message", "Staff successfully updated");
    }

    public SimpleObject transferStaffList(@RequestParam(value = "id") Integer id,
                                          @RequestParam(value = "date") Date date,
                                          @RequestParam(value = "note", required = false) String note){
        HumanResources staff = service.getStaff(id);
        if (staff == null || id == 0){
            return SimpleObject.create("status", "failed", "message", "Failed to retrieve Staff details");
        }

        staff.setTransferredOn(date);
        staff.setTransferReason(note);
        this.service.saveStaff(staff);

        return SimpleObject.create("status", "success", "message", "Staff successfully transfered");
    }
}
