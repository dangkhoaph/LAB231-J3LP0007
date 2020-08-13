package khoaphd.account;

import java.io.Serializable;

/**
 *
 * @author KhoaPHD
 */
public class AccountDTO implements Serializable {
    
    private String email;
    private String password;
    private String name;
    private int roleId;
    private int statusId;

    public AccountDTO() {
    }

    public AccountDTO(String email, String password, String name) {
        this.email = email;
        this.password = password;
        this.name = name;
    }
    
    public AccountDTO(String email, String name, int roleId, int statusId) {
        this.email = email;
        this.name = name;
        this.roleId = roleId;
        this.statusId = statusId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }
}