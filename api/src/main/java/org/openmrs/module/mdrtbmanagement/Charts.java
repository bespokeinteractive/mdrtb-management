package org.openmrs.module.mdrtbmanagement;

import org.openmrs.User;
import java.util.Date;
import java.util.List;

/**
 * Created by Dennis Henry
 * Created on 11/6/2017.
 */
public class Charts {
    private static final long serialVersionUID = 1L;

    private int id;
    private String code;
    private String name;
    protected Charts chartsGroup;
    private boolean voided;
    private User voidedBy;
    private Date voidedOn;
    private String voidReason;

    /*Not Persistence in the DATABASE*/
    private Boolean hasChildren;
    private List<Charts> children;
    private float value;

    /*Getters and Setters*/
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Charts getChartsGroup() {
        return chartsGroup;
    }

    public void setChartsGroup(Charts chartsGroup) {
        this.chartsGroup = chartsGroup;
    }

    public boolean isVoided() {
        return voided;
    }

    public void setVoided(boolean voided) {
        this.voided = voided;
    }

    public User getVoidedBy() {
        return voidedBy;
    }

    public void setVoidedBy(User voidedBy) {
        this.voidedBy = voidedBy;
    }

    public Date getVoidedOn() {
        return voidedOn;
    }

    public void setVoidedOn(Date voidedOn) {
        this.voidedOn = voidedOn;
    }

    public String getVoidReason() {
        return voidReason;
    }

    public void setVoidReason(String voidReason) {
        this.voidReason = voidReason;
    }

    public List<Charts> getChildren() {
        return children;
    }

    public void setChildren(List<Charts> children) {
        this.children = children;
    }

    public Boolean getHasChildren() {
        return hasChildren;
    }

    public void setHasChildren(Boolean hasChildren) {
        this.hasChildren = hasChildren;
    }

    public float getValue() {
        return value;
    }

    public void setValue(float value) {
        this.value = value;
    }
}
