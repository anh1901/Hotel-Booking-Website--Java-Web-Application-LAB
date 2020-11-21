/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.daos;

import anh.hotel.dtos.UserDTO;
import anh.hotel.ultils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class UserDAO {

    final static Logger logger = Logger.getLogger(UserDAO.class.getName());
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public UserDTO checkLogin(String email, String password) throws NamingException, SQLException {
        logger.info("Check login.");
        UserDTO userDTO = null;
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "Select email,userName, password, roles.name, status, phone, address from users INNER JOIN roles ON  roles.roleID = users.ROLE where email=? and password=? and status='Active'";
                ps = c.prepareStatement(sql);
                ps.setString(1, email);
                ps.setString(2, password);
                rs = ps.executeQuery();
                if (rs.next()) {
                    userDTO = new UserDTO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getString(7));
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return userDTO;
    }

    public boolean createUser(UserDTO userDTO) throws NamingException, SQLException {
        logger.info("Create new user.");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "Insert into users (userName, email, password, role, status,phone, address) values(?,?,?,?,?,?,?)";
                ps = c.prepareStatement(sql);
                ps.setString(1, userDTO.getUserName());
                ps.setString(2, userDTO.getEmail());
                ps.setString(3, userDTO.getPassword());
                ps.setInt(4, Integer.parseInt(userDTO.getRole()));
                ps.setString(5, userDTO.getStatus());
                ps.setInt(6, userDTO.getPhone());
                ps.setString(7, userDTO.getAddress());
                if (ps.executeUpdate() > 0) {
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return false;
    }

    public String getNameFromID(int id) throws NamingException, SQLException {
        logger.info("Get username from ID.");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "Select userName from users where userID=?";
                ps = c.prepareStatement(sql);
                ps.setInt(1, id);
                rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getString(1);
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return "";
    }

    public boolean checkUserExist(String email) throws NamingException, SQLException {
        logger.info("Check if user exist in database.");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "Select status from users where email=?";
                ps = c.prepareStatement(sql);
                ps.setString(1, email);
                rs = ps.executeQuery();
                if (rs.next()) {
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return false;
    }

    public boolean changePassword(String email, String encryptedPassword) throws NamingException, SQLException {
        logger.info("Change password.");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update Users set password= ? where email= ? ";
                ps = c.prepareStatement(sql);
                ps.setString(1, encryptedPassword);
                ps.setString(2, email);
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
