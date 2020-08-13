<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/signUp.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Sign Up Page</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="nav-item mr-auto">
                <i class="fa fa-graduation-cap fa-2x" aria-hidden="true"></i>
                <span class="brand-name">Quiz Online</span>
            </div>
        </nav>
        <div class="signup-form">
            <form action="DispatchController" method="POST">
                <c:set var="errors" value="${requestScope.ACCOUNT_CREATION_ERRORS}"/>
                <h2>Create Account</h2>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fa fa-envelope" aria-hidden="true"></i></span>
                        </div>
                        <input type="text" class="form-control" placeholder="Email" name="txtEmail" value="${param.txtEmail}">
                    </div>
                </div>
                <c:if test="${not empty errors.emailLengthError}">
                    <div class="alert alert-danger" role="alert">
                        ${errors.emailLengthError}
                    </div>
                </c:if>
                <c:if test="${not empty errors.emailFormatError}">
                    <div class="alert alert-danger" role="alert">
                        ${errors.emailFormatError}
                    </div>
                </c:if>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fa fa-user" aria-hidden="true"></i></span>
                        </div>
                        <input type="text" class="form-control" placeholder="Full Name" name="txtFullName" value="${param.txtFullName}">
                    </div>
                </div>
                <c:if test="${not empty errors.fullNameLengthError}">
                    <div class="alert alert-danger" role="alert">
                        ${errors.fullNameLengthError}
                    </div>
                </c:if>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fa fa-lock" aria-hidden="true"></i></span>
                        </div>
                        <input type="password" class="form-control" placeholder="Password" name="txtPassword">
                    </div>
                </div>
                <c:if test="${not empty errors.passwordLengthError}">
                    <div class="alert alert-danger" role="alert">
                        ${errors.passwordLengthError}
                    </div>
                </c:if>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fa fa-check" aria-hidden="true"></i></span>
                        </div>
                        <input type="password" class="form-control" placeholder="Confirm Password" name="txtConfirm">
                    </div>
                </div>
                <c:if test="${not empty errors.confirmNotMatched}">
                    <div class="alert alert-danger" role="alert">
                        ${errors.confirmNotMatched}
                    </div>
                </c:if>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-block btn-lg" name="btnAction" value="Sign Up">Sign Up</button>
                </div>
                <c:if test="${not empty errors.emailIsExisted}">
                    <div class="alert alert-danger" role="alert">
                        ${errors.emailIsExisted}
                    </div>
                </c:if>
            </form>
            <div class="text-center">Already have an account? <a href="login.jsp">Login here</a></div>
        </div>
    </body>
</html>