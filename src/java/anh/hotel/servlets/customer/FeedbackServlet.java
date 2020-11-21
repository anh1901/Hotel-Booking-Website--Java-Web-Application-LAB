/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.servlets.customer;

import anh.hotel.daos.FeedbackDAO;
import anh.hotel.daos.ReservationDAO;
import anh.hotel.dtos.FeedbackDTO;
import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class FeedbackServlet extends HttpServlet {
    final static Logger logger = Logger.getLogger(FeedbackDAO.class.getName());
    private static final String FAIL = "invalid.jsp";
    private static final String SUCCESS = "TrackServlet";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url=FAIL;
        try  {
            String star=request.getParameter("star");
            String feedback=request.getParameter("feedback");
            String roomID=request.getParameter("roomID");
            String userEmail=request.getParameter("userEmail");
            String bookingDetailID=request.getParameter("detailID");
            FeedbackDAO feedbackDAO=new FeedbackDAO();
            FeedbackDTO feedbackDTO=new FeedbackDTO(feedback, Integer.parseInt(star), Integer.parseInt(roomID), userEmail);
            if(!feedbackDAO.createFeedback(feedbackDTO)){
                request.setAttribute("ERROR", "Can not send feedback");
            }else{
                request.setAttribute("MSG", "Send feedback successfully");
                ReservationDAO reservationDAO=new ReservationDAO();
                if(!reservationDAO.updateIsFeedbackToTrue(Integer.parseInt(bookingDetailID))){
                    request.setAttribute("ERROR", "Can not update status");
                }else{
                    url=SUCCESS;
                }
            }
        } catch (NamingException ex) {
            logger.error(ex.getMessage());
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        }finally{
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
