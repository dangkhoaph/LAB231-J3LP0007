package khoaphd.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import khoaphd.question.QuestionDAO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "DeleteQuestionController", urlPatterns = {"/DeleteQuestionController"})
public class DeleteQuestionController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(DeleteQuestionController.class);
    
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
        
        String questionIdString = request.getParameter("questionId");
        int questionId = 0;
        if (questionIdString != null) {
            questionId = Integer.parseInt(questionIdString);
        }
        
        boolean result = false;
        String urlRewriting = "SearchController"
                + "?btnAction=Search";
        
        try {
            if (questionId != 0) {
                QuestionDAO dao = new QuestionDAO();
                result = dao.deleteQuestion(questionId);
            }
        } catch (Exception ex) {
            LOGGER.fatal(ex.getMessage());
        } finally {
            if (result) {
                request.setAttribute("DELETE_QUESTION_SUCCESS", "Question was deleted successfully");
            } else {
                request.setAttribute("DELETE_QUESTION_FAIL", "Error occured while deleting question");
            }
            
            RequestDispatcher rd = request.getRequestDispatcher(urlRewriting);
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