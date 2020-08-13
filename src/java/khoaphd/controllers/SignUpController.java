package khoaphd.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import khoaphd.account.AccountCreationErrors;
import khoaphd.account.AccountDAO;
import khoaphd.account.AccountDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "SignUpController", urlPatterns = {"/SignUpController"})
public class SignUpController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SignUpController.class);
    private static final String SIGN_UP_PAGE = "signUp.jsp";
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String EMAIL_FORMAT = "^[a-z][a-z0-9_\\-]*@[a-z0-9]+(\\.[a-z0-9]{2,3}){1,2}$";
    
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
        
        String url = SIGN_UP_PAGE;
        
        String email = request.getParameter("txtEmail");
        String fullName = request.getParameter("txtFullName");
        String password = request.getParameter("txtPassword");
        String confirm = request.getParameter("txtConfirm");
        
        AccountCreationErrors errors = new AccountCreationErrors();
        boolean foundError = false;
        
        try {
            if (email.trim().length() < 10 || email.trim().length() > 50) {
                foundError = true;
                errors.setEmailLengthError("Email must be from 10 to 50 characters");
            } else if (!email.trim().matches(EMAIL_FORMAT)) {
                foundError = true;
                errors.setEmailFormatError("Invalid email format");
            }
            
            if (fullName.trim().length() < 2 || fullName.trim().length() > 50) {
                foundError = true;
                errors.setFullNameLengthError("Full name must be from 2 to 50 characters");
            }
            
            if (password.trim().length() < 6 || password.trim().length() > 50) {
                foundError = true;
                errors.setPasswordLengthError("Password must be from 6 to 50 characters");
            } else if (!confirm.trim().equals(password.trim())) {
                foundError = true;
                errors.setConfirmNotMatched("Confirm does not match with password");
            }
            
            if (foundError) {
                request.setAttribute("ACCOUNT_CREATION_ERRORS", errors);
            } else {
                AccountDTO dto = new AccountDTO(email, password, fullName);
                AccountDAO dao = new AccountDAO();
                boolean result = dao.insertNewAccount(dto);
                
                if (result) {
                    request.setAttribute("ACCOUNT_CREATION_SUCCESS", "Account was created successfully");
                    url = LOGIN_PAGE;
                }
            }
        } catch (Exception ex) {
            String msgErr = ex.getMessage();
            LOGGER.fatal(msgErr);
            if (msgErr.contains("duplicate")) {
                errors.setEmailIsExisted(email + " is existed!");
                request.setAttribute("ACCOUNT_CREATION_ERRORS", errors);
            }
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