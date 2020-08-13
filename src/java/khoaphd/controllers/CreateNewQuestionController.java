package khoaphd.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
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
@WebServlet(name = "CreateNewQuestionController", urlPatterns = {"/CreateNewQuestionController"})
public class CreateNewQuestionController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CreateNewQuestionController.class);
    private static final int STATUS_ACTIVE = 2;
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
        
        String newQuestionContent = request.getParameter("txtNewQuestionContent").trim();
        String answerA = request.getParameter("txtAnswerA").trim();
        String answerB = request.getParameter("txtAnswerB").trim();
        String answerC = request.getParameter("txtAnswerC").trim();
        String answerD = request.getParameter("txtAnswerD").trim();
        String correctAnswer = request.getParameter("cbCorrectAnswer");
        String subjectCode = request.getParameter("cbSubject");
        
        String questionContent = request.getParameter("txtQuestionContent");
        String subject = request.getParameter("txtSubjectCode");
        String status = request.getParameter("cbStatus");
        String isSearching = request.getParameter("isSearching");
        
        boolean result = false;
        String url = CREATE_NEW_QUESTION_PAGE;
        
        try {
            SubjectDAO subjectDAO = new SubjectDAO();
            List<String> subjectCodes = subjectDAO.getAllSubjectCodes();
            if (!subjectCodes.isEmpty()) {
                request.setAttribute("SUBJECT_LIST", subjectCodes);
            }
            
            if (!subjectCode.equals("<No subject>")) {
                int subjectId = subjectDAO.getSubjectIdByCode(subjectCode);
                Timestamp createDate = new Timestamp(System.currentTimeMillis());
                int statusId = STATUS_ACTIVE;
                
                QuestionDTO questionDTO = new QuestionDTO(newQuestionContent, correctAnswer, createDate, subjectId, statusId);
                
                QuestionDAO questionDAO = new QuestionDAO();
                int questionId = questionDAO.insertNewQuestion(questionDTO);
                if (questionId != 0) {
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
                        answerDAO.insertNewAnswer(answerDTO);
                    }
                    
                    result = true;
                }
            }
        } catch (Exception ex) {
            LOGGER.fatal(ex.getMessage());
        } finally {
            if (result) {
                request.setAttribute("CREATE_QUESTION_SUCCESS", "A question was created successfully");
            } else {
                request.setAttribute("CREATE_QUESTION_FAIL", "Error occured while creating question");
            }
            
            request.setAttribute("SEARCH_QUESTION_CONTENT", questionContent);
            request.setAttribute("SEARCH_SUBJECT_CODE", subject);
            request.setAttribute("SEARCH_STATUS", status);
            request.setAttribute("IS_SEARCHING", isSearching);
            
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