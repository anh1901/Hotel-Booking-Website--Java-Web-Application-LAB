/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.daos;

import anh.hotel.dtos.RoomDTO;
import anh.hotel.ultils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import javax.naming.NamingException;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class RoomDAO {

    final static Logger logger = Logger.getLogger(RoomDAO.class.getName());
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public ArrayList<RoomDTO> getRoomsByHotelId(int id) throws NamingException, SQLException {
        logger.info("Get all rooms.");
        ArrayList<RoomDTO> rooms = new ArrayList<>();
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select id,room_name,description,hotel_id,room_type_id,price,photo,available_room FROM room where available_room >0 and hotel_id=?";
                ps = c.prepareStatement(sql);
                ps.setInt(1, id);
                rs = ps.executeQuery();
                while (rs.next()) {
                    RoomDTO room;
                    room = new RoomDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5), rs.getDouble(6), rs.getString(7), rs.getInt(8));
                    rooms.add(room);
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return rooms;
    }

    public RoomDTO getRoomByID(int id) throws NamingException, SQLException {
        logger.info("Get product by ID.");
        RoomDTO room = null;
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select id,room_name,description,hotel_id,room_type_id,price,photo,available_room FROM room where id=?";
                ps = c.prepareStatement(sql);
                ps.setInt(1, id);
                rs = ps.executeQuery();
                if (rs.next()) {
                    room = new RoomDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5), rs.getDouble(6), rs.getString(7), rs.getInt(8));
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return room;
    }

    public HashMap<Integer, Integer> searchRoomAdvance(String location, String start, String end, String roomType) throws NamingException, SQLException {
        HashMap<Integer, Integer> rooms = new HashMap<>();
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select room.id, (room.available_room-sum(case when room.id=room_reserved.room_id and (not(start_date between ? and ?) or not(end_date between ? and ?))then room_reserved.quantity else 0 end)) as available\n"
                        + "from room left join room_reserved on room.id=room_reserved.room_id \n"
                        + "inner join hotel on room.hotel_id=hotel.id \n"
                        + "inner join city on hotel.city_id=city.id\n"
                        + "inner join room_type on room.room_type_id=room_type.id\n"
                        + "where city.city_name like ? \n"
                        + "and room_type.type_name like ?\n"
                        + "group by room.id, room.available_room, room_reserved.room_id, room_reserved.quantity";
                ps = c.prepareStatement(sql);
                ps.setString(1, start);
                ps.setString(2, end);
                ps.setString(3, start);
                ps.setString(4, end);
                ps.setString(5, "%"+location+"%");
                ps.setString(6, "%"+roomType+"%");
                rs = ps.executeQuery();
                while (rs.next()) {
                    rooms.put(rs.getInt(1), rs.getInt(2));
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return rooms;
    }
    public HashMap<Integer, Integer> checkAvailbleRoomAmountByID(int id,String start, String end) throws NamingException, SQLException {
        HashMap<Integer, Integer> room = new HashMap<>();
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select room.id, (room.available_room-sum(case when room.id=room_reserved.room_id and (not(start_date between ? and ?) or not(end_date between ? and ?))then room_reserved.quantity else 0 end)) as available\n"
                        + "from room left join room_reserved on room.id=room_reserved.room_id \n"
                        + "where room.id=? group by room.id, room.available_room, room_reserved.room_id, room_reserved.quantity";
                ps = c.prepareStatement(sql);
                ps.setString(1, start);
                ps.setString(2, end);
                ps.setString(3, start);
                ps.setString(4, end);
                ps.setInt(5, id);
                rs = ps.executeQuery();
                if (rs.next()) {
                    room.put(rs.getInt(1), rs.getInt(2));
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return room;
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
