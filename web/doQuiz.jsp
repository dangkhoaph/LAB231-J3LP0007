<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/doQuiz.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Do Quiz</title>
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
        <c:set var="cannotStartQuizError" value="${requestScope.CANNOT_START_QUIZ_ERROR}"/>
        <c:if test="${not empty cannotStartQuizError}">
            <div class="alert alert-danger alert-no-quiz" role="alert">
                ${cannotStartQuizError}
                <a href="studentHome.jsp">Back to Home</a>
            </div>
        </c:if>
        <c:set var="quizQuestionList" value="${sessionScope.QUIZ_QUESTION_LIST}"/>
        <c:set var="subjectCode" value="${sessionScope.SUBJECT_CODE}"/>
        <c:set var="subjectName" value="${sessionScope.SUBJECT_NAME}"/>
        <c:set var="questionIndex" value="${sessionScope.CURRENT_QUESTION}"/>
        <c:set var="totalQuestions" value="${sessionScope.NUMBER_OF_QUESTION}"/>
        <c:if test="${not empty quizQuestionList}">
            <form action="DispatchController" method="POST">
                <div class="quiz-info">
                    <table class="table table-borderless">
                        <tbody>
                            <tr class="table-light row">
                                <td class="col-sm-4">
                                    Subject Code:
                                </td>
                                <td class="col-sm-8">
                                    ${subjectCode}
                                </td>
                            </tr>
                            <tr class="table-light row">
                                <td class="col-sm-4">
                                    Subject Name:
                                </td>
                                <td class="col-sm-8">
                                    ${subjectName}
                                </td>
                            </tr>
                            <tr class="table-light row">
                                <td class="col-sm-4">
                                    Timer:
                                </td>
                                <td class="col-sm-8">
                                    ${sessionScope.DURATION}
                                </td>
                            </tr>
                            <tr class="table-light row d-flex justify-content-center">
                                <td colspan="2">
                                    <button type="submit" class="btn btn-primary"name="btnAction" value="Submit Quiz"
                                            onclick="return confirm('Are you sure?');">Submit</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="quiz-doing">
                    <div class="quiz-content form-group">
                        <label class="label-question-no row">Question ${quizQuestionList[questionIndex].no + 1}</label>
                        <label class="label-content row">${quizQuestionList[questionIndex].questionContent}</label>
                        <label class="label-question-no row">Choose a correct answer</label>
                        <div class="form-check">
                            <div class="answer-row row">
                                <input class="form-check-input" type="radio" name="rdAnswer" value="A"
                                       <c:if test="${quizQuestionList[questionIndex].selectedAnswer == 'A'}">checked</c:if>>
                                <label class="answer-content">A. ${quizQuestionList[questionIndex].answerA}</label>
                            </div>
                            <div class="answer-row row">
                                <input class="form-check-input" type="radio" name="rdAnswer" value="B"
                                       <c:if test="${quizQuestionList[questionIndex].selectedAnswer == 'B'}">checked</c:if>>
                                <label class="answer-content">B. ${quizQuestionList[questionIndex].answerB}</label>
                            </div>
                            <div class="answer-row row">
                                <input class="form-check-input" type="radio" name="rdAnswer" value="C"
                                       <c:if test="${quizQuestionList[questionIndex].selectedAnswer == 'C'}">checked</c:if>>
                                <label class="answer-content">C. ${quizQuestionList[questionIndex].answerC}</label>
                            </div>
                            <div class="answer-row row">
                                <input class="form-check-input" type="radio" name="rdAnswer" value="D"
                                       <c:if test="${quizQuestionList[questionIndex].selectedAnswer == 'D'}">checked</c:if>>
                                <label class="answer-content">D. ${quizQuestionList[questionIndex].answerD}</label>
                            </div>
                            <div class="row">
                                <c:if test="${questionIndex > 0}">
                                    <button type="submit" class="btn btn-primary mr-auto"name="btnAction" value="Back Question">Back</button>
                                </c:if>
                                <c:if test="${questionIndex < totalQuestions - 1}">
                                    <button type="submit" class="btn btn-primary ml-auto"name="btnAction" value="Next Question">Next</button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center flex-wrap bg-light">
                        <c:forEach var="i" begin="1" end="${totalQuestions}">
                            <c:if test="${questionIndex == i - 1}">
                                <button type="submit" class="btn btn-danger" name="btnAction" value="Choose Question" onclick="getChoosenQuestion(${i})">${i}</button>
                            </c:if>
                            <c:if test="${questionIndex != i - 1}">
                                <button type="submit" class="btn btn-primary" name="btnAction" value="Choose Question" onclick="getChoosenQuestion(${i})">${i}</button>
                            </c:if>
                        </c:forEach>
                        <input type="hidden" name="chooseQuestion" value="" id="chooseQuestion">
                    </div>
                </div>
            </form>
        </c:if>
        <script>
            function getChoosenQuestion(i) {
                document.getElementById("chooseQuestion").value = i;
            }
        </script>
    </body>
</html>