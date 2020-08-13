package khoaphd.account;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import khoaphd.utils.DBUtilities;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author KhoaPHD
 */
public class AccountDAO implements Serializable {
    
    private static final int ROLE_STUDENT = 2;
    private static final int STATUS_NEW = 1;
    private static final int STATUS_ACTIVE = 2;
    
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
    
    public AccountDTO checkLogin(String email, String password) throws Exception {
        String encryptedPassword = DigestUtils.sha256Hex(password);
        AccountDTO dto = null;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT Name, RoleId "
                        + "FROM Account "
                        + "WHERE Email = ? AND Password = ? AND StatusId = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setString(2, encryptedPassword);
                preStm.setInt(3, STATUS_ACTIVE);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("Name");
                    int roleId = rs.getInt("RoleId");
                    
                    dto = new AccountDTO(email, name, roleId, STATUS_ACTIVE);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public boolean insertNewAccount(AccountDTO dto) throws Exception {
        String encryptedPassword = DigestUtils.sha256Hex(dto.getPassword());
        boolean result = false;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO Account(Email, Password, Name, RoleId, StatusId) "
                        + "VALUES(?, ?, ?, ?, ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getEmail());
                preStm.setString(2, encryptedPassword);
                preStm.setString(3, dto.getName());
                preStm.setInt(4, ROLE_STUDENT);
                preStm.setInt(5, STATUS_NEW);
                result = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}