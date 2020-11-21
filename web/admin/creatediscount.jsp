<%-- 
    Document   : creatediscount
    Created on : Nov 2, 2020, 9:13:06 AM
    Author     : DELL
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Hotel">
        <meta name="author" content="Anh">
        <title>Hotel Booking-Create coupon</title>
        <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/shop-homepage.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">Yellow Moon Shop</a>
                <c:if test="${not empty sessionScope.USER}">
                    Welcome ${sessionScope.USER.userName}
                </c:if>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/index.jsp">Home
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/creatediscount.jsp">Create discount</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../logOut">Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="container" style="padding-top: 10%; padding-bottom: 35%">
                <div class="row d-flex justify-content-center">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h3>Create new coupon</h3>
                                <c:if test="${not empty sessionScope.MSG}">
                                    <p style="color: green">${sessionScope.MSG}</p>
                                </c:if>
                            </div>
                            <div class="card-body">
                                <form action="../generateCode">
                                    <div class="input-group form-group">
                                        <input type="submit" class="btn btn-danger" value="Generate code">
                                    </div>
                                </form>
                                <form action="../coupon" method="POST">
                                    <div class="input-group form-group">
                                        <input type="text" class="form-control" placeholder="Coupon code" name="code" value="${sessionScope.code}" maxlength="8" required>
                                    </div>
                                    <div class="input-group form-group">
                                        <input type="text" class="form-control" placeholder="Coupon name" name="name" required>
                                    </div>
                                    <div class="input-group form-group">
                                        <input type="number" class="form-control" placeholder="Discount percent" name="percent" min="0" max="100" required>
                                    </div>
                                    <div class="input-group form-group">
                                        <input type="date" class="form-control" name="expireDate" min="${sessionScope.TODAY}" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="submit" value="Create" class="btn btn-dark">
                                    </div>
                                </form>
                            </div>
                            <div class="card-footer">
                                <input type="button" class="btn btn-primary" value="Coupon List" data-toggle="collapse" data-target="#demo${counter.count}" class="accordion-toggle">
                            </div>
                            <tr class="p">
                            <div class="accordian-body collapse p-3" id="demo${counter.count}">
                                <table class="table table-hover">
                                    <strong>Coupon List</strong>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <td>Code</td>
                                                <td>Name</td>
                                                <td>Discount(%)</td>
                                                <td>Expire date</td>
                                                <td>Create date</td>
                                                <td>Status</td>
                                            </tr>
                                        </thead>
                                        <c:forEach var="coupon" items="${sessionScope.coupons}">
                                            <tbody>
                                                <tr>
                                                    <td>${coupon.id}</td>
                                                    <td>${coupon.name}</td>
                                                    <td>${coupon.discount}</td>
                                                    <td>${coupon.expireDate}</td>
                                                    <td>${coupon.createDate}</td>
                                                    <td>${coupon.status}</td>
                                                </tr>
                                            </tbody>
                                        </c:forEach>
                                    </table>
                                </table>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="fixed-bottom py-5 bg-dark">
            <div class="container">
                <p class="m-0 text-center text-white">Copyright &copy; Yellow Moon Shop 2020</p>
            </div>
        </footer>
        <script src="../vendor/jquery/jquery.min.js"></script>
        <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
