/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.daos;

import anh.hotel.dtos.FeedbackDTO;
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
public class FeedbackDAO {
    final static Logger logger = Logger.getLogger(FeedbackDAO.class.getName());
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    public boolean createFeedback(FeedbackDTO feedbackDTO) throws NamingException, SQLException{
        logger.info("create a feedback.");
        try{
            c=DBUtils.makeConnection();
            if(c!= null){
                String sql="insert into feedback values(?,?,?,?)";
                ps=c.prepareStatement(sql);
                ps.setString(1, feedbackDTO.getFeedback());
                ps.setInt(2, feedbackDTO.getStar());
                ps.setInt(3, feedbackDTO.getRoomID());
                ps.setString(4, feedbackDTO.getEmail());
                if(ps.executeUpdate()>0){
                    return true;
                }
            }
        }finally{
            closeConnection(c, ps, rs);
        }
        return false;
    }
    public ArrayList<FeedbackDTO> getFeedbacksByRoomId(int id) throws NamingException, SQLException{
        logger.info("get feedbacks.");
        ArrayList<FeedbackDTO> feedbackDTOs=new ArrayList<>();
        try{
            c=DBUtils.makeConnection();
            if(c!= null){
                String sql="select id, feedback, rating, room_id, user_email from feedback where room_id=? order by id DESC";
                ps=c.prepareStatement(sql);
                ps.setInt(1, id);
                rs=ps.executeQuery();
                FeedbackDTO feedbackDTO;
                while(rs.next()){
                    feedbackDTO=new FeedbackDTO(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(5));
                    feedbackDTOs.add(feedbackDTO);
                }
            }
        }finally{
            closeConnection(c, ps, rs);
        }
        return feedbackDTOs;
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
