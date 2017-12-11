package org.openmrs.module.mdrtbmanagement.fragment.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbmanagement.Expenditure;
import org.openmrs.module.mdrtbmanagement.Ledgers;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Dennys Henry
 * Created on 11/18/2017.
 */
public class LedgersFragmentController {
    MdrtbFinanceService service = Context.getService(MdrtbFinanceService.class);

    public List<SimpleObject> getLedgerEntries(@RequestParam(value = "location") Location location,
                                               UiUtils ui) {
        List<Location> locations = new ArrayList<Location>();
        if (location == null) {
            locations = Context.getService(MdrtbService.class).getLocationsByUser();
        } else {
            locations.add(location);
        }

        List<Ledgers> ledgers = service.getLedgers(locations, null, null, null, null);
        if (ledgers != null) {
            return SimpleObject.fromCollection(ledgers, ui, "id", "order", "location.name", "item.name", "date", "period", "amount", "description");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }

    public SimpleObject postExpenditure(@RequestParam(value = "location") Location location,
                                        @RequestParam(value = "item") Integer item,
                                        @RequestParam(value = "date") Date date,
                                        @RequestParam(value = "amount") Double amount,
                                        @RequestParam(value = "notes", required = false) String notes) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        String period = "0" + ((cal.get(Calendar.MONTH) / 3) + 1) + "-" + cal.get(Calendar.YEAR);

        Expenditure expenditure = new Expenditure();
        expenditure.setItem(service.getChart(item));
        expenditure.setLocation(location);
        expenditure.setPeriod(period);
        expenditure.setDate(date);
        expenditure.setAmount(amount);
        expenditure.setDescription(notes);
        this.service.saveExpenditure(expenditure);

        return SimpleObject.create("status", "success", "message", "Patient successfully voided!");
    }

    public SimpleObject getLedgers(@RequestParam(value = "id") Integer id) {
        Ledgers ledgers = service.getLedgers(id);
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat ff = new SimpleDateFormat("dd MMM yyyy");

        return SimpleObject.create("period", ledgers.getPeriod(),"facility", ledgers.getLocation(),"journal", ledgers.getItem().getName(), "amount", ledgers.getAmount());
    }

    public SimpleObject voidExpenditure(@RequestParam(value = "id") Integer id,
                                        @RequestParam(value = "date") Date date,
                                    UiSessionContext session){

        Expenditure expenditure = new Expenditure();
        expenditure.setVoided(true);
        expenditure.setVoidedBy(session.getCurrentUser());
        expenditure.setVoidedOn(date);
       this.service.saveExpenditure(expenditure);
       return SimpleObject.create("status", "success", "message", "Expenditure successfully voided!");
    }
}

