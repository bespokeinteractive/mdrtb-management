package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by Davie Mukungi
 * Created on 12/7/2017.
 */
public class CashdisbursementwvgfPageController {
    public void get(@RequestParam(value = "tab", required = false) String tab,
                    PageModel model){
        model.addAttribute("tab", tab);
    }
}
