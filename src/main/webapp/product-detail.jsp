<%@ page import="java.sql.Connection" %> <%@ page import="bookstore.DB.DBConnect" %> <%@ page import="bookstore.DAO.BookDAOIplm" %> <%@ page import="bookstore.entity.Book" %> <%@ page import="java.net.URLDecoder" %> <%@ page
        import="bookstore.DAO.BookDAO" %> <%@ page import="java.util.*" %> <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

<%
    BookDAOIplm bookDAO = new BookDAOIplm(DBConnect.getConnection());
    String bookiIDParam = request.getParameter("bookID");
    Book currentBook = bookDAO.getBookByID(bookiIDParam);
    List<Book> relatedBooks = new ArrayList<>();

    if(bookiIDParam != null){
        relatedBooks = bookDAO.getBookByCategory(currentBook.getCategory());
    }
%>

<div class="container border-bottom">
    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
        <ol class="breadcrumb text-title">
            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Book Detail</li>
            <%if(bookiIDParam != null) {%>
            <li class="breadcrumb-item active" aria-current="page"><%=currentBook.getName()%></li>
            <%}%>
        </ol>
    </nav>
</div>

<!-- content -->
<section class="py-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <img style="max-width: 80%; max-height: 80vh; margin: auto;" class="fit" src="book/<%=currentBook.getFileName()%>" />
            </div>
            <main class="col-lg-6" style="padding-left: 0">
                <div>
                    <h4 class="title text-dark fw-bold">
                        <%=currentBook.getName()%>
                    </h4>
                    <div class="d-flex flex-row my-3">
                        <div class="text-warning mb-1 me-2">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                            <span class="ms-1">
                                        4.5
                                    </span>
                        </div>
                        <span class="text-muted"><i class="fas fa-shopping-basket fa-sm mx-1"></i><%=currentBook.getSold()%> orders</span>

                    </div>

                    <p>by <a href=""><%=currentBook.getAuthor()%></a></p>

                    <div class="mb-3">
                        <p class="fw-bold fs-4">$<%= currentBook.getPrice() %></p>
                    </div>

                    <span class="text-success">In stock.</span> Usually ships in 3 to 5 days.
                    <p>Shipping Weight: 180 grams</p>
                    <p>Worldwide Shipping! Shipping Detail</p>

                    <hr />

                    <div class="row mb-4">
                        <!-- col.// -->
                        <div class="col-md-4 col-6 mb-3">
                            <label class="mb-2 d-block fw-bold">Quantity</label>
                            <div class="input-group mb-3" style="width: 150px;">
                                <button class="btn btn-white border border-secondary" type="button" id="decreaseButton" data-mdb-ripple-color="dark">
                                    <i class="fas fa-minus"></i>
                                </button>
                                <input type="text" id="quantityInput" class="form-control text-center border border-secondary" placeholder="1" aria-label="Example text with button addon" aria-describedby="button-addon1" />
                                <button class="btn btn-white border border-secondary" type="button" id="increaseButton" data-mdb-ripple-color="dark">
                                    <i class="fas fa-plus"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <%--                    <a href="#" class="btn shadow-0"> Buy now </a> <br>--%>
                    <div class="my-2">
                        <a href="#" class="btn-add-to-cart">
                            <i class="fa-solid fa-cart-plus mx-2" ></i>ADD TO CART
                        </a>
                    </div>

                    <div>
                        <a href="#" class="btn-wishlist">
                            <i class="fa-regular fa-heart mx-2"></i> ADD TO WISHLIST
                        </a>
                    </div>
                </div>

                <!-- Detail Information -->
                <div class="tab-pane fade show active my-4" id="ex1-pills-1" role="tabpanel" aria-labelledby="ex1-tab-1">
                    <div class="border-bottom py-3">
                        <p class="fw-bolder">
                            Japanese <%=currentBook.getCategory()%> written by <%=currentBook.getAuthor()%>
                        </p>
                    </div>

                    <table class="table border mt-3 mb-2">
                        <tr>
                            <th class="py-2" style="background-color: #EEEEEE">Label</th>
                            <td class="py-2"><%=currentBook.getCategory()%></td>
                        </tr>
                        <tr>
                            <th class="py-2" style="background-color: #EEEEEE">Author</th>
                            <td class="py-2"><%=currentBook.getAuthor()%></td>
                        </tr>
                        <tr>
                            <th class="py-2" style="background-color: #EEEEEE">Language</th>
                            <td class="py-2">Japanese</td>
                        </tr>
                        <tr>
                            <th class="py-2" style="background-color: #EEEEEE">Page</th>
                            <td class="py-2"><%=currentBook.getPage()%> Pages</td>
                        </tr>
                        <tr>
                            <th class="py-2" style="background-color: #EEEEEE">Deepth</th>
                            <td class="py-2"><%=currentBook.getDeepth()%> cm / <%=String.format("%.2f", currentBook.getDeepth() / 2.535)%> inch</td>
                        </tr>
                        <tr>
                            <th class="py-2" style="background-color: #EEEEEE">Height</th>
                            <td class="py-2"><%=currentBook.getHeight()%> cm / <%=String.format("%.2f", currentBook.getHeight() / 2.535)%> inch</td>
                        </tr>
                        <tr>
                            <th class="py-2" style="background-color: #EEEEEE">Width</th>
                            <td class="py-2"><%=currentBook.getWidth()%> cm / <%=String.format("%.2f", currentBook.getWidth() / 2.535)%> inch</td>
                        </tr>
                    </table>
                </div>
                <!-- Detail Information -->

                <!-- Social-->
                <a data-mdb-ripple-init class="btn btn-sm btn-primary" style="background-color: #3b5998;" href="https://www.facebook.com/" role="button"><i class="fab fa-facebook-f me-2"></i>Share</a>
                <a data-mdb-ripple-init class="btn btn-sm btn-primary" style="background-color: #55acee;" href="https://twitter.com/" role="button"><i class="fab fa-twitter me-2"></i>Tweet</a>
                <!-- Social-->
            </main>
        </div>
    </div>
</section>
<!-- content -->

<%--Related product--%>
<%@include file="all_component/related-product.jsp"%>
<%--Related product--%>

<!-- Footer -->
<%@include file="all_component/footer.jsp"%>
<!-- Footer -->

<script>
    // Lấy tham chiếu đến các phần tử DOM
    var decreaseButton = document.getElementById("decreaseButton");
    var increaseButton = document.getElementById("increaseButton");
    var quantityInput = document.getElementById("quantityInput");

    // Thêm sự kiện click cho nút giảm số lượng
    decreaseButton.addEventListener("click", function() {
        var currentValue = parseInt(quantityInput.value);
        if (!isNaN(currentValue) && currentValue > 0) {
            quantityInput.value = currentValue - 1;
        }
    });

    // Thêm sự kiện click cho nút tăng số lượng
    increaseButton.addEventListener("click", function() {
        var currentValue = parseInt(quantityInput.value);
        if (!isNaN(currentValue)) {
            quantityInput.value = currentValue + 1;
        } else {
            quantityInput.value = 1; // Nếu giá trị không hợp lệ, đặt giá trị mặc định là 1
        }
    });
</script>

</body>
</html>
