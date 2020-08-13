<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/showQuizResult.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Quiz Result</title>
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
        <c:set var="quizQuestionList" value="${sessionScope.QUIZ_QUESTION_LIST}"/>
        <c:if test="${empty quizQuestionList}">
            <div class="alert alert-danger alert-no-quiz" role="alert">
                <div>
                    Error occurred while showing quiz result
                </div>
                <a href="studentHome.jsp">Back to Home</a>
            </div>
        </c:if>
        <c:if test="${not empty quizQuestionList}">
            <c:set var="numberOfCorrectAnswer" value="${sessionScope.NUMBER_OF_CORRECT_ANSWER}"/>
            <c:set var="score" value="${sessionScope.SCORE}"/>
            <div class="quiz-info">
                <table class="table table-borderless">
                    <tbody>
                        <tr class="table-light row">
                            <td class="col-sm-4">
                                Correct Answers:
                            </td>
                            <td class="col-sm-8">
                                ${numberOfCorrectAnswer}/${quizQuestionList.size()}
                            </td>
                        </tr>
                        <tr class="table-light row">
                            <td class="col-sm-4">
                                Score:
                            </td>
                            <td class="col-sm-8">
                                ${score}/10
                            </td>
                        </tr>
                        <tr class="table-light row">
                            <td class="col-sm-12">
                                <a href="studentHome.jsp">Back to Home</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="quiz-doing">
                <c:forEach var="questionIndex" begin="0" end="${quizQuestionList.size() - 1}">
                    <div class="quiz-content form-group">
                        <c:set var="isCorrect" value="${quizQuestionList[questionIndex].selectedAnswer == quizQuestionList[questionIndex].correctAnswer}"/>
                        <c:if test="${isCorrect}">
                            <div class="correct">Correct</div>
                        </c:if>
                        <c:if test="${not isCorrect}">
                            <div class="incorrect"><span>Incorrect!</span> Correct answer: ${quizQuestionList[questionIndex].correctAnswer}</div>
                        </c:if>
                        <label class="label-question-no row">Question ${quizQuestionList[questionIndex].no + 1}</label>
                        <label class="label-content row">${quizQuestionList[questionIndex].questionContent}</label>
                        <label class="label-question-no row">Choose a correct answer</label>
                        <div class="form-check">
                            <div class="answer-row row">
                                <input class="form-check-input" type="radio" disabled
                                       <c:if test="${quizQuestionList[questionIndex].selectedAnswer == 'A'}">checked</c:if>>
                                <label class="answer-content">A. ${quizQuestionList[questionIndex].answerA}</label>
                            </div>
                            <div class="answer-row row">
                                <input class="form-check-input" type="radio" disabled
                                       <c:if test="${quizQuestionList[questionIndex].selectedAnswer == 'B'}">checked</c:if>>
                                <label class="answer-content">B. ${quizQuestionList[questionIndex].answerB}</label>
                            </div>
                            <div class="answer-row row">
                                <input class="form-check-input" type="radio" disabled
                                       <c:if test="${quizQuestionList[questionIndex].selectedAnswer == 'C'}">checked</c:if>>
                                <label class="answer-content">C. ${quizQuestionList[questionIndex].answerC}</label>
                            </div>
                            <div class="answer-row row">
                                <input class="form-check-input" type="radio" disabled
                                       <c:if test="${quizQuestionList[questionIndex].selectedAnswer == 'D'}">checked</c:if>>
                                <label class="answer-content">D. ${quizQuestionList[questionIndex].answerD}</label>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </body>
</html>