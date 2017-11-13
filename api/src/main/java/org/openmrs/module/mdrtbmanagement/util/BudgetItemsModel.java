package org.openmrs.module.mdrtbmanagement.util;

import org.openmrs.module.mdrtbmanagement.Charts;

/**
 * Created by Dennys Henry
 * Created on 11/13/2017.
 */
public class BudgetItemsModel {
    Charts item;
    String note;
    float value;
    float confirmed;

    public Charts getItem() {
        return item;
    }

    public void setItem(Charts item) {
        this.item = item;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public float getValue() {
        return value;
    }

    public void setValue(float value) {
        this.value = value;
    }

    public float getConfirmed() {
        return confirmed;
    }

    public void setConfirmed(float confirmed) {
        this.confirmed = confirmed;
    }
}
