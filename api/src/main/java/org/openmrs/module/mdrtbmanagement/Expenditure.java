package org.openmrs.module.mdrtbmanagement;

import org.openmrs.Location;
import org.openmrs.User;
import org.openmrs.api.context.Context;

import java.util.Date;

/**
 * Created by Dennys Henry
 * Created on 11/18/2017.
 */
public class Expenditure {
    private int id;
    private Date date;
    private String period;
    private Location location;
    private Charts item;
    private Double amount;
    private String description;
    private Date createdOn;
    private User createdBy;
    private Boolean voided;
    private Date voidedOn;
    private User voidedBy;
    private String voidReason;

    public Expenditure(){
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

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public Charts getItem() {
        return item;
    }

    public void setItem(Charts item) {
        this.item = item;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
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
