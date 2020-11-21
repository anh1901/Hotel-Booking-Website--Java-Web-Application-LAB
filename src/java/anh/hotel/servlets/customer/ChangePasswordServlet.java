/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.servlets.customer;

import anh.hotel.daos.UserDAO;
import anh.hotel.ultils.EncryptSHA256;
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
public class ChangePasswordServlet extends HttpServlet {
    final static Logger logger = Logger.getLogger(LoginServlet.class.getName());
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String encryptedPassword;
        String url="invalid.jsp";
        try {
            String secureCode=request.getParameter("secureCode");
            String recoverCode=request.getParameter("recoverCode");
            String email=request.getParameter("recoverEmail");
            String password=request.getParameter("password");
            UserDAO userDAO=new UserDAO();
            encryptedPassword = EncryptSHA256.sha256(password);
            if(!secureCode.isEmpty() && !recoverCode.isEmpty() && secureCode.equalsIgnoreCase(recoverCode)){
                if(userDAO.changePassword(email, encryptedPassword)){
                    url="login.jsp";
                    request.setAttribute("MSG", "Change password successfully. Log in now!");
                }else{
                    request.setAttribute("ERROR", "Can not update password!!");
                }
            }else{
                request.setAttribute("MSG", "Don't try to do that!!");
                url="recover.jsp";
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
