package org.openmrs.module.mdrtbmanagement.page.controller;

import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by Dennys Henry
 * Created on 11/15/2017.
 */
public class CashdisbursementPageController {
    public void get(@RequestParam(value = "tab", required = false) String tab,
                    PageModel model){
        model.addAttribute("tab", tab);
    }
}
