package khoaphd.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import khoaphd.answer.AnswerDAO;
import khoaphd.answer.AnswerDTO;
import khoaphd.question.QuestionDAO;
import khoaphd.question.QuestionDTO;
import khoaphd.subject.SubjectDAO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "UpdateQuestionController", urlPatterns = {"/UpdateQuestionController"})
public class UpdateQuestionController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UpdateQuestionController.class);
    
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
        
        String subjectCode = request.getParameter("cbSubjectCode");
        String questionContent = request.getParameter("txtNewQuestionContent");
        String correctAnswer = request.getParameter("cbCorrectAnswer");
        String status = request.getParameter("cbQuestionStatus");
        String answerA = request.getParameter("txtAnswerA");
        String answerB = request.getParameter("txtAnswerB");
        String answerC = request.getParameter("txtAnswerC");
        String answerD = request.getParameter("txtAnswerD");
        String questionIdString = request.getParameter("questionId");
        
        int statusId = 0;
        if (status.equals("Active")) {
            statusId = 2;
        } else if (status.equals("Deactive")) {
            statusId = 3;
        }
        int questionId = Integer.parseInt(questionIdString);
        
        boolean resultAll = false;
        String urlRewriting = "SearchController"
                + "?btnAction=Search";
        
        try {
            SubjectDAO subjectDAO = new SubjectDAO();
            int subjectId = subjectDAO.getSubjectIdByCode(subjectCode);
            
            if (subjectId != 0) {
                QuestionDTO questionDTO = new QuestionDTO(questionId, questionContent, correctAnswer, subjectId, statusId);
                
                QuestionDAO questionDAO = new QuestionDAO();
                boolean resultInsertQuestion = questionDAO.updateQuestion(questionDTO);
                
                if (resultInsertQuestion) {
                    for (int i = 0; i < 4; i++) {
                        String symbol = "", answerContent = "";
                        switch (i) {
                            case 0:
                                symbol = "A";
                                answerContent = answerA;
                                break;
                            case 1:
                                symbol = "B";
                                answerContent = answerB;
                                break;
                            case 2:
                                symbol = "C";
                                answerContent = answerC;
                                break;
                            case 3:
                                symbol = "D";
                                answerContent = answerD;
                                break;
                        }
                        
                        AnswerDTO answerDTO = new AnswerDTO(symbol, answerContent, questionId);
                        
                        AnswerDAO answerDAO = new AnswerDAO();
                        answerDAO.updateAnswer(answerDTO);
                    }
                    
                    resultAll = true;
                    
                }
            }
        } catch (Exception ex) {
            LOGGER.fatal(ex.getMessage());
        } finally {
            if (resultAll) {
                request.setAttribute("UPDATE_QUESTION_SUCCESS", "Question was updated successfully");
            } else {
                request.setAttribute("UPDATE_QUESTION_FAIL", "Error occured while updating question");
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