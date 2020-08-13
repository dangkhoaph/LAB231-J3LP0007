<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/login.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Login Page</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="nav-item mr-auto">
                <i class="fa fa-graduation-cap fa-2x" aria-hidden="true"></i>
                <span class="brand-name">Quiz Online</span>
            </div>
        </nav>
        <div class="login-form">
            <c:set var="createSuccess" value="${requestScope.ACCOUNT_CREATION_SUCCESS}"/>
            <c:if test="${not empty createSuccess}">
                <div class="alert alert-primary" role="alert">
                    ${createSuccess}
                </div>
            </c:if>
            <form action="DispatchController" method="POST">
                <div class="avatar">
                    <i class="fa fa-user fa-4x" aria-hidden="true"></i>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control input-lg" name="txtEmail" placeholder="Email">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control input-lg" name="txtPassword" placeholder="Password">
                </div>
                <c:set var="error" value="${requestScope.NOT_FOUND}"/>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>
                <div class="form-group d-flex justify-content-center">
                    <button type="submit" class="btn btn-primary btn-lg" name="btnAction" value="Login">Login</button>
                </div>
            </form>
            <div class="hint-text">Don't have an account? <a href="signUp.jsp">Sign up here</a></div>
        </div>
    </body>
</html>