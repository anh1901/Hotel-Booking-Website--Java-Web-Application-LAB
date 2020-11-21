<%-- 
    Document   : recover.jsp
    Created on : Oct 31, 2020, 10:29:04 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Hotel Booking">
        <meta name="author" content="Anh">
        <title>Hotels Booking-Find Account</title>
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/shop-homepage.css" rel="stylesheet">
        <script src="https://www.google.com/recaptcha/api.js?hl=vi"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="homePage">Hotels Booking</a>
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
                            <a class="nav-link" href="track">Track your Reservations</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="#">Login Now!</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="signup.jsp">Register Now!</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container" style="padding-top: 10%; padding-bottom: 35%">
            <div class="row d-flex justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h3>Find your account</h3>
                            <c:if test="${not empty requestScope.MSG}">
                                <p style="color: red">${requestScope.MSG}</p>
                            </c:if>
                        </div>
                        <form action="recoverPassword" method="POST">
                            <div class="card-body">
                                <div class="input-group form-group">
                                    <input type="email" class="form-control" placeholder="Email" name="recoverEmail" required>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a class="btn btn-danger" href="javascript:history.back()">Cancel</a>
                                <input class="btn btn-primary" type="submit" value="Find">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
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
