/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.servlets.customer;

import anh.hotel.cart.CartObj;
import anh.hotel.daos.ReservationDAO;
import anh.hotel.daos.RoomDAO;
import anh.hotel.dtos.BookingDetailsDTO;
import anh.hotel.dtos.ReservationDTO;
import anh.hotel.dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;
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
public class CheckOutServlet extends HttpServlet {

    final static Logger logger = Logger.getLogger(CheckOutServlet.class.getName());
    private static final String FAIL = "invalid.jsp";
    private static final String SUCCESS = "receipt.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FAIL;
        try {
            //order
            HttpSession session = request.getSession(false);
            UserDTO userDTO = (UserDTO) session.getAttribute("USER");
            String email = userDTO.getEmail();
            String discountCode = "0";
            if (!request.getParameter("discountCode").isEmpty()) {
                discountCode = request.getParameter("discountCode");
            }
            String subTotal = request.getParameter("subTotal");
            UUID randomGeneratedReservationID = UUID.randomUUID();
            String reservationID = "" + randomGeneratedReservationID;
            ReservationDTO reservationDTO = new ReservationDTO(reservationID, email, discountCode, Double.parseDouble(subTotal), "Active");
            ReservationDAO reservationDAO = new ReservationDAO();
            if (!reservationDAO.createReservation(reservationDTO)) {
                url = FAIL;
                request.setAttribute("ERROR", "Fail when creating reservation.");
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                //order detail
                ArrayList<BookingDetailsDTO> details = new ArrayList<>();
                BookingDetailsDTO bookingDetailsDTO;
                CartObj cart = (CartObj) session.getAttribute("CART");
                HashMap<Integer, Integer> roomAvailability = new HashMap<>();
                for (int key : cart.getItems().keySet()) {
                    RoomDAO roomDAO = new RoomDAO();
                    bookingDetailsDTO = new BookingDetailsDTO(cart.getItems().get(key).getRoomID(), reservationID, cart.getItems().get(key).getPrices(), cart.getItems().get(key).getQuantity(),
                            cart.getItems().get(key).getStartDate(), cart.getItems().get(key).getEndDate(), cart.getItems().get(key).getExtraBedID(), true);
                    details.add(bookingDetailsDTO);
                    //check available amount
                    if (!roomAvailability.containsKey(cart.getItems().get(key).getRoomID())) {
                        roomAvailability = roomDAO.checkAvailbleRoomAmountByID(cart.getItems().get(key).getRoomID(), cart.getItems().get(key).getStartDate(), cart.getItems().get(key).getEndDate());
                        roomAvailability.put(cart.getItems().get(key).getRoomID(), roomAvailability.get(cart.getItems().get(key).getRoomID()));
                    } else {
                        roomAvailability.put(cart.getItems().get(key).getRoomID(), roomAvailability.get(cart.getItems().get(key).getRoomID()) - cart.getItems().get(key).getQuantity());
                    }
                    if (roomAvailability.get(cart.getItems().get(key).getRoomID()) < 0) {
                        url = FAIL;
                        request.setAttribute("ERROR", "Not enough room in the hotel.Try again later.");
                        request.getRequestDispatcher("invalid.jsp").forward(request, response);
                        request.getRequestDispatcher(url).forward(request, response);
                    }
                }
                for (int i = 0; i < details.size(); i++) {
                    if (!reservationDAO.createReservedRoom(details.get(i))) {
                        url = FAIL;
                        request.setAttribute("ERROR", "Fail when creating booking details.");
                        request.getRequestDispatcher(url).forward(request, response);
                    }
                }
                url = SUCCESS;
                if (url.equalsIgnoreCase(SUCCESS)) {
                    session.removeAttribute("CART");
                }
                session.setAttribute("RESERVATIONID", reservationID);
                response.sendRedirect(url);
            }
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } catch (NamingException ex) {
            logger.error(ex.getMessage());
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
