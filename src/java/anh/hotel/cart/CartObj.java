/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.cart;

/**
 *
 * @author DELL
 */
import anh.hotel.dtos.BookingDetailsDTO;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import org.apache.log4j.Logger;

public class CartObj implements Serializable {

    final static Logger logger = Logger.getLogger(CartObj.class.getName());

    private String customerID;

    private Map<Integer, BookingDetailsDTO> items;
    private double totalMoney;
    private int tmpKey = 1;

    public double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(double totalMoney) {
        this.totalMoney = totalMoney;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public Map<Integer, BookingDetailsDTO> getItems() {
        return items;
    }

    public void addItemToCart(int roomID, int quantity, int extraBedID, String startDate, String endDate, int numDays, double price) {
        logger.info("Add item to cart.");
        if (this.items == null) {
            this.items = new HashMap<>();
        }
        //int quantity = 1;
        for (Map.Entry<Integer, BookingDetailsDTO> entry : items.entrySet()) {
            if(entry.getValue().getRoomID() == roomID){
                totalMoney-=entry.getValue().getPrices();
                items.remove(entry.getKey());
            }
        }
        BookingDetailsDTO bookingDetailsDTO = new BookingDetailsDTO();
        bookingDetailsDTO.setRoomID(roomID);
        bookingDetailsDTO.setQuantity(quantity);
        bookingDetailsDTO.setExtraBedID(extraBedID);
        bookingDetailsDTO.setStartDate(startDate);
        bookingDetailsDTO.setEndDate(endDate);
        bookingDetailsDTO.setNumDays(numDays);
        bookingDetailsDTO.setPrices(price);
        this.items.put(tmpKey, bookingDetailsDTO);
        tmpKey++;
    }

    public void removeItemFromCart(int id) {
        logger.info("Remove item to cart.");
        if (this.items == null) {
            return;
        }
        if (this.items.containsKey(id)) {
            this.items.remove(id);
            if (this.items.isEmpty()) {
                this.items = null;
            }
        }
    }

}
