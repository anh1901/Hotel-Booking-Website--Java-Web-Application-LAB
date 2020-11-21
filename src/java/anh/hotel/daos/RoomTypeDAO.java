/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.daos;

import anh.hotel.dtos.RoomTypeDTO;
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
public class RoomTypeDAO {

    final static Logger logger = Logger.getLogger(RoomTypeDAO.class.getName());
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public ArrayList<RoomTypeDTO> getRoomTypes() throws NamingException, SQLException {
        logger.info("Get all room type.");
        ArrayList<RoomTypeDTO> roomTypes = new ArrayList<>();
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select id, type_name from room_type";
                ps = c.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    RoomTypeDTO roomType;
                    roomType = new RoomTypeDTO(rs.getInt(1), rs.getString(2));
                    roomTypes.add(roomType);
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return roomTypes;
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
