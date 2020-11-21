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
public class BookingDetailsDTO implements Serializable{
    private int id;
    private int roomID;
    private String reservationID;
    private double prices;
    private int quantity;
    private String startDate;
    private String endDate;
    private int extraBedID;
    private int numDays;
    private boolean isFeedback;
    public BookingDetailsDTO(int roomID, String startDate,String endDate, double prices, int extraBedID, int numDays) {
        this.roomID = roomID;
        this.startDate = startDate;
        this.endDate = endDate;
        this.prices=prices;
        this.extraBedID = extraBedID;
        this.numDays=numDays;
    }

    public BookingDetailsDTO(int id, int roomID, String reservationID, double prices, int quantity, String startDate, String endDate, int extraBedID, boolean isFeedback) {
        this.id = id;
        this.roomID = roomID;
        this.reservationID = reservationID;
        this.prices = prices;
        this.quantity = quantity;
        this.startDate = startDate;
        this.endDate = endDate;
        this.extraBedID = extraBedID;
        this.isFeedback = isFeedback;
    }
    
    public BookingDetailsDTO(int roomID, String reservationID, double prices, int quantity, String startDate, String endDate, int extraBedID, boolean isFeedback) {
        this.roomID = roomID;
        this.reservationID = reservationID;
        this.prices = prices;
        this.quantity = quantity;
        this.startDate = startDate;
        this.endDate = endDate;
        this.extraBedID = extraBedID;
        this.isFeedback=isFeedback;
    }

    public boolean isIsFeedback() {
        return isFeedback;
    }

    public void setIsFeedback(boolean isFeedback) {
        this.isFeedback = isFeedback;
    }
    
    
    public int getNumDays() {
        return numDays;
    }

    public void setNumDays(int numDays) {
        this.numDays = numDays;
    }
    
    public BookingDetailsDTO() {
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getReservationID() {
        return reservationID;
    }

    public void setReservationID(String reservationID) {
        this.reservationID = reservationID;
    }

    public double getPrices() {
        return prices;
    }

    public void setPrices(double prices) {
        this.prices = prices;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public int getExtraBedID() {
        return extraBedID;
    }

    public void setExtraBedID(int extraBedID) {
        this.extraBedID = extraBedID;
    }
    
}
