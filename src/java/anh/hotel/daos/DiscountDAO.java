/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.daos;

import anh.hotel.dtos.DiscountDTO;
import anh.hotel.ultils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import javax.naming.NamingException;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class DiscountDAO {
    final static Logger logger = Logger.getLogger(DiscountDAO.class.getName());
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    public boolean checkDiscountCode(String code) throws NamingException, SQLException{
        logger.info("Check if discount code valid.");
        try{
            c=DBUtils.makeConnection();
            if(c!= null){
                String sql="select status from discount where status='Active' and expire_date > ? and id=?";
                ps=c.prepareStatement(sql);
                ps.setString(1, "" + new Timestamp(System.currentTimeMillis()));
                ps.setString(2, code);
                rs=ps.executeQuery();
                if(rs.next()){
                    return true;
                }
            }
        }finally{
            closeConnection(c, ps, rs);
        }
        return false;
    }
    public boolean createCoupon(DiscountDTO discountDTO) throws NamingException, SQLException{
        logger.info("Create discount coupon.");
        try{
            c=DBUtils.makeConnection();
            if(c!= null){
                String sql="insert into discount(id,discount,status,expire_date,coupon_name,create_date) values(?,?,'Active',?,?,?)";
                ps=c.prepareStatement(sql);
                ps.setString(1, discountDTO.getId());
                ps.setDouble(2, discountDTO.getDiscount());
                ps.setString(3, discountDTO.getExpireDate());
                ps.setString(4, discountDTO.getName());
                ps.setString(5, ""+new Timestamp(System.currentTimeMillis()));
                if(ps.executeUpdate()>0){
                    return true;
                }
            }
        }finally{
            closeConnection(c, ps, rs);
        }
        return false;
    }
    public ArrayList<DiscountDTO> getCoupons() throws SQLException, NamingException {
        logger.info("get all coupon");
        ArrayList<DiscountDTO> discountDTOs = new ArrayList<>();
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select id,discount,status,expire_date,coupon_name,create_date from discount where status='Active' order by create_date DESC";
                ps = c.prepareStatement(sql);
                rs = ps.executeQuery();
                DiscountDTO discountDTO;
                while (rs.next()) {
                    discountDTO = new DiscountDTO(rs.getString(1), rs.getDouble(2), rs.getString(5), rs.getString(3), rs.getString(4), rs.getString(6));
                    discountDTOs.add(discountDTO);
                }
                return discountDTOs;
            }

        } finally {
            closeConnection(c, ps, rs);
        }
        return discountDTOs;
    }
    public double getDiscountAmount(String code) throws NamingException, SQLException{
        logger.info("get discount amount.");
        double discount=0.0;
        try{
            c=DBUtils.makeConnection();
            if(c!= null){
                String sql="select discount from discount where status='Active' and expire_date > ? and id=?";
                ps=c.prepareStatement(sql);
                ps.setString(1, "" + new Timestamp(System.currentTimeMillis()));
                ps.setString(2, code);
                rs=ps.executeQuery();
                if(rs.next()){
                    discount=rs.getDouble(1);
                    return discount;
                }
            }
        }finally{
            closeConnection(c, ps, rs);
        }
        return discount;
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
