/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.daos;

import anh.hotel.dtos.CityDTO;
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
public class CityDAO {

    final static Logger logger = Logger.getLogger(CityDAO.class.getName());
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public ArrayList<CityDTO> getCitiesByCountryId(int id) throws NamingException, SQLException {
        logger.info("Get all city from country.");
        ArrayList<CityDTO> cities = new ArrayList<>();
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select id, city_name, country_id from city where country_id= ? ";
                ps = c.prepareStatement(sql);
                ps.setInt(1, id);
                rs=ps.executeQuery();
                while (rs.next()) {
                    CityDTO city;
                    city = new CityDTO(rs.getInt(1), rs.getString(2), rs.getInt(3));
                    cities.add(city);
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return cities;
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
