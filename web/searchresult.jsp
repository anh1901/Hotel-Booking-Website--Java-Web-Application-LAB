<%-- 
    Document   : searchresult
    Created on : Oct 30, 2020, 8:16:00 AM
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
        <meta name="description" content="">
        <meta name="author" content="Anh">
        <title>Hotels Booking - Search room</title>
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/shop-homepage.css" rel="stylesheet">
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
                        <li class="nav-item active">
                            <a class="nav-link" href="#">Home
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cartAccess">Your cart</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="track">Track your Reservation</a>
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
        </nav><br>
        <div class="border rounded" style="position: fixed; left: 5%;right: auto">
            <div style="padding:5%">
                <form action="search" method="POST">
                    <table class="table-bordered">
                        <tbody>
                            <tr>
                                Location:
                            </tr>
                            <tr>
                        <select type="text" class="form-control" name="locationChoice">
                            <option value="All">
                                Choose location
                            </option>
                            <c:forEach items="${sessionScope.countries}" var="country">
                                <optgroup label="${country.name}">
                                    <c:forEach items="${sessionScope.cities}" var="city">
                                        <c:if test="${country.id eq city.countryID}">
                                            <option value="${city.name}">
                                                ${city.name}
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </optgroup>
                            </c:forEach>
                        </select>
                        </tr>
                        <tr>
                            Check in:
                        </tr>
                        <tr>
                        <input type="date" class="form-control" placeholder="Check in" name="checkIn" value="${requestScope.checkInDate}">
                        </tr>
                        <tr>
                            Check out:
                        </tr>
                        <tr>
                        <input type="date" class="form-control" placeholder="Check out" name="checkOut" value="${requestScope.checkOutDate}">
                        </tr>
                        <tr>
                            Type of room:
                        </tr>
                        <tr>
                        <select type="text" class="form-control" name="roomChoice">
                            <option value="All">
                                Choose room
                            </option>
                            <c:forEach items="${sessionScope.roomTypes}" var="roomType">
                                <option value="${roomType.name}">
                                    ${roomType.name}
                                </option>
                            </c:forEach>
                        </select>
                        </tr>
                        <tr>
                        <input type="submit" value="Search" class="btn btn-dark">
                        </tr>
                        </tbody>   
                    </table>
                </form>
            </div>
        </div>
        <br>
        <h3 class="text-center"> Available rooms after search</h3>
        <div class="container">
            <form action="addRoomToCart" method="post">
                <table class="table-responsive table-bordered table-striped">
                    <c:set var="results" value="${requestScope.results}"/>
                    <c:forEach items="${results}" var="result" varStatus="counter">
                        <c:forEach items="${sessionScope.rooms}" var="room">
                            <c:if test="${result.key eq room.id}">
                                <tbody>
                                    <tr>
                                        <td>
                                            <img src="images/${room.photo}" width="200px" height="200px">
                                        <td>
                                        <td>
                                            <h4 class="card-title">
                                                <a href="#">${room.name}</a>
                                            </h4>
                                            <p class="card-text">${room.description}</p>
                                            <p><strong>Room type:</strong>
                                                <c:forEach items="${sessionScope.roomTypes}" var="roomType">
                                                    <c:if test="${room.roomTypeID eq roomType.id}">
                                                        ${roomType.name}
                                                    </c:if>
                                                </c:forEach>
                                            </p>
                                            <p><strong>Price:</strong>
                                                <c:set var = "balance" value = "${room.price}" />
                                                <fmt:setLocale value = "vi_VN"/>
                                                <fmt:formatNumber value = "${balance}" type = "currency"/>/night
                                                <input type="hidden" name="price${room.id}" value="${room.price}">
                                            </p>
                                            <p><strong>Available:</strong>${result.value}
                                        </td>
                                        <td>
                                            <p><label for="quantity${room.id}">Room quantity:</label></p>
                                            <input id="quantity${room.id}" name="quantity${room.id}" type="number" value="1" min="1" max="${result.value}">
                                        </td>
                                        <td>
                                            <p><label for="bed${room.id}">Extra bed:</label></p>
                                            <select id="bed${room.id}" name="bed${room.id}" type="text" class="form-control" name="extraBed">
                                                <c:forEach items="${sessionScope.extraBeds}" var="extraBed">
                                                    <option value="${extraBed.id}">
                                                        ${extraBed.noOfBed} - <fmt:setLocale value = "vi_VN"/>
                                                        <fmt:formatNumber value = "${extraBed.extraPrice}" type = "currency"/>
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td>
                                            <input type="checkbox" name="items" id="check${room.id}" value="${room.id}">
                                            <label for="check${room.id}">Select room</label>
                                        </td>
                                        <td>
                                            <input type="button" class="btn btn-primary" value="View Feedback" data-toggle="collapse" data-target="#demo${counter.count}" class="accordion-toggle">
                                        </td>
                                    </tr>
                                    <tr class="p">
                                        <td colspan="8" class="hiddenRow">
                                            <div class="accordian-body collapse p-3" id="demo${counter.count}">
                                                <table class="table table-hover">
                                                    <strong>User Feedback</strong>
                                                    <c:forEach var="feedback" items="${sessionScope.feedbacks}">
                                                        <c:if test="${feedback.roomID eq room.id}">

                                                            <p><strong>${feedback.email}</strong>: ${feedback.feedback}-${feedback.star}&#9733;</p>

                                                        </c:if>
                                                    </c:forEach>
                                                </table>
                                            </div> 
                                        </td> 
                                    </tr>
                                    </tr>
                                </tbody>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </table>
                <input type="hidden" name="checkInDate" value="${requestScope.checkInDate}">
                <input type="hidden" name="checkOutDate" value="${requestScope.checkOutDate}">
                <input class="btn btn-dark" type="submit" value="Book now">
            </form>
            <br><br>
        </div>
        <footer class="fixed-bottom py-2 bg-dark">
            <div class="container">
                <p class="m-0 text-center text-white">Copyright &copy; Hotels Booking 2020</p>
            </div>
        </footer>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
