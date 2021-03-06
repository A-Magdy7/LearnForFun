<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html class="no-js" lang="">
<head>
    <title>Games</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/learnforfun.css" />" rel="stylesheet">
    <script type="text/javascript" src="<c:url value="/resources/js/vendor/jquery-1.12.0.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/angular.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/vendor/jquery-1.12.0.min.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />" type="text/javascript">
    </script>
    <script src="<c:url value="/resources/js/angualr-controllers/app.js" />" type="text/javascript">
    </script>
    <script src="<c:url value="/resources/js/angualr-controllers/GameController.js" />" type="text/javascript">
    </script>
    <script src="<c:url value="/resources/js/users.js" />" type="text/javascript">
    </script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            background-image: url("<c:url value="/resources/img/img4.jpg" />");
            background-repeat: no-repeat;
            background-size: 1800px;
        }

        .navbar, .panel {
            box-shadow: 0px 2px 20px 2px black;
            background: transparent;
            border-color: transparent;
        }

        .navbar li {
            color: #000
        }

        .container, .panel-footer {
            background: transparent;
            border-color: transparent;
        }

    </style>
</head>
<body data-ng-app="app" data-ng-controller="GameController">
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="http://localhost:8080/Learn-For-Fun/profile/${type}/${userID}">
                <img src="<c:url value="/resources/img/logo8.png" />" style="margin-top: -16px; height: 50px">
            </a>
        </div>
        <ul class="nav navbar-nav" id="nav-bar">
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn" style="cursor: pointer;">
                    <span class="glyphicon glyphicon-globe" aria-hidden="true"></span>
                    <span class="badge">${number}</span>
                </a>
                <div class="dropdown-content">
                    <c:forEach items="${notifizers}" var="notifizer">
                        <a href="http://localhost:8080/Learn-For-Fun/showGames/teacher/${userID}/${notifizer.courseID}">
                            <span class="glyphicon glyphicon-user" style="color: black"></span>
                            <c:choose>
                                <c:when test="${notifizer.type!='comment'}">
                                    ${notifizer.notifizer} published a new ${notifizer.type} in a course you are registered in.
                                </c:when>
                                <c:otherwise>
                                    ${notifizer.notifizer} commented on your game.
                                </c:otherwise>
                            </c:choose>

                        </a>
                    </c:forEach>
                </div>
            </li>
            <li><a href="http://localhost:8080/Learn-For-Fun/profileSettings/${type}/${userID}"><span
                    class="glyphicon glyphicon-user"></span> ${account.userName}</a></li>
            <li><a href="http://localhost:8080/Learn-For-Fun/signout/${account.userName}"><span
                    class="glyphicon glyphicon-log-out"></span> Sign Out</a></li>
        </ul>
    </div>
</nav>
<input type="hidden" class="form-control" id="type" value="${type}">
<input type="hidden" class="form-control" id="user-id" value="${userID}">
<c:forEach items="${createdCourses}" var="createdCourses">
    <input type="hidden" name="myCourses" value="${createdCourses.ID}">
</c:forEach>
<div class="container">
    <div class="page-header">
        <h1>Games</h1>
    </div>
</div>
<div class="container">
    <div class="row">
        <c:forEach items="${true_falses}" var="tf">
            <div class="col-sm-5">
                <div class="panel-group">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <center>
                                <h4 class="panel-title" style="color: black">
                                    <a data-toggle="collapse" href="#collapseTF${tf.gameID}">${tf.gameName}</a>
                                </h4>
                            </center>
                        </div>
                        <div id="collapseTF${tf.gameID}" class="panel-collapse collapse">
                            <br>
                            <div class="form-group col-lg-default">
                                <div class="alert alert-info alert-dismissable">
                                    <a class="panel-close close" data-dismiss="alert">-</a>
                                    <i class="fa fa-coffee"></i>
                                    <p style="color: black" id="${tf.gameID}.alertTF">Waiting for input....</p>
                                </div>
                                Question :
                                <input type="text" id="TF-Question" class="form-control" placeholder="Enter question"
                                       value="${tf.question}"
                                       readonly>
                                <br>
                                Choose Answer :
                                <br>
                                <input type="radio" class="form-check-input" id="${tf.gameID}.T"
                                       onclick="uncheck('${tf.gameID}.F')" value="true">
                                <label><p style="display: inline;"> True </p></label>
                                <input type="radio" class="form-check-input" id="${tf.gameID}.F"
                                       onclick="uncheck1('${tf.gameID}.T')" value="false">
                                <label><p style="display: inline;"> False </p></label>
                                <center id="${tf.gameID}tfCenter">
                                    <input type="hidden" value="${tf.answer}" id="${tf.gameID}.ans">
                                    <input type="button" value="Submit" class="btn btn-danger"
                                           onclick="checkans('${tf.gameID}')">
                                </center>
                                <script>
                                    var userType = '${type}';
                                    var myCourses = document.getElementsByName("myCourses");
                                    if (userType == "teacher") {
                                        for (var i = 0; i < myCourses.length; i++) {
                                            if (myCourses[i].value == ${tf.courseID}) {
                                                $("#${tf.gameID}tfCenter").append('<input type="button" value="Delete Game" class="btn btn-danger" data-ng-click ="deleteTFGame(${tf.gameID})" >');
                                                break;
                                            }
                                        }
                                    }
                                </script>
                                <script>
                                    function uncheck(input) {
                                        var check = document.getElementById(input);
                                        check.checked = false;
                                    }
                                    function uncheck1(input) {
                                        var check = document.getElementById(input);
                                        check.checked = false;
                                    }
                                    function checkans(input) {
                                        var element = input + '.ans';
                                        var expectedAnswer = document.getElementById(element).value;
                                        element = input + '.T';
                                        var check1 = document.getElementById(element);
                                        var answer;
                                        if (check1.checked)
                                            answer = "true";
                                        element = input + '.F';
                                        var check2 = document.getElementById(element);
                                        if (check2.checked)
                                            answer = "false";
                                        console.log(answer + ' ' + expectedAnswer);
                                        var alert = input + '.alertTF';
                                        var getAlert = document.getElementById(alert);
                                        if (answer == expectedAnswer)
                                            getAlert.innerHTML = "Right Answer";
                                        else getAlert.innerHTML = "Wrong Answer";
                                    }
                                </script>
                                <br>
                                <c:forEach items="${tfComments}" var="comment">
                                    <c:if test="${comment.gameID == tf.gameID}">
                                        <input type="text" class="form-control" value="${comment.comment}"
                                               readonly>
                                    </c:if>
                                </c:forEach>
                                <br>
                                Comment:
                                <input type="text" id="tfComment${tf.gameID}" class="form-control"
                                       placeholder="Enter Comment"
                                >
                                <br>
                                <center>
                                    <input type="button" value="Comment"
                                           data-ng-click='comment("TF",${userID},${tf.gameID},${tf.courseID})'
                                           class="btn btn-danger">
                                </center>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:forEach items="${multipleChoices}" var="mcq">
            <div class="col-sm-5">
                <div class="panel-group">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <center>
                                <h4 class="panel-title" style="color: black">
                                    <a data-toggle="collapse" href="#collapseMCQ${mcq.gameID}">${mcq.gameName}</a>
                                </h4>
                            </center>
                        </div>
                        <div id="collapseMCQ${mcq.gameID}" class="panel-collapse collapse">
                            <div class="form-group col-lg-default">

                                <div class="alert alert-info alert-dismissable">
                                    <a class="panel-close close" data-dismiss="alert">-</a>
                                    <i class="fa fa-coffee"></i>
                                    <p style="color: black" id="${mcq.gameID}.MCQalert">Answer....</p>
                                </div>
                                Game Name :
                                <input type="text" class="form-control" value="${mcq.gameName}"
                                       placeholder="Enter Game Name"
                                       readonly>
                                <br>
                                Question :
                                <input type="text" id="MCQ-Question" value="${mcq.question}" class="form-control"
                                       placeholder="Enter question"
                                       readonly>
                                <br>
                                Choices :
                                <br>
                                <div class="row">
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            1.
                                            <input class="form-control" value="${mcq.choice1}" name="MCQChoices"
                                                   type="text"
                                                   placeholder="Choice 1" readonly>
                                        </div>
                                        <div class="col-sm-6">
                                            2.
                                            <input class="form-control" value="${mcq.choice2}" name="MCQChoices"
                                                   type="text"
                                                   placeholder="Choice 2" readonly>
                                        </div>
                                        <br>
                                        <br>
                                        <div class="col-sm-6">
                                            3.
                                            <input class="form-control" value="${mcq.choice3}" name="MCQChoices"
                                                   type="text"
                                                   placeholder="Choice 3" readonly>
                                        </div>
                                        <div class="col-sm-6">
                                            4.
                                            <input class="form-control" value="${mcq.choice4}" name="MCQChoices"
                                                   type="text"
                                                   placeholder="Choice 4" readonly>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                Your Answer :
                                <div class="row">
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <input class="form-control" id="${mcq.gameID}.MCQans" type="number" min="1"
                                                   max="4" step="1"
                                                   placeholder="Enter right choice number" required>
                                        </div>
                                    </div>
                                </div>
                                <center id="${mcq.gameID}mcqCenter">
                                    <input type="hidden" value="${mcq.answer}" id="${mcq.gameID}.res">
                                    <input type="button" value="Submit" class="btn btn-danger"
                                           onclick="checkMCQans(${mcq.gameID})">
                                </center>
                                <script>
                                    var userType = '${type}';
                                    var myCourses = document.getElementsByName("myCourses");
                                    if (userType == "teacher") {
                                        for (var i = 0; i < myCourses.length; i++) {
                                            if (myCourses[i].value == ${mcq.courseID}) {
                                                $("#${mcq.gameID}mcqCenter").append('<input type="button" value="Delete Game" class="btn btn-danger" data-ng-click ="deleteMCQGame(${mcq.gameID})" >');
                                                break;
                                            }
                                        }
                                    }
                                </script>
                                <script>
                                    function checkMCQans(input) {
                                        var element = input + '.MCQans';
                                        var answer = document.getElementById(element).value;
                                        element = input + '.res';
                                        var expected = document.getElementById(element).value;
                                        var alert = input + '.MCQalert';
                                        var getAlert = document.getElementById(alert);
                                        if (answer == expected)
                                            getAlert.innerHTML = "Right Answer";
                                        else getAlert.innerHTML = "Wrong Answer";
                                    }
                                </script>
                                <br>
                                <c:forEach items="${MCQComments}" var="comment">
                                    <c:if test="${comment.gameID == mcq.gameID}">
                                        <input type="text" class="form-control" value="${comment.comment}"
                                               readonly>
                                    </c:if>
                                </c:forEach>
                                <br>

                                Comment:
                                <input type="text" id="MCQComment${mcq.gameID}" class="form-control"
                                       placeholder="Enter Comment">
                                <br>
                                <center>
                                    <input type="button" value="Comment"
                                           data-ng-click='comment("MCQ",${userID},${mcq.gameID},${mcq.courseID})'
                                           class="btn btn-danger">
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:forEach items="${hangMen}" var="hangman">
            <div class="col-sm-5">
                <div class="panel-group">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <center>
                                <h4 class="panel-title" style="color: black">
                                    <a data-toggle="collapse"
                                       href="#collapseHangMan${hangman.gameID}">${hangman.gameName}</a>
                                </h4>
                            </center>
                        </div>
                        <div id="collapseHangMan${hangman.gameID}" class="panel-collapse collapse">
                            <br>
                            <div class="form-group col-lg-default">
                                <div class="alert alert-info alert-dismissable">
                                    <a class="panel-close close" data-dismiss="alert">-</a>
                                    <i class="fa fa-coffee"></i>
                                    <p style="color: black" id="${hangman.gameID}.Hangmanalert">Answer....</p>
                                </div>
                                Question :
                                <input type="text" id="HangMan-Question" value="${hangman.question}"
                                       class="form-control" placeholder="Enter question"
                                       readonly>
                            </div>
                            <br>
                            <center id="${hangman.gameID}hangmanCenter">
                                <a type="button"
                                   href="http://localhost:8080/Learn-For-Fun/hangMan/${type}/${userID}/${hangman.gameID}"
                                   class="btn btn-danger">
                                    Play Game
                                </a>
                            </center>
                            <script>
                                var userType = '${type}';
                                var myCourses = document.getElementsByName("myCourses");
                                if (userType == "teacher") {
                                    for (var i = 0; i < myCourses.length; i++) {
                                        if (myCourses[i].value == ${hangman.courseID}) {
                                            console.log(${hangman.courseID});

                                            $("#${hangman.gameID}hangmanCenter").append('<input type="button" value="Delete Game" class="btn btn-danger" data-ng-click ="deleteHangMan(${hangman.gameID})" >');
                                            break;
                                        }
                                    }
                                }
                            </script>
                            <br>
                            <c:forEach items="${HangmanComments}" var="comment">
                                <c:if test="${comment.gameID == hangman.gameID}">
                                    <input type="text" class="form-control" value="${comment.comment}"
                                           readonly>
                                </c:if>
                            </c:forEach>
                            <br>

                            Comment:
                            <input type="text" id="HangmanComment${hangman.gameID}" class="form-control"
                                   placeholder="Enter Comment">
                            <br>
                            <center>
                                <input type="button" value="Comment"
                                       data-ng-click='comment("Hangman",${userID},${hangman.gameID},${hangman.courseID})'
                                       class="btn btn-danger">
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<br>
<br>
</body>
</html>
