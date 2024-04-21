<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <%@include file="all_css.jsp"%>
</head>
<body>
<%--<%@include file="admin_components/navbar.jsp"%>--%>

<%@include file="head.jsp"%>

<div class="container border border-primary py-5 my-5">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <h1 class="text-center mb-4">Admin Dashboard</h1>
            <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4 g-4">
                <div class="col">
                    <div class="card h-100">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <h5 class="card-title">Add Book</h5>
                            <p class="card-text">Add new books to the bookstore.</p>
                            <a href="add_book.jsp" class="btn btn-primary">Go</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <h5 class="card-title">Remove Book</h5>
                            <p class="card-text">Remove existing books from the bookstore.</p>
                            <a href="remove_book.jsp" class="btn btn-danger">Go</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <h5 class="card-title">View All Books</h5>
                            <p class="card-text">View and manage all books in the bookstore.</p>
                            <a href="all_books.jsp" class="btn btn-success">Go</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <h5 class="card-title">View All Orders</h5>
                            <p class="card-text">View and manage all buyer orders.</p>
                            <a href="view_orders.jsp" class="btn btn-info">Go</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--<%@include file="admin_components/footer.jsp"%>--%>
</body>
</html>