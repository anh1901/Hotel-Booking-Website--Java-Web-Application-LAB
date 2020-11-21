/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.servlets.customer;

import anh.hotel.cart.CartObj;
import java.io.IOException;
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
public class ChangeQuantityServlet extends HttpServlet {

    final static Logger logger = Logger.getLogger(ChangeQuantityServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int quantity = Integer.parseInt(request.getParameter("number"));
            int oldQuantity = Integer.parseInt(request.getParameter("oldNumber"));
            String itemKey = request.getParameter("key");
            Double price = Double.parseDouble(request.getParameter("price"));
            HttpSession session = request.getSession(false);
            CartObj cartObj = (CartObj) session.getAttribute("CART");
            if (quantity > oldQuantity) {
                logger.info("Increase room from cart.");
                for (int key : cartObj.getItems().keySet()) {
                    if (key == Integer.parseInt(itemKey)) {
                        cartObj.getItems().get(key).setQuantity(quantity);
                        cartObj.getItems().get(key).setPrices(price * quantity);
                        cartObj.getItems().put(key, cartObj.getItems().get(key));
                        cartObj.setTotalMoney(cartObj.getTotalMoney() + (quantity - oldQuantity) * price);
                    }
                }
            } else if (quantity < oldQuantity) {
                logger.info("Reduce room from cart.");
                for (int key : cartObj.getItems().keySet()) {
                    if (key == Integer.parseInt(itemKey)) {
                        cartObj.getItems().get(key).setQuantity(quantity);
                        cartObj.getItems().get(key).setPrices(price * quantity);
                        cartObj.getItems().put(key, cartObj.getItems().get(key));
                        cartObj.setTotalMoney(cartObj.getTotalMoney() - (oldQuantity - quantity) * price);
                    }
                }
            }
            session.setAttribute("CART", cartObj);
        } finally {
            request.getRequestDispatcher("CartAccessServlet").forward(request, response);
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
