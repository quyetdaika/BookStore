<%@ page import="java.sql.Connection" %>
<%@ page import="bookstore.DB.DBConnect" %>
<%@ page import="bookstore.DAO.BookDAOIplm" %>
<%@ page import="java.util.List" %>
<%@ page import="bookstore.entity.Book" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Store</title>
    <%@include file="all_component/all_css.jsp"%>
</head>

<body>

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

<%
    BookDAOIplm bookDAO = new BookDAOIplm(DBConnect.getConnection());
    List<Book> newReleaseBooks = bookDAO.getNewReleaseBooks();
    List<Book> saleBooks = bookDAO.getSaleBooks();
%>

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

</body>
</html>