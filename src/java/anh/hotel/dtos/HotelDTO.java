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
public class HotelDTO implements Serializable{
    private int id;
    private String name;
    private String description;
    private int cityID;
    private int categoryID;
    private String status;
    private String photo;
    private double averageRating;

    public HotelDTO(int id, String name, String description, int cityID, int categoryID, String status, String photo, double averageRating) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.cityID = cityID;
        this.categoryID = categoryID;
        this.status = status;
        this.photo = photo;
        this.averageRating = averageRating;
    }
    

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
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

    public int getCityID() {
        return cityID;
    }

    public void setCityID(int cityID) {
        this.cityID = cityID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
