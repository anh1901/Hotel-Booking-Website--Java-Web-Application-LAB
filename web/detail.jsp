<%-- 
    Document   : detail
    Created on : Oct 24, 2020, 4:13:58 PM
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
        <title>Hotels Booking - Hotel details</title>
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
        <div class="container">
            <div class="card">
                <div class="container-fliud">
                    <div class="wrapper row">
                        <div class="preview col-md-6">
                            <div class="img-thumbnail">
                                <div class="tab-pane active"><img src="images/${param.photo}" height="500px" width="480px"/></div>
                            </div>
                        </div>
                        <div class="details col-md-6">
                            <h3 class="text-success">${param.name}</h3>
                            <p class="text-warning">${param.averageRating} &#9733;</p>
                            <p>Hotel ID: ${param.id}</p>
                            <p class="product-description">${param.description}</p>
                            <p class="vote"><strong>${param.averageRating*10}%</strong> of customers enjoyed this hotel! <strong>(? votes)</strong></p>
                            <p><strong>Location: </strong>
                                <c:forEach items="${sessionScope.cities}" var="city">
                                    <c:if test="${city.id eq param.cityID}">
                                        ${city.name},
                                        <c:forEach items="${sessionScope.countries}" var="country">
                                            <c:if test="${country.id eq city.countryID}">
                                                ${country.name}
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </p>
                            <p><strong>Category:</strong>
                                <c:forEach items="${sessionScope.categories}" var="category">
                                    <c:if test="${category.id eq param.categoryID}">
                                        ${category.name}
                                    </c:if>
                                </c:forEach>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <h3 class="text-center"> Available rooms</h3>
        <div class="container">
            <form action="addRoomToCart" method="post">
                <table class="table-responsive table-bordered table-striped">
                    <c:forEach items="${sessionScope.rooms}" var="room" varStatus="counter">
                        <c:if test="${room.hotelID eq param.id}">
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
                                        <p><strong>Available:</strong>${room.availableRoom}
                                    </td>
                                    <td>
                                        <p><label for="quantity${room.id}">Room quantity:</label></p>
                                        <input id="quantity${room.id}" name="quantity${room.id}" type="number" value="1" min="1" max="${room.availableRoom}">
                                    </td>
                                    <td>
                                        <p><label for="bed${room.id}">Extra bed:</label></p>
                                        <select id="bed${room.id}" name="bed${room.id}" type="text" class="form-control" name="extraBed">
                                            <c:forEach items="${sessionScope.extraBeds}" var="extraBed">
                                                <option value="${extraBed.id}">
                                                    ${extraBed.noOfBed} - 
                                                    <fmt:setLocale value = "vi_VN"/>
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
                                                <strong>User Feedback:</strong>
                                                <c:forEach var="feedback" items="${sessionScope.feedbacks}">
                                                    <c:if test="${feedback.roomID eq room.id}">
                                                        <p><strong>${feedback.email}</strong>: ${feedback.feedback}-${feedback.star}&#9733;</p>
                                                    </c:if>
                                                </c:forEach>
                                            </table>
                                        </div> 
                                    </td> 
                                </tr>
                            </tbody>
                        </c:if>
                    </c:forEach>
                </table>
                <a href="#myModal0" class="justify-content-center btn btn-danger" data-toggle="modal">Add selected room</a>
                <div id="myModal0" class="modal fade">
                    <div class="modal-dialog modal-confirm">
                        <div class="modal-content">
                            <div class="modal-header flex-column">
                                <h4 class="modal-title w-100">We need some of information?</h4>	
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">
                                <table>
                                    <tbody>
                                        <tr>
                                            <td>Check in date:</td>  <td><input type="date" name="checkInDate" min="${sessionScope.TODAY}"></td>
                                        </tr>
                                        <tr>
                                            <td>Check out date: </td><td><input type="date" name="checkOutDate" min="${sessionScope.TODAY}"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>   
                                <input type="submit" class="btn btn-danger" value="Next"/>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <a class="btn btn-dark" href="homePage">Find other</a>
        </div>

        <br><br>
        <footer class="fixed-bottom py-2 bg-dark">
            <div class="container">
                <p class="m-0 text-center text-white">Copyright &copy; Hotels Booking 2020</p>
            </div>
        </footer>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
