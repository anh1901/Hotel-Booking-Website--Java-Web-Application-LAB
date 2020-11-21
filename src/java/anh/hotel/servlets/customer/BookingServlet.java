/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.servlets.customer;

import anh.hotel.daos.DiscountDAO;
import anh.hotel.dtos.UserDTO;
import anh.hotel.ultils.SendMail;
import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;
import javax.mail.MessagingException;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class BookingServlet extends HttpServlet {

    private String host;
    private String port;
    private String email;
    private String pass;

    public void init() {
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        email = context.getInitParameter("email");
        pass = context.getInitParameter("pass");
    }
    final static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(AddRoomToCartServlet.class.getName());
    private final String SUCCESS = "checkout.jsp";
    private final String FAIL = "cart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FAIL;
        String subject = "";
        String content = "";
        try {
            double subTotal = Double.parseDouble(request.getParameter("subTotal"));
            double discount = 0;
            HttpSession session = request.getSession(false);
            if (!request.getParameter("discountCode").isEmpty()) {
                String discountCode = request.getParameter("discountCode");
                DiscountDAO discountDAO = new DiscountDAO();
                if (discountDAO.checkDiscountCode(discountCode)) {
                    discount = discountDAO.getDiscountAmount(discountCode);
                    request.setAttribute("subTotal", subTotal);
                    request.setAttribute("discountCode", discountCode);
                    request.setAttribute("discount", discount);
                    url = SUCCESS;
                } else {
                    request.setAttribute("MSG", "Your discount code is incorrect.");
                }
            } else {
                request.setAttribute("subTotal", subTotal);
                request.setAttribute("discount", discount);
                url = SUCCESS;
            }
            //create random confirm code and send
            UserDTO userDTO = (UserDTO) session.getAttribute("USER");
            String receiver = userDTO.getEmail();
            UUID confirmCode = UUID.randomUUID();
            request.setAttribute("confirmCode", confirmCode);
            subject = confirmCode + " is your confirmation code";
            content = "Hi\nYou are trying to booking room with your email. Your code is " + confirmCode + ".\nAnh.\n\nThis is an automated"
                    + " mail. Please do not reply to this email.";
            SendMail.sendMail(host, port, email, pass, receiver, subject, content);
        } catch (NamingException ex) {
            logger.error(ex.getMessage());
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } catch (MessagingException ex) {
            logger.error(ex.getMessage());
        } finally {
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
