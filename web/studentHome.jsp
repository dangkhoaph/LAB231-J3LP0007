<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/studentHome.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Quiz Online</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="nav-item mr-auto">
                <i class="fa fa-graduation-cap fa-2x" aria-hidden="true"></i>
                <span class="brand-name">Quiz Online</span>
            </div>
            <div class="nav-item">
                Welcome, ${sessionScope.ACCOUNT.name} |
                <c:url var="urlRewritingLogout" value="DispatchController">
                    <c:param name="btnAction" value="Logout"/>
                </c:url>
                <a href="${urlRewritingLogout}">Logout</a>
            </div>
        </nav>
        <c:set var="subjectList" value="${requestScope.SUBJECT_LIST}"/>
        <c:if test="${empty subjectList}">
            <div class="alert alert-danger alert-no-quiz" role="alert">
                No quiz is available
            </div>
        </c:if>
        <c:if test="${not empty subjectList}">
            <div class="subject-quiz-table">
                <table class="table ta">
                    <thead class="thead-dark">
                        <tr>
                            <th>Subject code</th>
                            <th>Subject Name</th>
                            <th>Number of Questions</th>
                            <th>Duration</th>
                            <th>Start Quiz</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="subject" items="${subjectList}">
                        <form action="DispatchController" method="POST" onsubmit="return confirm('Are you sure?');">
                            <tr class="table-light">
                                <th>
                                    ${subject.code}
                                    <input type="hidden" name="subjectCode" value="${subject.code}"/>
                                </th>
                                <th>
                                    ${subject.name}
                                    <input type="hidden" name="subjectName" value="${subject.name}"/>
                                </th>
                                <th>
                                    ${subject.numberOfQuestion}
                                    <input type="hidden" name="numberOfQuestion" value="${subject.numberOfQuestion}"/>
                                </th>
                                <th>
                                    ${subject.duration} minutes
                                    <input type="hidden" name="duration" value="${subject.duration}"/>
                                </th>
                                <th>
                                    <button type="submit" class="btn btn-primary" name="btnAction" value="Start Quiz">Start Quiz</button>
                                    <input type="hidden" name="subjectId" value="${subject.subjectId}"/>
                                </th>
                            </tr>
                        </form>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
</body>
</html>