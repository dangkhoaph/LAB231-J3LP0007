<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/adminHome.css">
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
        <div class="search-form">
            <c:set var="paramQuestionContent" value="${param.txtQuestionContent}"/>
            <c:set var="paramSubjectCode" value="${param.txtSubjectCode}"/>
            <c:set var="paramStatus" value="${param.cbStatus}"/>
            <c:set var="paramAction" value="${param.btnAction}"/>
            <form action="DispatchController">
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Question Content</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="txtQuestionContent" value="${paramQuestionContent}">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Subject Code</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="txtSubjectCode" value="${paramSubjectCode}">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Status</label>
                    <div class="col-sm-3">
                        <select class="form-control" name="cbStatus">
                            <option <c:if test="${paramStatus eq 'All'}">selected</c:if>>All</option>
                            <option <c:if test="${paramStatus eq 'Active'}">selected</c:if>>Active</option>
                            <option <c:if test="${paramStatus eq 'Deactive'}">selected</c:if>>Deactive</option>
                        </select>
                    </div>
                    <div class="col-sm-2">
                        <button type="submit" class="btn btn-primary search-button" name="btnAction" value="Search">
                            Search
                        </button>
                    </div>
                    <div class="col-sm-5">
                        <input type="hidden" name="isSearching" value="${paramAction eq 'Search'}"/>
                        <c:url var="urlRewritingLoadBeforeCreate" value="DispatchController">
                            <c:param name="btnAction" value="Load Before Create"/>
                            <c:param name="txtQuestionContent" value="${paramQuestionContent}"/>
                            <c:param name="txtSubjectCode" value="${paramSubjectCode}"/>
                            <c:param name="cbStatus" value="${paramStatus}"/>
                            <c:param name="isSearching" value="${paramAction eq 'Search'}"/>
                        </c:url>
                        <a class="btn btn-success create-button" href="${urlRewritingLoadBeforeCreate}">
                            Create New Account
                        </a>
                    </div>
                </div>
            </form>
        </div>
        <c:if test="${not empty requestScope.UPDATE_QUESTION_SUCCESS}">
            <div class="alert alert-info" role="alert">
                ${UPDATE_QUESTION_SUCCESS}
            </div>
        </c:if>
        <c:if test="${not empty requestScope.UPDATE_QUESTION_FAIL}">
            <div class="alert alert-danger" role="alert">
                ${UPDATE_QUESTION_FAIL}
            </div>
        </c:if>
        <c:if test="${not empty requestScope.DELETE_QUESTION_SUCCESS}">
            <div class="alert alert-info" role="alert">
                ${DELETE_QUESTION_SUCCESS}
            </div>
        </c:if>
        <c:if test="${not empty requestScope.DELETE_QUESTION_FAIL}">
            <div class="alert alert-danger" role="alert">
                ${DELETE_QUESTION_FAIL}
            </div>
        </c:if>
        <c:if test="${not empty paramAction and paramAction eq 'Search'}">
            <c:set var="questionList" value="${requestScope.QUESTION_LIST}"/>
            <c:if test="${empty questionList}">
                <div class="alert alert-danger" role="alert">
                    No result is matched
                </div>
            </c:if>
            <c:if test="${not empty questionList}">
                <div class="table-form" id="table-result">
                    <table class="table table-hover table-bordered">
                        <thead class="thead-dark">
                            <tr>
                                <th>#</th>
                                <th class="contain-select">Subject Code</th>
                                <th>Question Content</th>
                                <th class="contain-select">Correct Answer</th>
                                <th>Create Date</th>
                                <th>Status</th>
                                <th>Update</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="page" value="${(not empty param.page) ? param.page : 1}"/>
                            <c:set var="rowsPerPage" value="${requestScope.ROWS_PER_PAGE}"/>
                            <c:set var="subjectList" value="${requestScope.SUBJECT_LIST}"/>
                            <c:forEach var="question" items="${questionList}" varStatus="counter">
                            <form action="DispatchController" method="POST" onsubmit="return confirm('Are you sure?');">
                                <tr class="table-light">
                                    <td>${(page - 1) * rowsPerPage + counter.count}</td>
                                    <td class="contain-select">
                                        <c:if test="${empty subjectList}">
                                            ${question.subjectCode}
                                        </c:if>
                                        <c:if test="${not empty subjectList}">
                                            <select class="form-control" name="cbSubjectCode">
                                                <c:forEach var="subject" items="${subjectList}">
                                                    <option
                                                        <c:if test="${subject eq question.subjectCode}">selected</c:if>>
                                                        ${subject}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </c:if>
                                    </td>
                                    <td>
                                        <textarea class="form-control" name="txtNewQuestionContent" required>${question.questionContent}</textarea>
                                    </td>
                                    <td class="contain-select">
                                        <select class="form-control" name="cbCorrectAnswer">
                                            <c:forEach var="j" begin="1" end="4">
                                                <c:choose>
                                                    <c:when test="${j == 1}">
                                                        <option <c:if test="${question.correctAnswer eq 'A'}">selected</c:if>>
                                                            A
                                                        </option>
                                                    </c:when>
                                                    <c:when test="${j == 2}">
                                                        <option <c:if test="${question.correctAnswer eq 'B'}">selected</c:if>>
                                                            B
                                                        </option>
                                                    </c:when>
                                                    <c:when test="${j == 3}">
                                                        <option <c:if test="${question.correctAnswer eq 'C'}">selected</c:if>>
                                                            C
                                                        </option>
                                                    </c:when>
                                                    <c:when test="${j == 4}">
                                                        <option <c:if test="${question.correctAnswer eq 'D'}">selected</c:if>>
                                                            D
                                                        </option>
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td>${question.createDate}</td>
                                    <td>
                                        <select class="form-control" name="cbQuestionStatus">
                                            <option <c:if test="${question.status eq 'Active'}">selected</c:if>}>Active</option>
                                            <option <c:if test="${question.status eq 'Deactive'}">selected</c:if>>Deactive</option>
                                        </select>
                                    </td>
                                    <td>
                                        <input type="hidden" name="questionId" value="${question.questionId}"/>
                                        <input type="hidden" name="txtQuestionContent" value="${paramQuestionContent}"/>
                                        <input type="hidden" name="txtSubjectCode" value="${paramSubjectCode}"/>
                                        <input type="hidden" name="cbStatus" value="${paramStatus}"/>
                                        <button type="submit" class="btn btn-warning" name="btnAction" value="Update Question">
                                            Update
                                        </button>
                                    </td>
                                    <td>
                                        <button type="submit" class="btn btn-danger" name="btnAction" value="Delete Question">
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                                <c:set var="answerList" value="${question.answerList}"/>
                                <c:forEach var="answer" items="${answerList}" varStatus="ansCounter">
                                <tr class="table-secondary">
                                    <td colspan="2">
                                        <c:if test="${ansCounter.count == 1}">Answer A</c:if>
                                        <c:if test="${ansCounter.count == 2}">Answer B</c:if>
                                        <c:if test="${ansCounter.count == 3}">Answer C</c:if>
                                        <c:if test="${ansCounter.count == 4}">Answer D</c:if>
                                    </td>
                                    <td colspan="4">
                                        <c:if test="${ansCounter.count == 1}">
                                            <textarea class="form-control" name="txtAnswerA" rows="1" required>${answer.answerContent}</textarea>
                                        </c:if>
                                        <c:if test="${ansCounter.count == 2}">
                                            <textarea class="form-control" name="txtAnswerB" rows="1" required>${answer.answerContent}</textarea>
                                        </c:if>
                                        <c:if test="${ansCounter.count == 3}">
                                            <textarea class="form-control" name="txtAnswerC" rows="1" required>${answer.answerContent}</textarea>
                                        </c:if>
                                        <c:if test="${ansCounter.count == 4}">
                                            <textarea class="form-control" name="txtAnswerD" rows="1" required>${answer.answerContent}</textarea>
                                        </c:if>
                                    </td>
                                    <td colspan="2"></td>
                                </tr>
                                </c:forEach>
                            </form>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:set var="pages" value="${requestScope.PAGES}"/>
                <div class="paging">
                    <nav aria-label="Search Result Pages">
                        <ul class="pagination justify-content-center">
                            <c:forEach var="i" begin="1" end="${pages}">
                                <li class="page-item <c:if test="${i == page}">active</c:if>">
                                    <c:url var="urlRewritingPaging" value="DispatchController">
                                        <c:param name="txtQuestionContent" value="${paramQuestionContent}"/>
                                        <c:param name="txtSubjectCode" value="${paramSubjectCode}"/>
                                        <c:param name="cbStatus" value="${paramStatus}"/>
                                        <c:param name="page" value="${i}"/>
                                        <c:param name="btnAction" value="Search"/>
                                    </c:url>
                                    <a class="page-link" href="${urlRewritingPaging}">${i}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </c:if>
    </body>
</html>