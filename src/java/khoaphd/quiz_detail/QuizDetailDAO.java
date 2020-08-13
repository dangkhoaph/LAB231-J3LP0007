package khoaphd.quiz_detail;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import khoaphd.utils.DBUtilities;

/**
 *
 * @author KhoaPHD
 */
public class QuizDetailDAO implements Serializable {
    
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
    
    public void insertQuizDetail(QuizDetailDTO dto) throws Exception {
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO QuizDetail(QuizId, QuestionId, Answer) "
                        + "VALUES(?, ?, ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, dto.getQuizId());
                preStm.setInt(2, dto.getQuestionId());
                preStm.setString(3, dto.getAnswer());
                preStm.executeUpdate();
            }
        } finally {
            closeConnection();
        }
    }
}