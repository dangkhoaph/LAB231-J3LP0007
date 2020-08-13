package khoaphd.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import khoaphd.answer.AnswerDAO;
import khoaphd.answer.AnswerDTO;
import khoaphd.question.QuestionDAO;
import khoaphd.question.QuestionDTO;
import khoaphd.quiz_question.QuizQuestionDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "StartQuizController", urlPatterns = {"/StartQuizController"})
public class StartQuizController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StartQuizController.class);
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

        String subjectCode = request.getParameter("subjectCode");
        String subjectName = request.getParameter("subjectName");
        String numberOfQuestionStr = request.getParameter("numberOfQuestion");
        String durationStr = request.getParameter("duration");
        String subjectIdStr = request.getParameter("subjectId");

        int numberOfQuestion = Integer.parseInt(numberOfQuestionStr);
        int duration = Integer.parseInt(durationStr);
        int subjectId = Integer.parseInt(subjectIdStr);

        String url = DO_QUIZ_PAGE;

        try {
            QuestionDAO questionDAO = new QuestionDAO();
            questionDAO.selectRandomQuestions(subjectId, numberOfQuestion);
            List<QuestionDTO> questionList = questionDAO.getQuestionList();
            if (questionList == null) {
                request.setAttribute("CANNOT_START_QUIZ_ERROR", "Error occured while starting a quiz");
            } else {
                if (questionList.size() < numberOfQuestion) {
                    request.setAttribute("CANNOT_START_QUIZ_ERROR", "Error occured while starting a quiz");
                } else {
                    List<QuizQuestionDTO> quizQuestionList = new ArrayList<>();

                    for (int i = 0; i < numberOfQuestion; i++) {
                        QuestionDTO questionDTO = questionList.get(i);

                        int questionId = questionDTO.getQuestionId();

                        AnswerDAO answerDAO = new AnswerDAO();
                        answerDAO.getAnswerByQuestionId(questionId);

                        List<AnswerDTO> answerList = answerDAO.getAnswerList();
                        if (answerList != null) {
                            String questionContent = questionDTO.getQuestionContent();
                            String correctAnswer = questionDTO.getCorrectAnswer();

                            String answerA = "";
                            String answerB = "";
                            String answerC = "";
                            String answerD = "";

                            for (AnswerDTO answerDTO : answerList) {
                                switch (answerDTO.getSymbol()) {
                                    case "A":
                                        answerA = answerDTO.getAnswerContent();
                                        break;
                                    case "B":
                                        answerB = answerDTO.getAnswerContent();
                                        break;
                                    case "C":
                                        answerC = answerDTO.getAnswerContent();
                                        break;
                                    case "D":
                                        answerD = answerDTO.getAnswerContent();
                                        break;
                                }
                            }

                            QuizQuestionDTO quizQuestionDTO =
                                    new QuizQuestionDTO(i, questionId, questionContent,
                                            correctAnswer, answerA, answerB, answerC, answerD, "");
                            quizQuestionList.add(quizQuestionDTO);
                        }

                        HttpSession session = request.getSession(false);
                        if (session != null) {
                            session.setAttribute("QUIZ_QUESTION_LIST", quizQuestionList);
                            session.setAttribute("SUBJECT_ID", subjectId);
                            session.setAttribute("SUBJECT_CODE", subjectCode);
                            session.setAttribute("SUBJECT_NAME", subjectName);
                            session.setAttribute("CURRENT_QUESTION", 0);
                            session.setAttribute("NUMBER_OF_QUESTION", numberOfQuestion);
                            session.setAttribute("DURATION", duration);
                            request.setAttribute("TIMER", duration);
                        }
                    }
                }
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