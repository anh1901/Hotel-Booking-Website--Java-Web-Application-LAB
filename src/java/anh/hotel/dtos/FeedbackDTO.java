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
public class FeedbackDTO implements Serializable{
    private int id;
    private String feedback;
    private int star;
    private int roomID;
    private String email;

    public FeedbackDTO() {
    }

    public FeedbackDTO(String feedback, int star, int roomID,String email) {
        this.feedback = feedback;
        this.star = star;
        this.roomID = roomID;
        this.email=email;
    }

    public FeedbackDTO(int id, String feedback, int star, int roomID, String email) {
        this.id = id;
        this.feedback = feedback;
        this.star = star;
        this.roomID = roomID;
        this.email = email;
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }
    
}
