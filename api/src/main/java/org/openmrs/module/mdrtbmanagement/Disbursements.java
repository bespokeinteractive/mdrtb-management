package org.openmrs.module.mdrtbmanagement;

import java.util.Date;

import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.mdrtb.model.LocationCentresAgencies;

/**
 * Created by Dennys Henry
 * Created on 11/14/2017.
 */
public class Disbursements {
    private int id;
    private Date date;
    private String period;
    private LocationCentresAgencies agency;
    private Double amount;
    private Double estimate;
    private Double approved;
    private String description;
    private Date createdOn;
    private User createdBy;
    private Date approvedOn;
    private User approvedBy;
    private Date confirmedOn;
    private User confirmedBy;
    private Boolean voided;
    private Boolean voidedOn;
    private Boolean voidedBy;
    private Boolean voidReason;

    public Disbursements(){
        this.voided = false;

        this.createdOn = new Date();
        this.createdBy = Context.getAuthenticatedUser();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public LocationCentresAgencies getAgency() {
        return agency;
    }

    public void setAgency(LocationCentresAgencies agency) {
        this.agency = agency;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getEstimate() {
        return estimate;
    }

    public void setEstimate(Double estimate) {
        this.estimate = estimate;
    }

    public Double getApproved() {
        return approved;
    }

    public void setApproved(Double approved) {
        this.approved = approved;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public Date getApprovedOn() {
        return approvedOn;
    }

    public void setApprovedOn(Date approvedOn) {
        this.approvedOn = approvedOn;
    }

    public Date getConfirmedOn() {
        return confirmedOn;
    }

    public void setConfirmedOn(Date confirmedOn) {
        this.confirmedOn = confirmedOn;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public User getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(User approvedBy) {
        this.approvedBy = approvedBy;
    }

    public User getConfirmedBy() {
        return confirmedBy;
    }

    public void setConfirmedBy(User confirmedBy) {
        this.confirmedBy = confirmedBy;
    }

    public Boolean getVoided() {
        return voided;
    }

    public void setVoided(Boolean voided) {
        this.voided = voided;
    }

    public Boolean getVoidedOn() {
        return voidedOn;
    }

    public void setVoidedOn(Boolean voidedOn) {
        this.voidedOn = voidedOn;
    }

    public Boolean getVoidedBy() {
        return voidedBy;
    }

    public void setVoidedBy(Boolean voidedBy) {
        this.voidedBy = voidedBy;
    }

    public Boolean getVoidReason() {
        return voidReason;
    }

    public void setVoidReason(Boolean voidReason) {
        this.voidReason = voidReason;
    }
}
