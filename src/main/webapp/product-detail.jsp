<%@ page import="java.sql.Connection" %> <%@ page import="bookstore.DB.DBConnect" %> <%@ page import="bookstore.DAO.BookDAOIplm" %> <%@ page import="bookstore.entity.Book" %> <%@ page import="java.net.URLDecoder" %> <%@ page
        import="bookstore.DAO.BookDAO" %> <%@ page import="java.util.*" %>
<%@ page import="bookstore.DAO.WishlistDAOIplm" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Store</title>
    <link rel="icon" type="image/png" href="all_component/img/logo%20no%20title.png">

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
    String bookIDParam = request.getParameter("bookID");
    Book currentBook = bookDAO.getBookByID(Integer.parseInt(bookIDParam));
    List<Book> relatedBooks = new ArrayList<>();

    if(bookIDParam != null){
        relatedBooks = bookDAO.getBookByCategory(currentBook.getCategory());
    }
%>

<div class="container border-bottom">
    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
        <ol class="breadcrumb text-title">
            <li class="breadcrumb-item"> <a href="index.jsp"> <i class="fa fa-home"></i> Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Book Detail</li>
            <%if(bookIDParam != null) {%>
            <li class="breadcrumb-item active" aria-current="page"><%=currentBook.getName()%></li>
            <%}%>
        </ol>
    </nav>
</div>

<!-- content -->
<section class="py-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-4">
                <img style="max-width: 100%; max-height: 100vh; margin: auto;" class="fit pe-5 mb-5" src="book/<%=currentBook.getFileName()%>" />
            </div>
            <main class="col-lg-8">
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

                    <div class="my-2">
                        <a href="#" class="btn-add-to-cart">
                            <i class="fa-brands fa-opencart mx-2"></i>ADD TO CART
                        </a>
                    </div>

                    <%if(user != null){%>
                        <%if (wishlistDAO.getBookIDs(user.getId()).contains(Integer.parseInt(bookIDParam))) {%>
                            <div>
                                <a href="#" class="btn-remove-wishlist" id="btn-remove-wishlist">
                                    <i class="fa-regular fa-heart mx-2"></i> REMOVE FROM WISHLIST
                                </a>
                            </div>
                            <div>
                                <a href="#" class="btn-add-wishlist hidden" id="btn-add-wishlist" >
                                    <i class="fa-regular fa-heart mx-2"></i> ADD TO WISHLIST
                                </a>
                            </div>
                        <%} else {%>
                            <div>
                                <a href="#" class="btn-add-wishlist" id="btn-add-wishlist" >
                                    <i class="fa-regular fa-heart mx-2"></i> ADD TO WISHLIST
                                </a>
                            </div>

                            <div>
                                <a href="#" class="btn-remove-wishlist hidden" id="btn-remove-wishlist">
                                    <i class="fa-regular fa-heart mx-2"></i> REMOVE FROM WISHLIST
                                </a>
                            </div>
                        <%}%>

                    <%} else {%>
                        <div>
                            <a href="#" class="btn-add-wishlist" id="btn-add-wishlist" >
                                <i class="fa-regular fa-heart mx-2"></i> ADD TO WISHLIST
                            </a>
                        </div>
                    <%}%>

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
                            <th class="p-2" style="background-color: #EEEEEE">Label</th>
                            <td class="p-2"><%=currentBook.getCategory()%></td>
                        </tr>
                        <tr>
                            <th class="p-2" style="background-color: #EEEEEE">Author</th>
                            <td class="p-2"><%=currentBook.getAuthor()%></td>
                        </tr>
                        <tr>
                            <th class="p-2" style="background-color: #EEEEEE">Language</th>
                            <td class="p-2">Japanese</td>
                        </tr>
                        <tr>
                            <th class="p-2" style="background-color: #EEEEEE">Page</th>
                            <td class="p-2"><%=currentBook.getPage()%> Pages</td>
                        </tr>
                        <tr>
                            <th class="p-2" style="background-color: #EEEEEE">Deepth</th>
                            <td class="p-2"><%=currentBook.getDeepth()%> cm / <%=String.format("%.2f", currentBook.getDeepth() / 2.535)%> inch</td>
                        </tr>
                        <tr>
                            <th class="p-2" style="background-color: #EEEEEE">Height</th>
                            <td class="p-2"><%=currentBook.getHeight()%> cm / <%=String.format("%.2f", currentBook.getHeight() / 2.535)%> inch</td>
                        </tr>
                        <tr>
                            <th class="p-2" style="background-color: #EEEEEE">Width</th>
                            <td class="p-2"><%=currentBook.getWidth()%> cm / <%=String.format("%.2f", currentBook.getWidth() / 2.535)%> inch</td>
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

<!-- Toast thông báo đăng nhập để thêm vào wishlist-->
<div aria-live="polite" aria-atomic="true" class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="loginToAddWishlistToast" class="toast" role="alert" style="background-color: #EF497D">
        <div class="toast-body">
            <div class="d-flex gap-4" style="color: white">
                <span><i class="fa-regular fa-user fs-6"></i></span>
                <div class="d-flex flex-grow-1 align-items-center">
                    <span class="fw-semibold">Please login to save your wishlist across devices.</span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Toast thông báo thêm vào wishlist thành công-->
<div aria-live="polite" aria-atomic="true" class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="addToWishlistSuccessToast" class="toast" role="alert" style="background-color: #EF497D">
        <div class="toast-body">
            <div class="d-flex gap-4" style="color: white">
                <span><i class="fa-regular fa-heart mx-2"></i></span>
                <div class="d-flex flex-grow-1 align-items-center">
                    <span class="fw-semibold">Add to Wishlist success</span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Toast thông báo xóa khỏi wishlist thành công-->
<div aria-live="polite" aria-atomic="true" class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="removeFromWishlistSuccessToast" class="toast" role="alert" style="background-color: #EF497D">
        <div class="toast-body">
            <div class="d-flex gap-4" style="color: white">
                <span><i class="fa-regular fa-heart mx-2"></i></span>
                <div class="d-flex flex-grow-1 align-items-center">
                    <span class="fw-semibold">Remove from Wishlist success</span>
                </div>
            </div>
        </div>
    </div>
</div>

<%--Xử lý tăng giảm quantity--%>
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

<%--Xử lý thêm / xóa wishlist--%>
<script>
    // Lấy tham chiếu đến toast
    var loginToAddWishlistToast = document.getElementById('loginToAddWishlistToast');
    var addToWishlistSuccessToast = document.getElementById('addToWishlistSuccessToast');
    var removeFromWishlistSuccessToast = document.getElementById('removeFromWishlistSuccessToast');
    var wishlistQtySpan = document.getElementById('wishlistQty');

    // Thêm sự kiện click cho nút "Add to Wishlist"
    // Lấy tham chiếu đến các phần tử DOM
    var btnAddWishlist = document.getElementById('btn-add-wishlist');
    var btnRemoveWishlist = document.getElementById('btn-remove-wishlist');

    // Thêm sự kiện click cho nút "Add to Wishlist"
    btnAddWishlist.addEventListener('click', function(event) {
        event.preventDefault(); // Ngăn chặn hành vi mặc định của liên kết

        // Kiểm tra trạng thái đăng nhập
        <% if (user == null) { %>
        // Hiển thị toast nếu chưa đăng nhập
        var toast = new bootstrap.Toast(loginToAddWishlistToast);
        toast.show();
        <% } else { %>
        // Gọi Servlet để thêm sản phẩm vào Wishlist
        fetch('AddToWishlistServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'bookId=<%= currentBook.getId() %>'
        })
            .then(response => {
                if (response.ok) {
                    // Lấy số lượng hiện tại từ phản hồi của servlet
                    response.text().then(function(data) {
                        // Cập nhật số lượng hiển thị trong giao diện người dùng
                        updateWishlistQty(data);
                        // Hiển thị toast thông báo thành công
                        var toast = new bootstrap.Toast(addToWishlistSuccessToast);
                        toast.show();
                        // Ẩn nút "Add to Wishlist" và hiển thị nút "Remove from Wishlist"
                        btnAddWishlist.classList.add('hidden');
                        btnRemoveWishlist.classList.remove('hidden');
                    });
                } else {
                    console.error('Failed to add book to wishlist');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        <% } %>
    });

    // Thêm sự kiện click cho nút "Remove from Wishlist"
    btnRemoveWishlist.addEventListener('click', function(event) {
        event.preventDefault(); // Ngăn chặn hành vi mặc định của liên kết

        // Kiểm tra trạng thái đăng nhập
        <% if (user != null) { %>
        // Gọi Servlet để thêm sản phẩm vào Wishlist
        fetch('RemoveFromWishlistServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'bookId=<%= currentBook.getId() %>'
        })
            .then(response => {
                if (response.ok) {
                    // Lấy số lượng hiện tại từ phản hồi của servlet
                    response.text().then(function(data) {
                        // Cập nhật số lượng hiển thị trong giao diện người dùng
                        updateWishlistQty(data);
                        // Hiển thị toast thông báo thành công
                        var toast = new bootstrap.Toast(removeFromWishlistSuccessToast);
                        toast.show();
                        btnAddWishlist.classList.remove('hidden');
                        btnRemoveWishlist.classList.add('hidden');
                    });
                } else {
                    console.error('Failed to add book to wishlist');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        <% } %>
    });

    // Hàm cập nhật số lượng sản phẩm trong Wishlist và hiển thị/ẩn span
    function updateWishlistQty(qty) {
        wishlistQtySpan.innerText = qty;
        if (qty === '0') {
            wishlistQtySpan.style.display = 'none';
        } else {
            wishlistQtySpan.style.display = 'inline';
        }
    }
</script>
</body>
</html>
