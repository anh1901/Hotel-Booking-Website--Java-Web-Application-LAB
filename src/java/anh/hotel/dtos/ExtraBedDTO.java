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
public class ExtraBedDTO implements Serializable{
    private int id;
    private int noOfBed;
    private double extraPrice;

    public ExtraBedDTO(int id, int noOfBed, double extraPrice) {
        this.id = id;
        this.noOfBed = noOfBed;
        this.extraPrice = extraPrice;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNoOfBed() {
        return noOfBed;
    }

    public void setNoOfBed(int noOfBed) {
        this.noOfBed = noOfBed;
    }

    public double getExtraPrice() {
        return extraPrice;
    }

    public void setExtraPrice(double extraPrice) {
        this.extraPrice = extraPrice;
    }
    
}
