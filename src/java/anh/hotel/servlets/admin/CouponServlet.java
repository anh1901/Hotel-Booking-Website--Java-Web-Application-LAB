/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.servlets.admin;

import anh.hotel.daos.DiscountDAO;
import anh.hotel.dtos.DiscountDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class CouponServlet extends HttpServlet {

    final static Logger logger = Logger.getLogger(CouponServlet.class.getName());
    private final String SUCCESS = "admin/creatediscount.jsp";
    private final String FAIL = "invalid.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FAIL;
        try {
            HttpSession session = request.getSession(false);
            String code=request.getParameter("code");
            String name=request.getParameter("name");
            String percent=request.getParameter("percent");
            String expireDate=request.getParameter("expireDate");
            DiscountDAO discountDAO=new DiscountDAO();
            DiscountDTO discountDTO=new DiscountDTO(code, Double.parseDouble(percent), name, expireDate);
            if(!discountDAO.createCoupon(discountDTO)){
                request.setAttribute("ERROR", "Fail when create coupon");
            }else{
                //reload coupon list
                ArrayList<DiscountDTO> discountDTOs=discountDAO.getCoupons();
                session.setAttribute("coupons", discountDTOs);
                session.setAttribute("MSG", "Create coupon successfully");
                url=SUCCESS;
            }
        } catch (NamingException ex) {
            logger.error(ex.getMessage());
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } finally {
            response.sendRedirect(url);
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
