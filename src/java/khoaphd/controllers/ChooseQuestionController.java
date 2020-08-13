package khoaphd.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import khoaphd.quiz_question.QuizQuestionDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "ChooseQuestionController", urlPatterns = {"/ChooseQuestionController"})
public class ChooseQuestionController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ChooseQuestionController.class);
    private static final String DO_QUIZ_PAGE = "doQuiz.jsp";
    
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
        
        String rdAnswer = request.getParameter("rdAnswer");
        if (rdAnswer == null) {
            rdAnswer = "";
        }
        String chooseQuestionStr = request.getParameter("chooseQuestion");
        int chooseQuestion = Integer.parseInt(chooseQuestionStr);
        String url = DO_QUIZ_PAGE;
        
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                int currentQuestion = (int) session.getAttribute("CURRENT_QUESTION");
                List<QuizQuestionDTO> quizQuestionList = (List<QuizQuestionDTO>) session.getAttribute("QUIZ_QUESTION_LIST");
                
                QuizQuestionDTO dto = quizQuestionList.get(currentQuestion);
                dto.setSelectedAnswer(rdAnswer);
                
                session.setAttribute("CURRENT_QUESTION", chooseQuestion - 1);
                session.setAttribute("QUIZ_QUESTION_LIST", quizQuestionList);
            }
        } catch (Exception ex) {
            LOGGER.fatal(ex.getMessage());
        } finally {
            response.sendRedirect(url);
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