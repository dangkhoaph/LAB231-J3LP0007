package khoaphd.answer;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import khoaphd.utils.DBUtilities;

/**
 *
 * @author KhoaPHD
 */
public class AnswerDAO implements Serializable {
    
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
    
    private List<AnswerDTO> answerList;

    public List<AnswerDTO> getAnswerList() {
        return answerList;
    }
    
    public void getAnswerByQuestionId(int questionId) throws Exception {
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT AnswerId, Symbol, AnswerContent "
                        + "FROM Answer "
                        + "WHERE QuestionId = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, questionId);
                rs = preStm.executeQuery();
                while (rs.next()) {                    
                    int answerId = rs.getInt("AnswerId");
                    String symbol = rs.getString("Symbol");
                    String answerContent = rs.getString("AnswerContent");
                    
                    AnswerDTO dto = new AnswerDTO(answerId, symbol, answerContent);
                    
                    if (answerList == null) {
                        answerList = new ArrayList<>();
                    }
                    
                    answerList.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
    }
    
    public void insertNewAnswer(AnswerDTO dto) throws Exception {
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO Answer(Symbol, AnswerContent, QuestionId) "
                        + "VALUES(?, ?, ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getSymbol());
                preStm.setString(2, dto.getAnswerContent());
                preStm.setInt(3, dto.getQuestionId());
                preStm.executeUpdate();
            }
        } finally {
            closeConnection();
        }
    }
    
    public void updateAnswer(AnswerDTO dto) throws Exception {
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Answer "
                        + "SET AnswerContent = ? "
                        + "WHERE QuestionId = ? AND Symbol = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getAnswerContent());
                preStm.setInt(2, dto.getQuestionId());
                preStm.setString(3, dto.getSymbol());
                preStm.executeUpdate();
            }
        } finally {
            closeConnection();
        }
    }
}