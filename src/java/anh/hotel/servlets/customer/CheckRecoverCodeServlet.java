/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.hotel.servlets.customer;

import anh.hotel.ultils.SendMail;
import java.io.IOException;
import javax.mail.MessagingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class CheckRecoverCodeServlet extends HttpServlet {

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
    final static Logger logger = Logger.getLogger(CheckRecoverCodeServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "confirmcode.jsp";
        String subject = "";
        String content = "";
        try {
            String inputCode = request.getParameter("inputCode");
            String recoverCode = request.getParameter("recoverCode");
            String recoverEmail = request.getParameter("recoverEmail");
            String link="http://localhost:8080/J3.L.P0012.-The-Hotel/changepassword.jsp?recoverEmail="+recoverEmail+"&secureCode="+recoverCode;
            if (inputCode.equalsIgnoreCase(recoverCode)) {
                subject = "Recovery code success. Click the link below to change your password.";
                content = "Hi\nYou are trying to recover your password. Click this link below to change your password.\n<a>"+link+"</a>\nAnh.\n\nThis is an automated"
                        + " mail. Please do not reply to this email.";
                SendMail.sendMail(host, port, email, pass, recoverEmail, subject, content);
                request.setAttribute("recoverCode", recoverCode);
                request.setAttribute("recoverEmail", recoverEmail);
                request.setAttribute("MSG1", "Correct code! Check your email for the link.");
            }else{
                request.setAttribute("recoverCode", recoverCode);
                request.setAttribute("recoverEmail", recoverEmail);
                request.setAttribute("MSG2", "Incorrect code! Input the code again.");
            }
        } catch (MessagingException ex) {
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
