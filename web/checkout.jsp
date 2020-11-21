<%-- 
    Document   : checkout
    Created on : Oct 26, 2020, 10:59:14 AM
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
        <meta name="description" content="Hotel Booking">
        <meta name="author" content="Anh">
        <title>Hotel Booking-Check out</title>
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/shop-homepage.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="homePage">Hotel Booking</a>
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
                        <li class="nav-item active">
                            <a class="nav-link" href="cartAccess">Your cart</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="track">Track your reservations</a>
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
        </nav>
        <form action="checkOut" method="POST">
            <div class="container" style="padding-top: 10%; padding-bottom: 35%">
                <div class="row d-flex justify-content-center">
                    <div class="col-md-3">
                        <h1>Order</h1>
                        <table class="table table-hover">
                            <tbody>
                                <tr>
                                    <td>
                                        Name:
                                    </td>
                                    <td>
                                        <input type="text" name="customerName" value="${sessionScope.USER.userName}" readonly="true">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Phone:
                                    </td>
                                    <td>
                                        <input type="text" name="customerPhone" value="${sessionScope.USER.phone}" readonly="true">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Location:
                                    </td>
                                    <td>
                                        <input type="text" name="customerAddress" value="${sessionScope.USER.address}" readonly="true">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Email:
                                    </td>
                                    <td>
                                        <input type="text" name="customerEmail" value="${sessionScope.USER.email}" readonly="true">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Discount code:
                                    </td>
                                    <td>
                                        <input type="text" name="code" value="${requestScope.discountCode}" readonly="true" disabled="disabled">
                                        <input type="hidden" name="discountCode" value="${requestScope.discountCode}">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <c:if test="${not empty requestScope.ERRORCODE}">
                            <p style="color: red">${requestScope.ERRORCODE}</p>
                        </c:if>
                        <c:if test="${not empty requestScope.SUCCESSMSG}">
                            <p style="color: green">${requestScope.SUCCESSMSG}</p>
                        </c:if>
                    </div>
                    <div class="col-md-9">
                        <h1>Booking cart</h1>
                        
                        <div class="col-md-12">
                            <c:set var="cart" value="${sessionScope.CART}"/>
                            <c:if test="${empty cart.items}">
                                <h1 style="color: red">No products yet. Shopping for more!!</h1>
                            </c:if>
                            <c:if test="${not empty cart.items}">
                                <table class="table table-hover" style="border-collapse:collapse;">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Room Name</th>
                                            <th>Check in</th>
                                            <th>Check out</th>
                                            <th>No.Days</th>
                                            <th>Extra bed</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${cart.items}" varStatus="counter">
                                            <c:set var="bookeds" value="${sessionScope.BOOKEDS}"/>
                                            <c:forEach var="booked" items="${bookeds}">
                                                <c:if test="${item.value.roomID eq booked.id}">
                                                    <tr colspan="8" data-toggle="collapse" data-target="#demo${counter.count}" class="accordion-toggle">
                                                        <td>
                                                            ${counter.count}
                                                        </td>
                                                        <td>
                                                            ${booked.name}
                                                        </td>
                                                        <td>${item.value.startDate}</td>
                                                        <td>${item.value.endDate}</td>
                                                        <td>${item.value.numDays}</td>
                                                        <td>${item.value.extraBedID}</td>
                                                        <td>
                                                            ${item.value.quantity}
                                                        </td>
                                                        <td>
                                                            <c:set var = "balance" value = "${item.value.prices}" />
                                                            <fmt:setLocale value = "vi_VN"/>
                                                            <fmt:formatNumber value = "${balance}" type = "currency"/>
                                                        </td>

                                                    </tr>
                                                    <tr class="p">
                                                        <td colspan="8" class="hiddenRow">
                                                            <div class="accordian-body collapse p-3" id="demo${counter.count}">
                                                                <p>Room type : <span>
                                                                        <c:forEach items="${sessionScope.roomTypes}" var="roomType">
                                                                            <c:if test="${booked.roomTypeID eq roomType.id}">
                                                                                ${roomType.name}
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </span></p>
                                                                <p>Price per night : <span><fmt:formatNumber value = "${booked.price}" type = "currency"/>/night</span> </p>
                                                                <p>Description : <span>${booked.description}</span> </p>
                                                                <p>Price= <span>(Unit price + Extra bed number*Extra price)*Number of rooms* nights</span></p>
                                                            </div> 
                                                        </td> 
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                        <tr>
                                            <td>
                                                Total:
                                            </td>
                                            <td>
                                                (Discount
                                            </td>
                                            <td>
                                                ${requestScope.discount}%)
                                            </td>
                                            <td></td><td></td><td></td>
                                            <td>
                                    <strike>
                                        <fmt:setLocale value = "vi_VN"/>
                                        <fmt:formatNumber value = "${sessionScope.CART.totalMoney}" type = "currency"/>
                                    </strike>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value = "${sessionScope.CART.totalMoney*(100-requestScope.discount)/100}" type = "currency"/>
                                        <input type="hidden" name="subTotal" value="${sessionScope.CART.totalMoney*(100-requestScope.discount)/100}">
                                    </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </c:if>
                        </div>

                    </div>
                    <c:if test="${!requestScope.SUCCESS}">
                        <a href="#myModal0" class="btn trigger-btn" data-toggle="modal">Check out now!</a>
                    </c:if>
                    <c:if test="${requestScope.SUCCESS}">
                        <input type="Submit" value="Check out now!">
                    </c:if>
                </div>
        </form>
        <form action="checkCode" method="POST">
            <div id="myModal0" class="modal fade">
                <div class="modal-dialog modal-confirm">
                    <div class="modal-content">
                        <div class="modal-header flex-column">
                            <h4 class="modal-title w-100">Input the confirmation code that we send to your email <a href="http://www.gmail.com" target="_blank">${sessionScope.USER.email}</a></h4>	
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="confirmCode" value="${requestScope.confirmCode}">
                            Confirm code: <input type="text" name="inputCode" required><input class="btn btn-dark" type="submit" value="Check code">
                            <p>After input, you will be redirected.</p>
                        </div>
                        <div class="modal-footer justify-content-center">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <footer class="fixed-bottom py-2 bg-dark">
            <div class="container">
                <p class="m-0 text-center text-white">Copyright &copy; Hotel Booking 2020</p>
            </div>
        </footer>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
