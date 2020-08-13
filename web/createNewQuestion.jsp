<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/createNewQuestion.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Create new Question</title>
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
        <div class="create-form">
            <form action="DispatchController" method="POST" onsubmit="return confirm('Are you sure to create new question?');">
                <h2>Create New Question</h2>
                <div class="form-group">
                    <label>Question Content</label>
                    <div class="input-group">
                        <textarea class="form-control input-field" name="txtNewQuestionContent" rows="3"></textarea>
                    </div>
                </div>
                <div class="alert alert-danger alert-by-js" role="alert">
                    Question content must not be empty
                </div>
                <div class="form-group">
                    <label>Answer A</label>
                    <div class="input-group">
                        <textarea class="form-control input-field" name="txtAnswerA" rows="1"></textarea>
                    </div>
                </div>
                <div class="alert alert-danger alert-by-js" role="alert">
                    Answer A must not be empty
                </div>
                <div class="form-group">
                    <label>Answer B</label>
                    <div class="input-group">
                        <textarea class="form-control input-field" name="txtAnswerB" rows="1"></textarea>
                    </div>
                </div>
                <div class="alert alert-danger alert-by-js" role="alert">
                    Answer B must not be empty
                </div>
                <div class="form-group">
                    <label>Answer C</label>
                    <div class="input-group">
                        <textarea class="form-control input-field" name="txtAnswerC" rows="1"></textarea>
                    </div>
                </div>
                <div class="alert alert-danger alert-by-js" role="alert">
                    Answer C must not be empty
                </div>
                <div class="form-group">
                    <label>Answer D</label>
                    <div class="input-group">
                        <textarea class="form-control input-field" name="txtAnswerD" rows="1"></textarea>
                    </div>
                </div>
                <div class="alert alert-danger alert-by-js" role="alert">
                    Answer D must not be empty
                </div>
                <div class="form-row">
                    <div class="form-group col-sm-6">
                        <label>Correct Answer</label>
                        <select class="form-control" name="cbCorrectAnswer">
                            <option>A</option>
                            <option>B</option>
                            <option>C</option>
                            <option>D</option>
                        </select>
                    </div>
                    <div class="form-group col-sm-6">
                        <label>Subject</label>
                        <select class="form-control" name="cbSubject">
                            <c:set var="subjectList" value="${requestScope.SUBJECT_LIST}"/>
                            <c:if test="${empty subjectList}">
                                <option>&lt;No subject&gt;</option>
                            </c:if>
                            <c:if test="${not empty subjectList}">
                                <c:forEach var="subject" items="${subjectList}">
                                    <option>${subject}</option>
                                </c:forEach>
                            </c:if>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <input type="hidden" name="txtQuestionContent" value="${requestScope.SEARCH_QUESTION_CONTENT}"/>
                    <input type="hidden" name="txtSubjectCode" value="${requestScope.SEARCH_SUBJECT_CODE}"/>
                    <input type="hidden" name="cbStatus" value="${requestScope.SEARCH_STATUS}"/>
                    <input type="hidden" name="isSearching" value="${requestScope.IS_SEARCHING}"/>
                    <button type="submit" class="btn btn-success btn-block btn-lg" name="btnAction" value="Create New Question"
                            onclick="return validate()">
                        Create New Question
                    </button>
                </div>
                <c:set var="action" value="${param.btnAction}"/>
                <c:if test="${not empty action and action eq 'Create New Question'}">
                    <c:set var="createQuestionFail" value="${requestScope.CREATE_QUESTION_FAIL}"/>
                    <c:if test="${empty createQuestionFail}">
                        <c:set var="createQuestionSuccess" value="${requestScope.CREATE_QUESTION_SUCCESS}"/>
                        <c:if test="${not empty createQuestionSuccess}">
                            <div class="alert alert-info" role="alert">
                                ${createQuestionSuccess}
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${not empty createQuestionFail}">
                        <div class="alert alert-danger" role="alert">
                            ${createQuestionFail}
                        </div>
                    </c:if>
                </c:if>
            </form>
                <c:set var="isSearching" value="${requestScope.IS_SEARCHING}"/>
                <c:if test="${isSearching == true}">
                    <c:url var="urlRewritingBack" value="DispatchController">
                        <c:param name="txtQuestionContent" value="${requestScope.SEARCH_QUESTION_CONTENT}"/>
                        <c:param name="txtSubjectCode" value="${requestScope.SEARCH_SUBJECT_CODE}"/>
                        <c:param name="cbStatus" value="${requestScope.SEARCH_STATUS}"/>
                        <c:param name="btnAction" value="Search"/>
                    </c:url>
                </c:if>
                <c:if test="${isSearching == false}">
                    <c:set var="urlRewritingBack" value="adminHome.jsp"/>
                </c:if>
            <div class="text-center"><a href="${urlRewritingBack}">Back</a></div>
        </div>
        <script>
            function validate() {
                var inputFields = document.getElementsByClassName("input-field");
                var alertBoxes = document.getElementsByClassName("alert-by-js");
                var foundErr = false;
                for (var i = 0; i < inputFields.length; i++) {
                    if (inputFields[i].value.trim() === "") {
                        alertBoxes[i].style.display = "block";
                        foundErr = true;
                    } else {
                        alertBoxes[i].style.display = "none";
                    }
                }
                if (foundErr) {
                    return false;
                } else {
                    return true;
                }
            }
        </script>
    </body>
</html>