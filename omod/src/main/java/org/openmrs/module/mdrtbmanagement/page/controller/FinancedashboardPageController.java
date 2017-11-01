package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by Dennys Henry
 * Created on 11/1/2017.
 */
public class FinancedashboardPageController {
    public String get(@RequestParam(value = "view") String view,
                      PageModel model){
        model.addAttribute("view", view);


        return null;
    }
}
