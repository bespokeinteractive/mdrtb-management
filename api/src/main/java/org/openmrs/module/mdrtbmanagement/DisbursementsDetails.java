package org.openmrs.module.mdrtbmanagement;

import org.openmrs.module.mdrtb.model.LocationCentres;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by Dennis Henry
 * Created on 11/16/2017.
 */
@Entity
@Table(name = "finance_disbursement_details")
public class DisbursementsDetails {
    private int id;
    private Disbursements disbursement;
    private LocationCentres centre;
    private Double amount;
    private Double approved;
    private String narration;

    public DisbursementsDetails(){}

    public DisbursementsDetails(Disbursements disbursement){
        this.disbursement = disbursement;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Disbursements getDisbursement() {
        return disbursement;
    }

    public void setDisbursement(Disbursements disbursement) {
        this.disbursement = disbursement;
    }

    public LocationCentres getCentre() {
        return centre;
    }

    public void setCentre(LocationCentres centre) {
        this.centre = centre;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getApproved() {
        return approved;
    }

    public void setApproved(Double approved) {
        this.approved = approved;
    }

    public String getNarration() {
        return narration;
    }

    public void setNarration(String narration) {
        this.narration = narration;
    }
}
