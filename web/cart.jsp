<%-- 
    Document   : cart
    Created on : Oct 25, 2020, 4:15:29 PM
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
        <title>Hotel Booking-Your cart</title>
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
        <div class="container" style="padding-top: 10%; padding-bottom: 35%">
            <div class="row d-flex justify-content-center">
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
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cart.items}" varStatus="counter">
                                    <c:set var="bookeds" value="${sessionScope.BOOKEDS}"/>
                                    <c:forEach var="booked" items="${bookeds}">
                                        <c:if test="${item.value.roomID eq booked.id}">
                                            <tr colspan="9" data-toggle="collapse" data-target="#demo${counter.count}" class="accordion-toggle">
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
                                        <form action="changeQuantity" method="POST">
                                            <td>
                                                <c:set var="oldNumber" value="${item.value.quantity}"/>
                                                <input type="number" min="1" max="${booked.availableRoom}" value="${item.value.quantity}" name="number">
                                                <input type="hidden" name="oldNumber" value="${oldNumber}">
                                                <input type="hidden" name="price" value="${booked.price}">
                                                <input type="hidden" name="key" value="${item.key}">
                                                <input class="btn bg-light" type="submit" value="Apply">
                                            </td>
                                        </form>
                                        <td>
                                            <c:set var = "balance" value = "${item.value.prices}" />
                                            <fmt:setLocale value = "vi_VN"/>
                                            <fmt:formatNumber value = "${balance}" type = "currency"/>
                                        </td>
                                        <td>
                                            <form action="removeRoom" method="Post">
                                                <a href="#myModal${counter.count}" class="btn trigger-btn" data-toggle="modal">Remove</a>
                                                <%--cofirmation modal--%>
                                                <div id="myModal${counter.count}" class="modal fade">
                                                    <div class="modal-dialog modal-confirm">
                                                        <div class="modal-content">
                                                            <div class="modal-header flex-column">
                                                                <h4 class="modal-title w-100">Are you sure?</h4>	
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <p>Do you really want to remove this from your cart? This process cannot be undone.</p>
                                                            </div>
                                                            <div class="modal-footer justify-content-center">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                                <input type="hidden" name="id" value="${item.key}"/>
                                                                <input type="hidden" name="price" value="${balance}"/>
                                                                <input type="submit" class="btn btn-danger" value="Remove"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>   
                                            </form>
                                        </td>
                                        </tr>
                                        <tr class="p">
                                            <td colspan="9" class="hiddenRow">
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
                                <td></td><td></td><td></td><td></td><td></td><td></td>
                                <td>
                                    <c:set var = "balance" value = "${sessionScope.CART.totalMoney}" />
                                    <fmt:setLocale value = "vi_VN"/>
                                    <fmt:formatNumber value = "${balance}" type = "currency"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </c:if>
                </div>
                <c:if test="${sessionScope.USER.role eq 'USER'}">
                    <form action="booking" method="Post">
                        <a href="#myModal0" class="btn trigger-btn" data-toggle="modal">Book now!</a>
                        <div id="myModal0" class="modal fade">
                            <div class="modal-dialog modal-confirm">
                                <div class="modal-content">
                                    <div class="modal-header flex-column">
                                        <h4 class="modal-title w-100">Do you have a discount code?</h4>	
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        Discount code: <input type="text" name="discountCode">
                                        <p>If you don't have one, just click "Check out" without input.</p>
                                    </div>
                                    <div class="modal-footer justify-content-center">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                        <input type="hidden" name="subTotal" value="${balance}"/>
                                        <input type="submit" class="btn btn-danger" value="Check Out"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </c:if>
                <c:if test="${sessionScope.USER.role ne 'USER'}">
                    You are not logged in. <a href="login.jsp">Login now!</a> or <a href="signup.jsp">Sign up!</a>
                </c:if>
            </div>
        </div>
        <br><br>
        <footer class="fixed-bottom py-2 bg-dark">
            <div class="container">
                <p class="m-0 text-center text-white">Copyright &copy; Yellow Moon Shop 2020</p>
            </div>
        </footer>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
