package khoaphd.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import khoaphd.account.AccountDAO;
import khoaphd.account.AccountDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoginController.class);
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String ADMIN_HOME = "adminHome.jsp";
    private static final String PROCESS_BEFORE_STUDENT_CONTROLLER = "ProcessBeforeStudentController";
    private static final int ADMIN = 1;
    private static final int STUDENT = 2;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("txtEmail");
        String password = request.getParameter("txtPassword");
        String url = LOGIN_PAGE;
        
        try {
            AccountDAO dao = new AccountDAO();
            AccountDTO dto = dao.checkLogin(email, password);
            if (dto != null) {
                if (dto.getRoleId() == ADMIN || dto.getRoleId() == STUDENT) {
                    HttpSession session = request.getSession();
                    session.setAttribute("ACCOUNT", dto);
                }
                
                switch (dto.getRoleId()) {
                    case ADMIN:
                        url = ADMIN_HOME;
                        break;
                    case STUDENT:
                        url = PROCESS_BEFORE_STUDENT_CONTROLLER;
                        break;
                    default:
                        request.setAttribute("NOT_FOUND", "User cannot be found");
                        break;
                }
            } else {
                request.setAttribute("NOT_FOUND", "User cannot be found");
            }
        } catch (Exception ex) {
            LOGGER.fatal(ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
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