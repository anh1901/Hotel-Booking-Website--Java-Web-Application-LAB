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
public class DiscountDTO implements Serializable{
    private String id;
    private double discount;
    private String name;
    private String status;
    private String expireDate;
    private String createDate;

    public DiscountDTO(String id, double discount, String name, String expireDate) {
        this.id = id;
        this.discount = discount;
        this.name = name;
        this.expireDate = expireDate;
    }

    public DiscountDTO(String id, double discount, String name, String status, String expireDate, String createDate) {
        this.id = id;
        this.discount = discount;
        this.name = name;
        this.status = status;
        this.expireDate = expireDate;
        this.createDate = createDate;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(String expireDate) {
        this.expireDate = expireDate;
    }
    
}
