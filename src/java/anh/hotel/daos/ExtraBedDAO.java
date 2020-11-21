/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.daos;

import anh.hotel.dtos.ExtraBedDTO;
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
public class ExtraBedDAO {
    final static Logger logger = Logger.getLogger(CountryDAO.class.getName());
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    public ArrayList<ExtraBedDTO> getExtraBebs() throws NamingException, SQLException{
        logger.info("Get all extra beds info.");
        ArrayList<ExtraBedDTO> extras=new ArrayList<>();
        try{
            c=DBUtils.makeConnection();
            if(c!= null){
                String sql="select id, no_of_bed, extra_cost from extra_bed";
                ps=c.prepareStatement(sql);
                rs=ps.executeQuery();
                while(rs.next()){
                    ExtraBedDTO extra;
                    extra=new ExtraBedDTO(rs.getInt(1), rs.getInt(2), rs.getDouble(3)) ;
                    extras.add(extra);
                }
            }
        }finally{
            closeConnection(c, ps, rs);
        }
        return extras;
    }
    public ExtraBedDTO getExtraBebByID(int id) throws NamingException, SQLException{
        logger.info("Get extra beds info by id.");
        ExtraBedDTO extra=null;
        try{
            c=DBUtils.makeConnection();
            if(c!= null){
                String sql="select id, no_of_bed, extra_cost from extra_bed where id=?";
                ps=c.prepareStatement(sql);
                ps.setInt(1, id);
                rs=ps.executeQuery();
                if(rs.next()){
                    extra=new ExtraBedDTO(rs.getInt(1), rs.getInt(2), rs.getDouble(3)) ;
                }
            }
        }finally{
            closeConnection(c, ps, rs);
        }
        return extra;
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
