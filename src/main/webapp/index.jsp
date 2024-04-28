<%@ page import="java.sql.Connection" %>
<%@ page import="bookstore.DB.DBConnect" %>
<%@ page import="bookstore.DAO.BookDAOIplm" %>
<%@ page import="java.util.List" %>
<%@ page import="bookstore.entity.Book" %>
<%@ page import="bookstore.entity.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Book Store</title>
    <link rel="icon" type="image/png" href="all_component/img/logo%20no%20title.png">
    <%@include file="all_component/all_css.jsp"%>
</head>

<body>

<%
    BookDAOIplm bookDAO = new BookDAOIplm(DBConnect.getConnection());
    List<Book> newReleaseBooks = bookDAO.getNewReleaseBooks();
    List<Book> saleBooks = bookDAO.getSaleBooks();
%>

<!--Main Navigation-->
<header>
    <!-- Header -->
    <%@include file="all_component/header.jsp"%>
    <!-- Header -->

    <!-- Navbar -->
    <%@include file="all_component/navbar.jsp"%>
    <!-- Navbar -->

</header>
<!--Main Navigation-->

<!-- Carousel -->
<%@include file="all_component/carousel.jsp"%>
<!-- Carousel -->

<!-- Products -->
<%@include file="all_component/new_release.jsp"%>
<%@include file="all_component/sale_books.jsp"%>
<%@include file="all_component/shop_for.jsp"%>
<!-- Products -->

<!-- Feature -->
<%@include file="all_component/feature.jsp"%>
<!-- Feature -->

<!-- Blog -->
<%@include file="all_component/blog.jsp"%>
<!-- Blog -->

<!-- Jumbotron -->
<%@include file="all_component/jumbotron.jsp"%>
<!-- Jumbotron -->

<!-- Footer -->
<%@include file="all_component/footer.jsp"%>
<!-- Footer -->

<!-- Toast thông báo -->
<div aria-live="polite" aria-atomic="true" class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="loginSuccessToast" class="toast text-bg-success" role="alert">
        <div class="toast-body">
            <div class="d-flex gap-4">
                <span><i class="fa-solid fa-circle-check fa-lg"></i></span>
                <div class="d-flex flex-grow-1 align-items-center">
                    <span class="fw-semibold">${successMsg}</span>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    <c:if test="${not empty successMsg}">
    var errorToast = document.getElementById('loginSuccessToast');
    var toast = new bootstrap.Toast(errorToast);
    toast.show();
    <c:remove var="successMsg" scope="session"></c:remove>
    </c:if>

</script>

</body>
</html>