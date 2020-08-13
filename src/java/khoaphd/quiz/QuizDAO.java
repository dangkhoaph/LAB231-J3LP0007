package khoaphd.quiz;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import khoaphd.utils.DBUtilities;

/**
 *
 * @author KhoaPHD
 */
public class QuizDAO implements Serializable {
    
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
    
    public int insertNewQuiz(QuizDTO dto) throws Exception {
        int result = 0;
        
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO Quiz(CreateDate, Score, SubjectId, Email) "
                        + "OUTPUT inserted.QuizId "
                        + "VALUES(?, ?, ?, ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setTimestamp(1, dto.getCreateDate());
                preStm.setDouble(2, dto.getScore());
                preStm.setInt(3, dto.getSubjectId());
                preStm.setString(4, dto.getEmail());
                rs = preStm.executeQuery();
                if (rs.next()) {
                    result = rs.getInt("QuizId");
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}