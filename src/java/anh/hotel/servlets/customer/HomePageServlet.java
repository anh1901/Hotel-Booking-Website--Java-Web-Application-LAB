/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.servlets.customer;

import anh.hotel.daos.CategoryDAO;
import anh.hotel.daos.CityDAO;
import anh.hotel.daos.CountryDAO;
import anh.hotel.daos.DiscountDAO;
import anh.hotel.daos.ExtraBedDAO;
import anh.hotel.daos.FeedbackDAO;
import anh.hotel.daos.HotelDAO;
import anh.hotel.daos.RoomDAO;
import anh.hotel.daos.RoomTypeDAO;
import anh.hotel.dtos.CategoryDTO;
import anh.hotel.dtos.CityDTO;
import anh.hotel.dtos.CountryDTO;
import anh.hotel.dtos.DiscountDTO;
import anh.hotel.dtos.ExtraBedDTO;
import anh.hotel.dtos.FeedbackDTO;
import anh.hotel.dtos.HotelDTO;
import anh.hotel.dtos.RoomDTO;
import anh.hotel.dtos.RoomTypeDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
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
public class HomePageServlet extends HttpServlet {

    final static Logger logger = Logger.getLogger(HomePageServlet.class.getName());
    ArrayList<HotelDTO> hotels = new ArrayList<>();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try {
            HttpSession session = request.getSession();
            //get today
            logger.info("get today.");
            String today = "" + LocalDate.now();
            session.setAttribute("TODAY", today);
            //load coupon list
            ArrayList<DiscountDTO> discountDTOs;
            DiscountDAO discountDAO=new DiscountDAO();
            discountDTOs = discountDAO.getCoupons();
            session.setAttribute("coupons", discountDTOs);
            //categories
            logger.info("Load categories.");
            ArrayList<CategoryDTO> categories;
            CategoryDAO categoryDAO=new CategoryDAO();
            categories = categoryDAO.getCategories();
            session.setAttribute("categories", categories);
            //countries
            logger.info("Load countries.");
            ArrayList<CountryDTO> countries;
            CountryDAO countryDAO=new CountryDAO();
            countries = countryDAO.getCountries();
            session.setAttribute("countries", countries);
            //cities
            logger.info("Load cities.");
            ArrayList<CityDTO> cities = new ArrayList<>();
            CityDAO cityDAO=new CityDAO();
            for (int i = 0; i < countries.size(); i++) {
                cities.addAll(cityDAO.getCitiesByCountryId(countries.get(i).getId()));
            }
            session.setAttribute("cities", cities);
            //room type
            logger.info("Load room type.");
            ArrayList<RoomTypeDTO> roomTypes;
            RoomTypeDAO roomTypeDAO=new RoomTypeDAO();
            roomTypes = roomTypeDAO.getRoomTypes();
            session.setAttribute("roomTypes", roomTypes);
            //extra bed info
            logger.info("Load extra bed info.");
            ArrayList<ExtraBedDTO> extraBeds;
            ExtraBedDAO extraBedDAO=new ExtraBedDAO();
            extraBeds = extraBedDAO.getExtraBebs();
            session.setAttribute("extraBeds", extraBeds);

            //hotels
            logger.info("Loading hotels and paging");
            HotelDAO hotelDAO = new HotelDAO();
            int page = 1;
            int hotelsPerPage = 20;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            int offset = (page - 1) * hotelsPerPage;
            if (request.getParameter("category") != null) {
                int category = Integer.parseInt(request.getParameter("category"));
                hotels = hotelDAO.getHotelsByCategoryID(category, offset, hotelsPerPage);
            } else {
                hotels = hotelDAO.getHotels(offset, hotelsPerPage);
            }
            //room
            logger.info("Load room.");
            ArrayList<RoomDTO> rooms = new ArrayList<>();
            RoomDAO roomDAO=new RoomDAO();
            for (int i = 0; i < hotels.size(); i++) {
                rooms.addAll(roomDAO.getRoomsByHotelId(hotels.get(i).getId()));
            }
            session.setAttribute("rooms", rooms);
            //load all feedback
            ArrayList<FeedbackDTO> feedbacks=new ArrayList<>();
            FeedbackDAO feedbackDAO=new FeedbackDAO();
            for (int i = 0; i < rooms.size(); i++) {
                feedbacks.addAll(feedbackDAO.getFeedbacksByRoomId(rooms.get(i).getId()));
            }
            session.setAttribute("feedbacks", feedbacks);
            int numberOfHotels = hotelDAO.getNumberOfHotels();
            int numberOfPages = (int) Math.ceil(numberOfHotels * 1.0 / hotelsPerPage);
            session.setAttribute("hotels", hotels);
            request.setAttribute("numberOfPages", numberOfPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("query", request.getParameter("category"));
        } catch (NamingException ex) {
            logger.error(ex.getMessage());
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } finally {
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
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
