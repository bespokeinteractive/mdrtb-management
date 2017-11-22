package org.openmrs.module.mdrtbmanagement;

import org.openmrs.User;
import org.openmrs.api.context.Context;

import java.util.Date;

/**
 * Created by Dennys Henry
 * Created on 11/22/2017.
 */
public class Assets {
    private Integer id;
    private Date date;
    private String serial;
    private String description;
    private String assignedTo;
    private Date acquiredOn;
    private Double acquiredCost;
    private Double acquiredCostLocal;
    private Date retiredOn;
    private User retiredBy;
    private Double retiredProceeds;
    private Date createdOn;
    private User createdBy;
    private Boolean voided;
    private Date voidedOn;
    private User voidedBy;
    private String voidReason;

    public Assets(){
        this.voided = false;

        this.createdOn = new Date();
        this.createdBy = Context.getAuthenticatedUser();
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

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(String assignedTo) {
        this.assignedTo = assignedTo;
    }

    public Date getAcquiredOn() {
        return acquiredOn;
    }

    public void setAcquiredOn(Date acquiredOn) {
        this.acquiredOn = acquiredOn;
    }

    public Double getAcquiredCost() {
        return acquiredCost;
    }

    public void setAcquiredCost(Double acquiredCost) {
        this.acquiredCost = acquiredCost;
    }

    public Double getAcquiredCostLocal() {
        return acquiredCostLocal;
    }

    public void setAcquiredCostLocal(Double acquiredCostLocal) {
        this.acquiredCostLocal = acquiredCostLocal;
    }

    public Date getRetiredOn() {
        return retiredOn;
    }

    public void setRetiredOn(Date retiredOn) {
        this.retiredOn = retiredOn;
    }

    public User getRetiredBy() {
        return retiredBy;
    }

    public void setRetiredBy(User retiredBy) {
        this.retiredBy = retiredBy;
    }

    public Double getRetiredProceeds() {
        return retiredProceeds;
    }

    public void setRetiredProceeds(Double retiredProceeds) {
        this.retiredProceeds = retiredProceeds;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public Boolean getVoided() {
        return voided;
    }

    public void setVoided(Boolean voided) {
        this.voided = voided;
    }

    public Date getVoidedOn() {
        return voidedOn;
    }

    public void setVoidedOn(Date voidedOn) {
        this.voidedOn = voidedOn;
    }

    public User getVoidedBy() {
        return voidedBy;
    }

    public void setVoidedBy(User voidedBy) {
        this.voidedBy = voidedBy;
    }

    public String getVoidReason() {
        return voidReason;
    }

    public void setVoidReason(String voidReason) {
        this.voidReason = voidReason;
    }
}
