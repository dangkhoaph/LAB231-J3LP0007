package khoaphd.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import khoaphd.account.AccountDTO;
import khoaphd.quiz.QuizDAO;
import khoaphd.quiz.QuizDTO;
import khoaphd.quiz_detail.QuizDetailDAO;
import khoaphd.quiz_detail.QuizDetailDTO;
import khoaphd.quiz_question.QuizQuestionDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "SubmitQuizController", urlPatterns = {"/SubmitQuizController"})
public class SubmitQuizController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SubmitQuizController.class);
    private static final String SHOW_QUIZ_RESULT = "showQuizResult.jsp";
    
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
        String url = SHOW_QUIZ_RESULT;
        
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                int currentQuestion = (int) session.getAttribute("CURRENT_QUESTION");
                List<QuizQuestionDTO> quizQuestionList = (List<QuizQuestionDTO>) session.getAttribute("QUIZ_QUESTION_LIST");
                
                QuizQuestionDTO quizQuestionDTO = quizQuestionList.get(currentQuestion);
                quizQuestionDTO.setSelectedAnswer(rdAnswer);
                
                int numberOfCorrectAnswers = 0;
                for (QuizQuestionDTO forQuizQuestionDTO : quizQuestionList) {
                    if (forQuizQuestionDTO.getSelectedAnswer().equals(forQuizQuestionDTO.getCorrectAnswer())) {
                        numberOfCorrectAnswers++;
                    }
                }
                
                Timestamp createDate = new Timestamp(System.currentTimeMillis());
                int numberOfQuestion = (int) session.getAttribute("NUMBER_OF_QUESTION");
                double score = (double) numberOfCorrectAnswers / numberOfQuestion * 10;
                int subjectId = (int) session.getAttribute("SUBJECT_ID");
                AccountDTO accountDTO = (AccountDTO) session.getAttribute("ACCOUNT");
                String email = accountDTO.getEmail();
                
                QuizDTO quizDTO = new QuizDTO(createDate, score, subjectId, email);
                QuizDAO quizDAO = new QuizDAO();
                int quizId = quizDAO.insertNewQuiz(quizDTO);
                if (quizId != 0) {
                    for (QuizQuestionDTO forQuizQuestionDTO : quizQuestionList) {
                        int questionId = forQuizQuestionDTO.getQuestionId();
                        String answer = forQuizQuestionDTO.getSelectedAnswer();
                        
                        QuizDetailDTO quizDetailDTO = new QuizDetailDTO(quizId, questionId, answer);
                        
                        QuizDetailDAO quizDetailDAO = new QuizDetailDAO();
                        quizDetailDAO.insertQuizDetail(quizDetailDTO);
                    }
                    
                    session.setAttribute("QUIZ_QUESTION_LIST", quizQuestionList);
                    session.setAttribute("NUMBER_OF_CORRECT_ANSWER", numberOfCorrectAnswers);
                    session.setAttribute("SCORE", score);
                }
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