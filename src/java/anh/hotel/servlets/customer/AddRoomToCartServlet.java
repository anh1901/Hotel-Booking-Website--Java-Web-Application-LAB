/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.servlets.customer;

import anh.hotel.cart.CartObj;
import anh.hotel.daos.ExtraBedDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.Date;
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
public class AddRoomToCartServlet extends HttpServlet {

    final static Logger logger = Logger.getLogger(AddRoomToCartServlet.class.getName());
    private final String SHOP = "cartAccess";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.info("Add product to cart.");
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try {
            HttpSession session = request.getSession();
            CartObj cartObj = (CartObj) session.getAttribute("CART");
            if (cartObj == null) {
                cartObj = new CartObj();
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            //
            Date start = sdf.parse(request.getParameter("checkInDate"));
            Date end = sdf.parse(request.getParameter("checkOutDate"));
            if (start.after(end)) {
                Date tmp = start;
                start = end;
                end = tmp;
            }
            //count stay days
            int numDays = Period.between(LocalDate.parse(request.getParameter("checkInDate")), LocalDate.parse(request.getParameter("checkOutDate"))).getDays();
            //get extra price
            String[] items = request.getParameterValues("items");
            ExtraBedDAO extraBedDAO = new ExtraBedDAO();
            if (items != null) {
                for (String item : items) {
                    int extraID = 3;
                    double price = 0;
                    if (!request.getParameter("bed" + item).equals("0")) {
                        extraID = Integer.parseInt(request.getParameter("bed" + item));
                        price = (Double.parseDouble(request.getParameter("price" + item)) + extraBedDAO.getExtraBebByID(extraID).getExtraPrice()) * Integer.parseInt(request.getParameter("quantity" + item)) * numDays;
                    } else {
                        price = Double.parseDouble(request.getParameter("price" + item)) * Integer.parseInt(request.getParameter("quantity" + item)) * numDays;
                    }
                    int quantity = Integer.parseInt(request.getParameter("quantity" + item));
                    cartObj.addItemToCart(Integer.parseInt(item),quantity, extraID, request.getParameter("checkInDate"), request.getParameter("checkOutDate"), numDays, price);
                    cartObj.setTotalMoney(cartObj.getTotalMoney() + price);
                    session.setAttribute("CART", cartObj);
                }
            }
        } catch (ParseException ex) {
            logger.error(ex.getMessage());
        } catch (NamingException ex) {
            logger.error(ex.getMessage());
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } finally {
            response.sendRedirect(SHOP);
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
