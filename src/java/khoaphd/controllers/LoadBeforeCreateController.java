package khoaphd.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import khoaphd.subject.SubjectDAO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "LoadBeforeCreateController", urlPatterns = {"/LoadBeforeCreateController"})
public class LoadBeforeCreateController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoadBeforeCreateController.class);
    private static final String ERROR_PAGE = "error.jsp";
    private static final String CREATE_NEW_QUESTION_PAGE = "createNewQuestion.jsp";
    
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
        
        String url = ERROR_PAGE;
        
        String questionContent = request.getParameter("txtQuestionContent");
        String subjectCode = request.getParameter("txtSubjectCode");
        String status = request.getParameter("cbStatus");
        String isSearching = request.getParameter("isSearching");
        
        try {
            SubjectDAO dao = new SubjectDAO();
            List<String> subject = dao.getAllSubjectCodes();
            
            if (!subject.isEmpty()) {
                request.setAttribute("SUBJECT_LIST", subject);
            }
            
            url = CREATE_NEW_QUESTION_PAGE;
            request.setAttribute("SEARCH_QUESTION_CONTENT", questionContent);
            request.setAttribute("SEARCH_SUBJECT_CODE", subjectCode);
            request.setAttribute("SEARCH_STATUS", status);
            request.setAttribute("IS_SEARCHING", isSearching);
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