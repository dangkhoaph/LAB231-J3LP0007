package khoaphd.question;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import khoaphd.utils.DBUtilities;

/**
 *
 * @author KhoaPHD
 */
public class QuestionDAO implements Serializable {
    
    public static final int ROWS_PER_PAGE = 20;
    private static final int STATUS_ACTIVE = 2;
    private static final int STATUS_DEACTIVE = 3;
    
    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    
    private void closeConnection() throws Exception {
        if (rs != null)
            rs.close();
        if (preStm != null)
            preStm.close();
        if (conn != null)
            conn.close();
    }
    
    private List<QuestionDTO> questionList;

    public List<QuestionDTO> getQuestionList() {
        return questionList;
    }
    
    public void searchByContentAndCode(String searchQuestionContent,
            String searchSubjectCode, int page) throws Exception {
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT QuestionId, QuestionContent, CorrectAnswer, CreateDate, Code, Status "
                        + "FROM Question Q, Subject SU, Status ST "
                        + "WHERE Q.SubjectId = SU.SubjectId AND Q.StatusId = ST.StatusId "
                        + "AND QuestionContent LIKE ? AND Code LIKE ? "
                        + "ORDER BY QuestionContent "
                        + "OFFSET ? ROWS "
                        + "FETCH NEXT ? ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + searchQuestionContent + "%");
                preStm.setString(2, "%" + searchSubjectCode + "%");
                preStm.setInt(3, (page - 1) * ROWS_PER_PAGE);
                preStm.setInt(4, ROWS_PER_PAGE);
                rs = preStm.executeQuery();
                while (rs.next()) {                    
                    int questionId = rs.getInt("QuestionId");
                    String questionContent = rs.getString("QuestionContent");
                    String correctAnswer = rs.getString("CorrectAnswer");
                    Timestamp createDate = rs.getTimestamp("CreateDate");
                    String subjectCode = rs.getString("Code");
                    String status = rs.getString("Status");
                    
                    QuestionDTO dto = new QuestionDTO(questionId, questionContent, correctAnswer, createDate, subjectCode, status);
                    
                    if (questionList == null) {
                        questionList = new ArrayList<>();
                    }
                    
                    questionList.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
    }
    
    public int getTotalOfSearchByContentAndCode(String searchQuestionContent,
            String searchSubjectCode) throws Exception {
        int result = 0;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(QuestionId) AS Result "
                        + "FROM Question Q, Subject SU, Status ST "
                        + "WHERE Q.SubjectId = SU.SubjectId AND Q.StatusId = ST.StatusId "
                        + "AND QuestionContent LIKE ? AND Code LIKE ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + searchQuestionContent + "%");
                preStm.setString(2, "%" + searchSubjectCode + "%");
                rs = preStm.executeQuery();
                if (rs.next()) {
                    result = rs.getInt("Result");
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public void searchByContentAndCodeAndStatus(String searchQuestionContent,
            String searchSubjectCode, String searchStatus, int page) throws Exception {
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT QuestionId, QuestionContent, CorrectAnswer, CreateDate, Code "
                        + "FROM Question Q, Subject SU, Status ST "
                        + "WHERE Q.SubjectId = SU.SubjectId AND Q.StatusId = ST.StatusId "
                        + "AND QuestionContent LIKE ? AND Code LIKE ? AND Status = ? "
                        + "ORDER BY QuestionContent "
                        + "OFFSET ? ROWS "
                        + "FETCH NEXT ? ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + searchQuestionContent + "%");
                preStm.setString(2, "%" + searchSubjectCode + "%");
                preStm.setString(3, searchStatus);
                preStm.setInt(4, (page - 1) * ROWS_PER_PAGE);
                preStm.setInt(5, ROWS_PER_PAGE);
                rs = preStm.executeQuery();
                while (rs.next()) {                    
                    int questionId = rs.getInt("QuestionId");
                    String questionContent = rs.getString("QuestionContent");
                    String correctAnswer = rs.getString("CorrectAnswer");
                    Timestamp createDate = rs.getTimestamp("CreateDate");
                    String subjectCode = rs.getString("Code");
                    
                    QuestionDTO dto = new QuestionDTO(questionId, questionContent, correctAnswer, createDate, subjectCode, searchStatus);
                    
                    if (questionList == null) {
                        questionList = new ArrayList<>();
                    }
                    
                    questionList.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
    }
    
    public int getTotalOfSearchByContentAndCodeAndStatus(String searchQuestionContent,
            String searchSubjectCode, String searchStatus) throws Exception {
        int result = 0;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(QuestionId) AS Result "
                        + "FROM Question Q, Subject SU, Status ST "
                        + "WHERE Q.SubjectId = SU.SubjectId AND Q.StatusId = ST.StatusId "
                        + "AND QuestionContent LIKE ? AND Code LIKE ? AND Status = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + searchQuestionContent + "%");
                preStm.setString(2, "%" + searchSubjectCode + "%");
                preStm.setString(3, searchStatus);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    result = rs.getInt("Result");
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public int insertNewQuestion(QuestionDTO dto) throws Exception {
        int id = 0;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO Question(QuestionContent, CorrectAnswer, CreateDate, SubjectId, StatusId) "
                        + "OUTPUT inserted.QuestionId "
                        + "VALUES(?, ?, ?, ?, ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getQuestionContent());
                preStm.setString(2, dto.getCorrectAnswer());
                preStm.setTimestamp(3, dto.getCreateDate());
                preStm.setInt(4, dto.getSubjectId());
                preStm.setInt(5, dto.getStatusId());
                rs = preStm.executeQuery();
                if (rs.next()) {
                    id = rs.getInt("QuestionId");
                }
            }
        } finally {
            closeConnection();
        }
        return id;
    }
    
    public boolean updateQuestion(QuestionDTO dto) throws Exception {
        boolean result = false;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Question "
                        + "SET QuestionContent = ?, CorrectAnswer = ?, SubjectId = ?, StatusId = ? "
                        + "WHERE QuestionId = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getQuestionContent());
                preStm.setString(2, dto.getCorrectAnswer());
                preStm.setInt(3, dto.getSubjectId());
                preStm.setInt(4, dto.getStatusId());
                preStm.setInt(5, dto.getQuestionId());
                result = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public boolean deleteQuestion(int questionId) throws Exception {
        boolean result = false;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Question "
                        + "SET StatusId = ? "
                        + "WHERE QuestionId = ? AND StatusId = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, STATUS_DEACTIVE);
                preStm.setInt(2, questionId);
                preStm.setInt(3, STATUS_ACTIVE);
                result = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public void selectRandomQuestions(int subjectId, int numberOfQuestion) throws Exception {
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT TOP (?) QuestionId, QuestionContent, CorrectAnswer "
                        + "FROM Question "
                        + "WHERE SubjectId = ? AND StatusId = ? "
                        + "ORDER BY NEWID()";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, numberOfQuestion);
                preStm.setInt(2, subjectId);
                preStm.setInt(3, STATUS_ACTIVE);
                rs = preStm.executeQuery();
                while (rs.next()) {                    
                    int questionId = rs.getInt("QuestionId");
                    String questionContent = rs.getString("QuestionContent");
                    String correctAnswer = rs.getString("CorrectAnswer");
                    
                    QuestionDTO dto = new QuestionDTO(questionId, questionContent, correctAnswer);
                    
                    if (questionList == null) {
                        questionList = new ArrayList<>();
                    }
                    
                    questionList.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
    }
}