package khoaphd.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "DispatchController", urlPatterns = {"/DispatchController"})
public class DispatchController extends HttpServlet {
    
    private static final String ERROR_PAGE = "error.jsp";
    private static final String LOGIN_CONTROLLER = "LoginController";
    private static final String LOGOUT_CONTROLLER = "LogoutController";
    private static final String SIGN_UP_CONTROLLER = "SignUpController";
    private static final String SEARCH_CONTROLLER = "SearchController";
    private static final String LOAD_BEFORE_CREATE_CONTROLLER = "LoadBeforeCreateController";
    private static final String CREATE_NEW_QUESTION_CONTROLLER = "CreateNewQuestionController";
    private static final String UPDATE_QUESTION_CONTROLLER = "UpdateQuestionController";
    private static final String DELETE_QUESTION_CONTROLLER = "DeleteQuestionController";
    private static final String START_QUIZ_CONTROLLER = "StartQuizController";
    private static final String BACK_QUESTION_CONTROLLER = "BackQuestionController";
    private static final String NEXT_QUESTION_CONTROLLER = "NextQuestionController";
    private static final String CHOOSE_QUESTION_CONTROLLER = "ChooseQuestionController";
    private static final String SUBMIT_QUIZ_CONTROLLER = "SubmitQuizController";

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
        
        String action = request.getParameter("btnAction");
        String url = ERROR_PAGE;
        
        try {
            if (action.equals("Login")) {
                url = LOGIN_CONTROLLER;
            } else if (action.equals("Logout")) {
                url = LOGOUT_CONTROLLER;
            } else if (action.equals("Sign Up")) {
                url = SIGN_UP_CONTROLLER;
            } else if (action.equals("Search")) {
                url = SEARCH_CONTROLLER;
            } else if (action.equals("Load Before Create")) {
                url = LOAD_BEFORE_CREATE_CONTROLLER;
            } else if (action.equals("Create New Question")) {
                url = CREATE_NEW_QUESTION_CONTROLLER;
            } else if (action.equals("Update Question")) {
                url = UPDATE_QUESTION_CONTROLLER;
            } else if (action.equals("Delete Question")) {
                url = DELETE_QUESTION_CONTROLLER;
            } else if (action.equals("Start Quiz")) {
                url = START_QUIZ_CONTROLLER;
            } else if (action.equals("Back Question")) {
                url = BACK_QUESTION_CONTROLLER;
            } else if (action.equals("Next Question")) {
                url = NEXT_QUESTION_CONTROLLER;
            } else if (action.equals("Choose Question")) {
                url = CHOOSE_QUESTION_CONTROLLER;
            } else if (action.equals("Submit Quiz")) {
                url = SUBMIT_QUIZ_CONTROLLER;
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