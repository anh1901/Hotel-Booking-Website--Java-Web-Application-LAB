<%-- 
    Document   : changepassword
    Created on : Oct 31, 2020, 12:08:15 PM
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
        <title>Hotels Booking-Change password</title>
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
                            <h3>Input your new password for ${param.recoverEmail}</h3>
                        </div>
                        <form action="changePassword" method="POST">
                            <div class="card-body">
                                <div class="input-group form-group">
                                    <input type="password" class="form-control" placeholder="New Password" id="password" name="password" required>
                                </div>
                                <div class="input-group form-group">
                                    <input type="password" class="form-control" placeholder="Confirm Password" id="confirm_password" name="password2" required>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a class="btn btn-danger" href="javascript:history.back()">Cancel</a>
                                <input type="hidden" name="secureCode" value="${param.secureCode}">
                                <input type="hidden" name="recoverCode" value="${sessionScope.recoverCode}">
                                <input type="hidden" name="recoverEmail" value="${param.recoverEmail}">
                                <input class="btn btn-primary" type="submit" value="Confirm">
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
        <script>
            var password = document.getElementById("password")
                    , confirm_password = document.getElementById("confirm_password");
            function validatePassword() {
                if (password.value !== confirm_password.value) {
                    confirm_password.setCustomValidity("Passwords don't match");
                } else {
                    confirm_password.setCustomValidity('');
                }
            }
            password.onchange = validatePassword;
            confirm_password.onkeyup = validatePassword;
        </script>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
