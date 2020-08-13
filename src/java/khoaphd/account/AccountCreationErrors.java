package khoaphd.account;

import java.io.Serializable;

/**
 *
 * @author KhoaPHD
 */
public class AccountCreationErrors implements Serializable {
    
    private String emailLengthError;
    private String emailFormatError;
    private String fullNameLengthError;
    private String passwordLengthError;
    private String confirmNotMatched;
    private String emailIsExisted;

    public AccountCreationErrors() {
    }

    public String getEmailLengthError() {
        return emailLengthError;
    }

    public void setEmailLengthError(String emailLengthError) {
        this.emailLengthError = emailLengthError;
    }

    public String getEmailFormatError() {
        return emailFormatError;
    }

    public void setEmailFormatError(String emailFormatError) {
        this.emailFormatError = emailFormatError;
    }

    public String getFullNameLengthError() {
        return fullNameLengthError;
    }

    public void setFullNameLengthError(String fullNameLengthError) {
        this.fullNameLengthError = fullNameLengthError;
    }

    public String getPasswordLengthError() {
        return passwordLengthError;
    }

    public void setPasswordLengthError(String passwordLengthError) {
        this.passwordLengthError = passwordLengthError;
    }

    public String getConfirmNotMatched() {
        return confirmNotMatched;
    }

    public void setConfirmNotMatched(String confirmNotMatched) {
        this.confirmNotMatched = confirmNotMatched;
    }

    public String getEmailIsExisted() {
        return emailIsExisted;
    }

    public void setEmailIsExisted(String emailIsExisted) {
        this.emailIsExisted = emailIsExisted;
    }
}