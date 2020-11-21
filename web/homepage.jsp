<%-- 
    Document   : homepage
    Created on : Oct 23, 2020, 7:39:48 AM
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
        <title>Hotels Booking - Home Page</title>
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
        </nav><br><br>
        <%--Search--%>
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
                        <input type="date" class="form-control" placeholder="Check in" name="checkIn" value="${param.checkIn}">
                        </tr>
                        <tr>
                            Check out:
                        </tr>
                        <tr>
                        <input type="date" class="form-control" placeholder="Check out" name="checkOut" value="${param.checkOut}">
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
        <div class="container">
            <div class="row">
                <div class="col-3">
                    <div class="list-group">
                        <a href="homePage" class="list-group-item">All hotel categories</a>
                        <c:if test="${! empty sessionScope.categories}">
                            <c:forEach items="${sessionScope.categories}" var="category">
                                <a href="homePage?category=${category.id}" class="list-group-item">${category.name}</a>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
                <%--display for fun--%>
                <div class="col-9">
                    <div id="carouselExampleFade" class="carousel slide carousel-fade row justify-content-md-center" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Slides/img%20(15).jpg"
                                     alt="First slide">
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Slides/img%20(16).jpg"
                                     alt="Second slide">
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Slides/img%20(17).jpg"
                                     alt="Third slide">
                            </div>
                            <a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>>
        <br>
        <div class="container">
            <div class="row">
                <c:if test="${empty sessionScope.hotels}">
                    <h1 style="color: red">No hotels found.</h1> 
                </c:if>
                <c:if test="${not empty sessionScope.hotels}">
                    <c:forEach items="${sessionScope.hotels}" var="hotel">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="card h-100">
                                <a href="detail.jsp?id=${hotel.id}&name=${hotel.name}&description=${hotel.description}&cityID=${hotel.cityID}&categoryID=${hotel.categoryID}&status=${hotel.status}&photo=${hotel.photo}&averageRating=${hotel.averageRating}"><img class="card-img-top" src="images/${hotel.photo}" alt=""></a>
                                <div class="card-body">
                                    <h4 class="card-title">
                                        <a href="detail.jsp?id=${hotel.id}&name=${hotel.name}&description=${hotel.description}&cityID=${hotel.cityID}&categoryID=${hotel.categoryID}&status=${hotel.status}&photo=${hotel.photo}&averageRating=${hotel.averageRating}">${hotel.name}</a>
                                    </h4>
                                    <p class="card-text">${hotel.description}</p>
                                </div>
                                <div class="card-footer">
                                    <small class="text-muted">${hotel.averageRating} &#9733;</small>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
            <ul class="pagination">
                <c:if test="${not empty query}">
                    <c:set var="stringQuery" value="&category=${requestScope.query}"/>
                </c:if>
                <c:if test="${requestScope.currentPage != 1 && requestScope.products.size() ==0}">
                    <li><a href="homePage?page=${requestScope.currentPage-1}${requestScope.stringQuery}"><<</li>
                    </c:if>
                    <c:forEach begin="1" end="${requestScope.numberOfPages}" var="i">
                        <c:choose>
                            <c:when test="${requestScope.currentPage == i}">
                            <li class="active"><a href="">${i}</a></li>
                            </c:when>
                            <c:otherwise>
                            <li><a href="homePage?page=${i}${stringQuery}">${i}</a></li> 
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>    
                    <c:if test="${requestScope.currentPage lt requestScope.numberOfPages}">
                    <li><a href="homePage?page=${requestScope.currentPage+1}${requestScope.stringQuery}">>></li>
                    </c:if>
            </ul>
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