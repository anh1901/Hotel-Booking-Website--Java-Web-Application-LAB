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
public class RoomDTO implements Serializable{
    private int id;
    private String name;
    private String description;
    private int hotelID;
    private int roomTypeID;
    private double price;
    private String photo;
    private int availableRoom;

    public RoomDTO(int id, String name, String description, int hotelID, int roomTypeID, double price, String photo, int availableRoom) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.hotelID = hotelID;
        this.roomTypeID = roomTypeID;
        this.price = price;
        this.photo = photo;
        this.availableRoom = availableRoom;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
    
    public int getAvailableRoom() {
        return availableRoom;
    }

    public void setAvailableRoom(int availableRoom) {
        this.availableRoom = availableRoom;
    }
    
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getHotelID() {
        return hotelID;
    }

    public void setHotelID(int hotelID) {
        this.hotelID = hotelID;
    }

    public int getRoomTypeID() {
        return roomTypeID;
    }

    public void setRoomTypeID(int roomTypeID) {
        this.roomTypeID = roomTypeID;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
}
