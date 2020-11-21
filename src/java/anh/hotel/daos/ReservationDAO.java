/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.daos;

import anh.hotel.dtos.BookingDetailsDTO;
import anh.hotel.dtos.ReservationDTO;
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
public class ReservationDAO {

    final static Logger logger = Logger.getLogger(ReservationDAO.class.getName());
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean createReservation(ReservationDTO reservationDTO) throws SQLException, NamingException {
        logger.info("Create reservation.");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "insert into reservation values(?,?,GETDATE(),?,?,?)";
                ps = c.prepareStatement(sql);
                ps.setString(1, reservationDTO.getId());
                ps.setString(2, reservationDTO.getUserEmail());
                ps.setString(3, reservationDTO.getDiscountID());
                ps.setDouble(4, reservationDTO.getSubTotal());
                ps.setString(5, reservationDTO.getStatus());
                if (ps.executeUpdate() > 0) {
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return false;
    }

    public boolean deleteReservation(String id) throws SQLException, NamingException {
        logger.info("Create reservation details.");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update reservation set status='Inactive' where id=?";
                ps = c.prepareStatement(sql);
                ps.setString(1, id);
                if (ps.executeUpdate() > 0) {
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return false;
    }

    public boolean createReservedRoom(BookingDetailsDTO bookingDetailsDTO) throws SQLException, NamingException {
        logger.info("Create reservation details.");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "insert into room_reserved values(?,?,?,?,?,?,?,0)";
                ps = c.prepareStatement(sql);
                ps.setString(1, bookingDetailsDTO.getReservationID());
                ps.setInt(2, bookingDetailsDTO.getRoomID());
                ps.setInt(3, bookingDetailsDTO.getQuantity());
                ps.setDouble(4, bookingDetailsDTO.getPrices());
                ps.setString(5, bookingDetailsDTO.getStartDate());
                ps.setString(6, bookingDetailsDTO.getEndDate());
                ps.setInt(7, bookingDetailsDTO.getExtraBedID());
                if (ps.executeUpdate() > 0) {
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return false;
    }

    public ReservationDTO searchReservaionByID(String id) throws SQLException, NamingException {
        logger.info("Create reservation details.");
        ReservationDTO reservationDTO=null;
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select id, user_email,ts_created, discount_percent_id,total_price, status from reservation where id=? order by ts_created DESC";
                ps = c.prepareStatement(sql);
                ps.setString(1, id);
                rs = ps.executeQuery();
                if (rs.next()) {
                    reservationDTO = new ReservationDTO(rs.getString(1), rs.getString(2), rs.getString(4), rs.getDouble(5), rs.getString(6), rs.getString(3));
                    return reservationDTO;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return reservationDTO;
    }
    public ArrayList<BookingDetailsDTO> getReservationDetailByReservationID(String id) throws SQLException, NamingException {
        logger.info("get reservation details for reservation.");
        ArrayList<BookingDetailsDTO> bookingDetailsDTOs = new ArrayList<>();
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select reservation_id, room_id, quantity,price,start_date,end_date, extra_bed_id, isFeedback, id from room_reserved where reservation_id=? order by start_date DESC";
                ps = c.prepareStatement(sql);
                ps.setString(1, id);
                rs = ps.executeQuery();
                BookingDetailsDTO bookingDetailsDTO;
                while (rs.next()) {
                    boolean isFeedback;
                    isFeedback = rs.getInt(8) != 0;
                    bookingDetailsDTO = new BookingDetailsDTO(rs.getInt(9),rs.getInt(2), rs.getString(1), rs.getDouble(4), rs.getInt(3), rs.getString(5), rs.getString(6), rs.getInt(7), isFeedback);
                    bookingDetailsDTOs.add(bookingDetailsDTO);
                }
                return bookingDetailsDTOs;
            }

        } finally {
            closeConnection(c, ps, rs);
        }
        return bookingDetailsDTOs;
    }

    public ArrayList<ReservationDTO> getReservaionsByUserEmail(String email) throws SQLException, NamingException {
        logger.info("Create reservation details.");
        ArrayList<ReservationDTO> reservationDTOs = new ArrayList<>();
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select id, user_email,ts_created, discount_percent_id,total_price, status from reservation where user_email=? and status='Active' order by ts_created DESC";
                ps = c.prepareStatement(sql);
                ps.setString(1, email);
                rs = ps.executeQuery();
                ReservationDTO reservationDTO;
                while (rs.next()) {
                    reservationDTO = new ReservationDTO(rs.getString(1), rs.getString(2), rs.getString(4), rs.getDouble(5), rs.getString(6), rs.getString(3));
                    reservationDTOs.add(reservationDTO);
                }
                return reservationDTOs;
            }

        } finally {
            closeConnection(c, ps, rs);
        }
        return reservationDTOs;
    }
//    public ArrayList<BookingDetailsDTO> getReservationDetail() throws SQLException, NamingException {
//        logger.info("Create reservation details.");
//        ArrayList<BookingDetailsDTO> bookingDetailsDTOs = new ArrayList<>();
//        try {
//            c = DBUtils.makeConnection();
//            if (c != null) {
//                String sql = "select reservation_id, room_id, quantity,price,start_date,end_date, extra_bed_id, isFeedback, id from room_reserved order by start_date DESC";
//                ps = c.prepareStatement(sql);
//                rs = ps.executeQuery();
//                BookingDetailsDTO bookingDetailsDTO;
//                while (rs.next()) {
//                    boolean isFeedback;
//                    isFeedback = rs.getInt(8) != 0;
//                    bookingDetailsDTO = new BookingDetailsDTO(rs.getInt(9),rs.getInt(2), rs.getString(1), rs.getDouble(4), rs.getInt(3), rs.getString(5), rs.getString(6), rs.getInt(7), isFeedback);
//                    bookingDetailsDTOs.add(bookingDetailsDTO);
//                }
//                return bookingDetailsDTOs;
//            }
//        } finally {
//            closeConnection(c, ps, rs);
//        }
//        return bookingDetailsDTOs;
//    }

    public boolean updateIsFeedbackToTrue(int id) throws SQLException, NamingException {
        logger.info("update status of room of user to feedbacked.");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update room_reserved set isFeedback=1 where id=?";
                ps = c.prepareStatement(sql);
                ps.setInt(1, id);
                if (ps.executeUpdate() > 0) {
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return false;
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
}
