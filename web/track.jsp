<%-- 
    Document   : track
    Created on : Nov 1, 2020, 1:20:16 PM
    Author     : DELL
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Yellow Moon Shop">
        <meta name="author" content="Anh">
        <title>Booking hotel-Track your reservation</title>
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/shop-homepage.css" rel="stylesheet">    
        <style>
            .txt-center {
                text-align: center;
            }
            .hide {
                display: none;
            }
            .clear {
                float: none;
                clear: both;
            }
            .rating {
                width: 500px;
                unicode-bidi: bidi-override;
                direction: rtl;
                text-align: left;
                position: relative;
            }
            .rating > label {
                float: right;
                display: inline;
                padding: 0;
                margin: 0;
                position: relative;
                width: 50px;
                cursor: pointer;
                color: #000;
                font-size: 40px;
            }
            .rating > label:hover,
            .rating > label:hover ~ label,
            .rating > input.radio-btn:checked ~ label {
                color: transparent;
            }
            .rating > label:hover:before,
            .rating > label:hover ~ label:before,
            .rating > input.radio-btn:checked ~ label:before,
            .rating > input.radio-btn:checked ~ label:before {
                content: "\2605";
                position: absolute;
                left: 0;
                color: #FFD700;
            }

        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="homePage">Hotels Booking</a>
                <c:if test="${not empty sessionScope.USER}">
                    Welcome ${sessionScope.USER.userName}
                </c:if>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="homePage">Home
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cartAccess">Your cart</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="track">Track your Reservation</a>
                        </li>
                        <c:if test="${sessionScope.USER.role ne 'USER' && sessionScope.USER.role ne 'ADMIN'}">
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp">Login Now!</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="signup.jsp">Register Now!</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.USER.role eq 'USER' || sessionScope.USER.role eq 'ADMIN'}">
                            <li class="nav-item">
                                <a class="nav-link" href="logOut">Logout</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav><br><br><br><br>
        <form action="searchReservation" method="POST">
            <div class="container">
                <div class="row">
                    <div class="col-xs-6 col-sm-6 col-md-2 col-lg-3">
                        Reservation ID:
                    </div>
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <input type="text" class="form-control" placeholder="Search by reservation ID" name="searchID" value="${param.searchID}" minlength="0" maxlength="50" required>
                    </div>
                    <input type="submit" value="Search" class="btn btn-dark">
                </div>
            </div>
        </form>
        <div class="container" style="padding-top: 5%; padding-bottom: 15%">
            <h5>Today: ${sessionScope.today}</h5>
            <c:if test="${not empty requestScope.MSG}">
                <p style="color: green">${requestScope.MSG}</p>
            </c:if>
            <div class="row d-flex justify-content-center">
                <h1>Your reservations</h1></br>
                <div class="col-md-12">
                    <%--Dispay search result--%>
                    <c:if test="${isSearch}">
                        <c:set var="searchResult" value="${requestScope.reservation}"/>
                        <c:if test="${empty searchResult}">
                            <h1 style="color: red">No reservation found!!</h1>
                        </c:if>
                        <c:if test="${not empty searchResult}">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>User ID</th>
                                        <th>Order ID</th>
                                        <th>Total</th>
                                        <th>Created</th>
                                        <th>Status</th>
                                        <th>View</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            ${counter.count}
                                        </td>
                                        <td>
                                            ${searchResult.userEmail}
                                        </td>
                                        <td>
                                            ${searchResult.id}
                                        </td>
                                        <td>
                                            <c:set var = "balance" value = "${searchResult.subTotal}" />
                                            <fmt:setLocale value = "vi_VN"/>
                                            <fmt:formatNumber value = "${balance}" type = "currency"/>
                                        </td>
                                        <td>
                                            ${searchResult.createdDateTime}
                                        </td>
                                        <td>
                                            ${searchResult.status}
                                        </td>
                                        <td>
                                            <input type="button" class="btn btn-primary" value="More" data-toggle="collapse" data-target="#demo${counter.count}" class="accordion-toggle">
                                        </td>
                                        <td>
                                            <form action="removeReservation" method="Post">
                                                <a href="#myModal${counter.count}" class="btn btn-secondary" data-toggle="modal">Delete</a>
                                                <%--cofirmation modal--%>
                                                <div id="myModal${counter.count}" class="modal fade">
                                                    <div class="modal-dialog modal-confirm">
                                                        <div class="modal-content">
                                                            <div class="modal-header flex-column">
                                                                <h4 class="modal-title w-100">Are you sure?</h4>	
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <p>Do you really want to remove this from your reservation? This process cannot be undone.</p>
                                                            </div>
                                                            <div class="modal-footer justify-content-center">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                                <input type="hidden" name="reservationID" value="${reservation.id}"/>
                                                                <input type="submit" class="btn btn-danger" value="Remove"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>   
                                            </form>
                                        </td>
                                    </tr>
                                    <tr class="p">
                                        <td colspan="8" class="hiddenRow">
                                            <div class="accordian-body collapse p-3" id="demo${counter.count}">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <td>Room ID</td>
                                                            <td>Quantity</td>
                                                            <td>Unit Price</td>
                                                            <td>Check In</td>
                                                            <td>Check Out</td>
                                                            <td>Feedback & Rating</td>
                                                        <tr>
                                                    </thead>
                                                    <c:forEach items="${requestScope.details}" var="detail" >
                                                        <tbody>
                                                            <tr>
                                                                <td>${detail.roomID}</td>
                                                                <td>${detail.quantity}</td>
                                                                <td><fmt:formatNumber value = "${detail.prices}" type = "currency"/></td>
                                                                <td>${detail.startDate}</td>
                                                                <td>${detail.endDate}</td>
                                                                <c:if test="${detail.endDate gt sessionScope.today}">
                                                                    <td>
                                                                        <strong>You can not feedback this before check out date. </strong>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${detail.endDate lt sessionScope.today}">
                                                                    <c:if test="${detail.isFeedback}">
                                                                        <td>
                                                                            You had feedback this room.//need upgrade
                                                                        </td>
                                                                    </c:if>
                                                                    <c:if test="${!detail.isFeedback}">
                                                                        <td>
                                                                            <div class="txt-center">
                                                                                <form action="feedback" method="POST">
                                                                                    <div class="rating">
                                                                                        <input id="star10${detail.id}" name="star" type="radio" value="10" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                        <label for="star10${detail.id}" >☆</label>
                                                                                        <input id="star9${detail.id}" name="star" type="radio" value="9" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                        <label for="star9${detail.id}" >☆</label>
                                                                                        <input id="star8${detail.id}" name="star" type="radio" value="8" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                        <label for="star8${detail.id}" >☆</label>
                                                                                        <input id="star7${detail.id}" name="star" type="radio" value="7" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                        <label for="star7${detail.id}" >☆</label>
                                                                                        <input id="star6${detail.id}" name="star" type="radio" value="6" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                        <label for="star6${detail.id}" >☆</label>
                                                                                        <input id="star5${detail.id}" name="star" type="radio" value="5" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                        <label for="star5${detail.id}" >☆</label>
                                                                                        <input id="star4${detail.id}" name="star" type="radio" value="4" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                        <label for="star4${detail.id}" >☆</label>
                                                                                        <input id="star3${detail.id}" name="star" type="radio" value="3" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                        <label for="star3${detail.id}" >☆</label>
                                                                                        <input id="star2${detail.id}" name="star" type="radio" value="2" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                        <label for="star2${detail.id}" >☆</label>
                                                                                        <input id="star1${detail.id}" name="star" type="radio" value="1" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                        <label for="star1${detail.id}" >☆</label>
                                                                                        <div class="clear"></div>
                                                                                        <tr class="p">
                                                                                            <td colspan="8" class="hiddenRow">
                                                                                                <div class="accordian-body collapse p-3" id="rate${detail.id}">
                                                                                                    <input type="text" class="form-control" name="feedback" placeholder="What do you think?" required>
                                                                                                    <input type="hidden" name="roomID" value="${detail.roomID}">
                                                                                                    <input type="hidden" name="detailID" value="${detail.id}">
                                                                                                    <input type="hidden" name="userEmail" value="${sessionScope.USER.email}">
                                                                                                    <input type="submit" class="btn btn-success" value="Feedback Now">
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </div>
                                                                                </form>
                                                                            </div>
                                                                        </td>
                                                                    </c:if>
                                                                </c:if>
                                                            </tr>
                                                        </tbody>
                                                    </c:forEach>
                                                </table>
                                            </div> 
                                        </td> 
                                    </tr>
                                </tbody>
                            </table>
                        </c:if>
                    </c:if>
                    <%--Display all by default--%>
                    <c:if test="${empty isSearch}">
                        <c:set var="reservations" value="${requestScope.reservations}"/>
                        <c:if test="${empty reservations}">
                            <h1 style="color: red">No reservation yet!!</h1>
                        </c:if>
                        <c:if test="${not empty reservations}">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>User ID</th>
                                        <th>Order ID</th>
                                        <th>Total</th>
                                        <th>Created</th>
                                        <th>Status</th>
                                        <th>View</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="reservation" items="${reservations}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>
                                                ${reservation.userEmail}
                                            </td>
                                            <td>
                                                ${reservation.id}
                                            </td>
                                            <td>
                                                <c:set var = "balance" value = "${reservation.subTotal}" />
                                                <fmt:setLocale value = "vi_VN"/>
                                                <fmt:formatNumber value = "${balance}" type = "currency"/>
                                            </td>
                                            <td>
                                                ${reservation.createdDateTime}
                                            </td>
                                            <td>
                                                ${reservation.status}
                                            </td>
                                            <td>
                                                <input type="button" class="btn btn-primary" value="More" data-toggle="collapse" data-target="#demo${counter.count}" class="accordion-toggle">
                                            </td>
                                            <td>
                                                <form action="removeReservation" method="Post">
                                                    <a href="#myModal${counter.count}" class="btn btn-secondary" data-toggle="modal">Delete</a>
                                                    <%--cofirmation modal--%>
                                                    <div id="myModal${counter.count}" class="modal fade">
                                                        <div class="modal-dialog modal-confirm">
                                                            <div class="modal-content">
                                                                <div class="modal-header flex-column">
                                                                    <h4 class="modal-title w-100">Are you sure?</h4>	
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <p>Do you really want to remove this from your reservation? This process cannot be undone.</p>
                                                                </div>
                                                                <div class="modal-footer justify-content-center">
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                                    <input type="hidden" name="reservationID" value="${reservation.id}"/>
                                                                    <input type="submit" class="btn btn-danger" value="Remove"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>   
                                                </form>
                                            </td>
                                        </tr>
                                        <tr class="p">
                                            <td colspan="8" class="hiddenRow">
                                                <div class="accordian-body collapse p-3" id="demo${counter.count}">
                                                    <table class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <td>Room ID</td>
                                                                <td>Quantity</td>
                                                                <td>Unit Price</td>
                                                                <td>Check In</td>
                                                                <td>Check Out</td>
                                                                <td>Feedback & Rating</td>
                                                            <tr>
                                                        </thead>
                                                        <c:forEach items="${requestScope.details}" var="detail">
                                                            <c:if test="${detail.reservationID eq reservation.id}">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>${detail.roomID}</td>
                                                                        <td>${detail.quantity}</td>
                                                                        <td><fmt:formatNumber value = "${detail.prices}" type = "currency"/></td>
                                                                        <td>${detail.startDate}</td>
                                                                        <td>${detail.endDate}</td>
                                                                        <c:if test="${detail.endDate gt sessionScope.today}">
                                                                            <td>
                                                                                <strong>You can not feedback this before check out date. </strong>
                                                                            </td>
                                                                        </c:if>
                                                                        <c:if test="${detail.endDate lt sessionScope.today}">
                                                                            <c:if test="${detail.isFeedback}">
                                                                                <td>
                                                                                    You had feedback this room.//need upgrade
                                                                                </td>
                                                                            </c:if>
                                                                            <c:if test="${!detail.isFeedback}">
                                                                                <td>
                                                                                    <div class="txt-center">
                                                                                        <form action="feedback" method="POST">
                                                                                            <div class="rating">
                                                                                                <input id="star10${detail.id}" name="star" type="radio" value="10" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                                <label for="star10${detail.id}" >☆</label>
                                                                                                <input id="star9${detail.id}" name="star" type="radio" value="9" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                                <label for="star9${detail.id}" >☆</label>
                                                                                                <input id="star8${detail.id}" name="star" type="radio" value="8" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                                <label for="star8${detail.id}" >☆</label>
                                                                                                <input id="star7${detail.id}" name="star" type="radio" value="7" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                                <label for="star7${detail.id}" >☆</label>
                                                                                                <input id="star6${detail.id}" name="star" type="radio" value="6" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                                <label for="star6${detail.id}" >☆</label>
                                                                                                <input id="star5${detail.id}" name="star" type="radio" value="5" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                                <label for="star5${detail.id}" >☆</label>
                                                                                                <input id="star4${detail.id}" name="star" type="radio" value="4" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                                <label for="star4${detail.id}" >☆</label>
                                                                                                <input id="star3${detail.id}" name="star" type="radio" value="3" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                                <label for="star3${detail.id}" >☆</label>
                                                                                                <input id="star2${detail.id}" name="star" type="radio" value="2" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                                <label for="star2${detail.id}" >☆</label>
                                                                                                <input id="star1${detail.id}" name="star" type="radio" value="1" class="radio-btn hide" data-toggle="collapse" data-target="#rate${detail.id}" class="accordion-toggle"/>
                                                                                                <label for="star1${detail.id}" >☆</label>
                                                                                                <div class="clear"></div>
                                                                                                <tr class="p">
                                                                                                    <td colspan="8" class="hiddenRow">
                                                                                                        <div class="accordian-body collapse p-3" id="rate${detail.id}">
                                                                                                            <input type="text" class="form-control" name="feedback" placeholder="What do you think?" required>
                                                                                                            <input type="hidden" name="roomID" value="${detail.roomID}">
                                                                                                            <input type="hidden" name="detailID" value="${detail.id}">
                                                                                                            <input type="hidden" name="userEmail" value="${sessionScope.USER.email}">
                                                                                                            <input type="submit" class="btn btn-success" value="Feedback Now">
                                                                                                        </div>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </div>
                                                                                        </form>
                                                                                    </div>
                                                                                </td>
                                                                            </c:if>
                                                                        </c:if>
                                                                    </tr>
                                                                </tbody>
                                                            </c:if>
                                                        </c:forEach>
                                                    </table>
                                                </div> 
                                            </td> 
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </c:if>
                    <a class="btn bg-light" href="javascript:history.back()">Back</a>
                </div>
            </div>
        </div>
        <footer class="fixed-bottom py-2 bg-dark">
            <div class="container">
                <p class="m-0 text-center text-white">Copyright &copy; Yellow Moon Shop 2020</p>
            </div>
        </footer>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>