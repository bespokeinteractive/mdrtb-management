package org.openmrs.module.mdrtbmanagement.util;

import java.util.Date;

/**
 * Created by davie on 11/15/2017.
 */
public class RequestDisbursementWrapper {
    Integer id;
    Date date;
    Integer facility;
    Integer quarter;
    Integer year;
    String amount;
    String description;
    String quarterEstimate;

    public String getQuarterEstimate() {
        return quarterEstimate;
    }

    public void setQuarterEstimate(String quarterEstimate) {
        this.quarterEstimate = quarterEstimate;
    }



    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getFacility() {
        return facility;
    }

    public void setFacility(Integer facility) {
        this.facility = facility;
    }

    public Integer getQuarter() {
        return quarter;
    }

    public void setQuarter(Integer quarter) {
        this.quarter = quarter;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
