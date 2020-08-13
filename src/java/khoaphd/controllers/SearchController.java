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
@WebServlet(name = "SearchController", urlPatterns = {"/SearchController"})
public class SearchController extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(SearchController.class);
    private static final String ADMIN_HOME = "adminHome.jsp";

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
        
        String url = ADMIN_HOME;
        String questionContent = request.getParameter("txtQuestionContent");
        String subjectCode = request.getParameter("txtSubjectCode");
        String status = request.getParameter("cbStatus");
        String page = request.getParameter("page");
        int pageNum = 1;
        if (page != null) {
            pageNum = Integer.parseInt(page);
        }
        int totalResult = 0;
        
        try {
            SubjectDAO dao = new SubjectDAO();
            List<String> subject = dao.getAllSubjectCodes();
            
            if (!subject.isEmpty()) {
                request.setAttribute("SUBJECT_LIST", subject);
            }
            
            QuestionDAO questionDAO = new QuestionDAO();
            
            if (status.equals("All")) {
                questionDAO.searchByContentAndCode(questionContent, subjectCode, pageNum);
                totalResult = questionDAO.getTotalOfSearchByContentAndCode(questionContent, subjectCode);
            } else {
                questionDAO.searchByContentAndCodeAndStatus(questionContent, subjectCode, status, pageNum);
                totalResult = questionDAO.getTotalOfSearchByContentAndCodeAndStatus(questionContent, subjectCode, status);
            }
            
            List<QuestionDTO> questionList = questionDAO.getQuestionList();
            if (questionList != null) {
                for (QuestionDTO question : questionList) {
                    AnswerDAO answerDAO = new AnswerDAO();
                    answerDAO.getAnswerByQuestionId(question.getQuestionId());
                    List<AnswerDTO> answerList = answerDAO.getAnswerList();
                    question.setAnswerList(answerList);
                }
                
                request.setAttribute("QUESTION_LIST", questionList);
                int pages = (int) Math.ceil((double) totalResult / QuestionDAO.ROWS_PER_PAGE);
                request.setAttribute("PAGES", pages);
                request.setAttribute("ROWS_PER_PAGE", QuestionDAO.ROWS_PER_PAGE);
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