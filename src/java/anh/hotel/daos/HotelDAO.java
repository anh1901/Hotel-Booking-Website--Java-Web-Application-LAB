/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.daos;

import anh.hotel.dtos.HotelDTO;
import anh.hotel.ultils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class HotelDAO {
    final static Logger logger = Logger.getLogger(HotelDAO.class.getName());
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    private int numberOfHotels;
    
    public ArrayList<HotelDTO> getHotels(int offset, int limit) throws NamingException, SQLException {
        logger.info("Get all hotels.");
        ArrayList<HotelDTO> hotels = new ArrayList<>();
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "Select hotel.id,hotel.hotel_name, hotel.description, hotel.city_id, hotel.category_id, hotel.status, hotel.photo, hotel.average_rating from hotel inner join room on hotel.id=room.hotel_id where hotel.id=room.hotel_id and status='Active' group by hotel.id,hotel.hotel_name, hotel.description, hotel.city_id, hotel.category_id, hotel.status, hotel.photo, hotel.average_rating order by(select null) OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                ps = c.prepareStatement(sql);
                ps.setInt(1, offset);
                ps.setInt(2, limit);
                rs = ps.executeQuery();
                HotelDTO hotelDTO;
                while (rs.next()) {
                    hotelDTO= new HotelDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5), rs.getString(6),rs.getString(7), rs.getDouble(8));
                    hotels.add(hotelDTO);
                }
                sql = "select count(hotel.id) from hotel inner join room on hotel.id=room.hotel_id where hotel.id=room.hotel_id and status='Active' group by hotel.id ";
                ps = c.prepareStatement(sql);
                rs = ps.executeQuery();
                numberOfHotels=0;
                while (rs.next()) {
                    numberOfHotels +=1;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return hotels;
    }
    public ArrayList<HotelDTO> getHotelsByCategoryID(int id,int offset, int limit) throws NamingException, SQLException {
        logger.info("Get all hotels.");
        ArrayList<HotelDTO> hotels = new ArrayList<>();
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "Select hotel.id,hotel.hotel_name, hotel.description, hotel.city_id, hotel.category_id, hotel.status, hotel.photo, hotel.average_rating from hotel inner join room on hotel.id=room.hotel_id where hotel.id=room.hotel_id and status='Active' and category_id=? group by hotel.id,hotel.hotel_name, hotel.description, hotel.city_id, hotel.category_id, hotel.status, hotel.photo, hotel.average_rating order by(select null) OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                ps = c.prepareStatement(sql);
                ps.setInt(1, id);
                ps.setInt(2, offset);
                ps.setInt(3, limit);
                rs = ps.executeQuery();
                HotelDTO hotelDTO;
                while (rs.next()) {
                    hotelDTO= new HotelDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5), rs.getString(6),rs.getString(7), rs.getDouble(8));
                    hotels.add(hotelDTO);
                }
                sql = "select count(hotel.id) from hotel inner join room on hotel.id=room.hotel_id where hotel.id=room.hotel_id and status='Active' and category_id=? group by hotel.id ";
                ps = c.prepareStatement(sql);
                ps.setInt(1, id);
                rs = ps.executeQuery();
                numberOfHotels=0;
                while (rs.next()) {
                    numberOfHotels +=1;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return hotels;
    }
    public void closeConnection(Connection con, PreparedStatement ps, ResultSet rs) throws SQLException {
        if (rs != null && !rs.isClosed()) {
            rs.close();
        }
        if (ps != null && !ps.isClosed()) {
            ps.close();
        }
        if (con != null && !con.isClosed()) {
            con.close();
        }
    }

    public int getNumberOfHotels() {
        return numberOfHotels;
    }
}
