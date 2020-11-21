/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.dtos;

import java.io.Serializable;

/**
 *
 * @author DELL
 */
public class ReservationDTO implements Serializable{
    private String id;
    private String userEmail;
    private String discountID;
    private double subTotal;
    private String status;
    private String createdDateTime;

    public ReservationDTO() {
    }

    public ReservationDTO(String id, String userEmail, String discountID, double subTotal, String status) {
        this.id = id;
        this.userEmail = userEmail;
        this.discountID = discountID;
        this.subTotal = subTotal;
        this.status = status;
    }

    public ReservationDTO(String id, String userEmail, String discountID, double subTotal, String status, String createdDateTime) {
        this.id = id;
        this.userEmail = userEmail;
        this.discountID = discountID;
        this.subTotal = subTotal;
        this.status = status;
        this.createdDateTime = createdDateTime;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getDiscountID() {
        return discountID;
    }

    public void setDiscountID(String discountID) {
        this.discountID = discountID;
    }

    public double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedDateTime() {
        return createdDateTime;
    }

    public void setCreatedDateTime(String createdDateTime) {
        this.createdDateTime = createdDateTime;
    }
    
}
