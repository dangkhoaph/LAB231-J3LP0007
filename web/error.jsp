<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/error.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Error</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="nav-item mr-auto">
                <i class="fa fa-graduation-cap fa-2x" aria-hidden="true"></i>
                <span class="brand-name">Quiz Online</span>
            </div>
        </nav>
        <div class="container">
            <div class="col-md-12">
                <div class="error-template">
                    <h1>Oops!</h1>
                    <h2>Sorry, an error has occurred</h2>
                    <div class="error-actions">
                        <c:set var="account" value="${sessionScope.ACCOUNT}"/>
                        <a href="
                           <c:if test="${empty account}">
                               login.jsp
                           </c:if>
                           <c:if test="${not empty account}">
                               <c:if test="${account.roleId eq 1}">
                                   adminHome.jsp
                               </c:if>
                               <c:if test="${account.roleId eq 2}">
                                   studentHome.jsp
                               </c:if>
                           </c:if>
                           " class="btn btn-primary btn-lg">
                            <i class="fa fa-home" aria-hidden="true"></i>Take Me Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>