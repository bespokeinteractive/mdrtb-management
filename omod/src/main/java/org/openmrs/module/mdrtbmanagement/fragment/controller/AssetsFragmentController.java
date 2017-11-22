package org.openmrs.module.mdrtbmanagement.fragment.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbmanagement.Assets;
import org.openmrs.module.mdrtbmanagement.HumanResources;
import org.openmrs.module.mdrtbmanagement.api.MdrtbFinanceService;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/22/2017.
 */
public class AssetsFragmentController {
    MdrtbFinanceService service = Context.getService(MdrtbFinanceService.class);

    public List<SimpleObject> getAssetsLists(@RequestParam(value = "location") Location location,
                                             UiUtils ui){
        List<Location> locations = new ArrayList<Location>();
        if (location == null) {
            locations = Context.getService(MdrtbService.class).getLocationsByUser();
        }
        else {
            locations.add(location);
        }

        List<Assets> assets = service.getAssets(locations);
        if (assets != null){
            return SimpleObject.fromCollection(assets, ui, "id", "date", "serial", "location.name", "assignedTo", "acquiredCost", "description", "retiredOn", "retiredProceeds");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }

    public SimpleObject getAssetDetails(@RequestParam(value = "id") Integer id){
        Assets asset = service.getAssets(id);
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat ff = new SimpleDateFormat("dd MMM yyyy");
        return SimpleObject.create("serial", asset.getSerial(), "date", df.format(asset.getDate()), "disp", ff.format(asset.getDate()), "description", asset.getDescription(), "amount", asset.getAcquiredCost(), "costs", asset.getAcquiredCostLocal(), "assigned", asset.getAssignedTo());
    }

    public SimpleObject updateAssetsList(@RequestParam(value = "id") Integer id,
                                         @RequestParam(value = "date") Date date,
                                         @RequestParam(value = "serial") String serial,
                                         @RequestParam(value = "description") String description,
                                         @RequestParam(value = "location") Location location,
                                         @RequestParam(value = "amount") Double amount,
                                         @RequestParam(value = "costs", required = false) Double costs,
                                         @RequestParam(value = "assigned", required = false) String assigned){
        Assets asset = service.getAssets(id);
        if (asset == null || id == 0){
            asset = new Assets();
        }

        asset.setDate(date);
        asset.setSerial(serial);
        asset.setDescription(description);
        asset.setLocation(location);
        asset.setAcquiredCost(amount);
        asset.setAcquiredCostLocal(costs);
        asset.setAssignedTo(assigned);

        this.service.saveAssets(asset);
        return SimpleObject.create("status", "success", "message", "Asset successfully updated");
    }

    public SimpleObject retireAssetsList(@RequestParam(value = "id") Integer id,
                                         @RequestParam(value = "date") Date date,
                                         @RequestParam(value = "amount", required = false) Double amount,
                                         UiSessionContext session){
        Assets asset = service.getAssets(id);
        if (asset == null || id == 0){
            return SimpleObject.create("status", "failed", "message", "Couldn't find the specified Asset");
        }

        asset.setRetiredOn(date);
        asset.setRetiredBy(session.getCurrentUser());
        asset.setRetiredProceeds(amount);

        this.service.saveAssets(asset);
        return SimpleObject.create("status", "success", "message", "Asset successfully updated");
    }
}
