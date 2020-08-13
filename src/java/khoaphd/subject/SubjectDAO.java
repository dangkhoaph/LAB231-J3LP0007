package khoaphd.subject;

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
public class SubjectDAO implements Serializable {
    
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
    
    private List<SubjectDTO> subjectList;

    public List<SubjectDTO> getSubjectList() {
        return subjectList;
    }
    
    public List<String> getAllSubjectCodes() throws Exception {
        List<String> result = new ArrayList<>();
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT Code FROM Subject";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                while (rs.next()) {                    
                    String code = rs.getString("Code");
                    
                    result.add(code);
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public int getSubjectIdByCode(String code) throws Exception {
        int result = 0;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT SubjectId FROM Subject WHERE Code = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, code);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    result = rs.getInt("SubjectId");
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public void loadAllSubjects() throws Exception {
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT SubjectId, Code, Name, NumberOfQuestion, Duration "
                        + "FROM Subject";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                while (rs.next()) {                    
                    int subjectId = rs.getInt("SubjectId");
                    String code = rs.getString("Code");
                    String name = rs.getString("Name");
                    int numberOfQuestion = rs.getInt("NumberOfQuestion");
                    int duration = rs.getInt("Duration");
                    
                    SubjectDTO dto = new SubjectDTO(subjectId, code, name, numberOfQuestion, duration);
                    
                    if (subjectList == null) {
                        subjectList = new ArrayList<>();
                    }
                    
                    subjectList.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
    }
}