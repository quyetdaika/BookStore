<%@ page import="java.sql.Connection" %>
<%@ page import="bookstore.DB.DBConnect" %>
<%@ page import="bookstore.DAO.BookDAOIplm" %>
<%@ page import="bookstore.entity.Book" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="bookstore.DAO.BookDAO" %>
<%@ page import="bookstore.DAO.CartDAOIplm" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Cart</title>
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
    <header>
        <!--Main Navigation-->

            <%
    BookDAOIplm bookDAO = new BookDAOIplm(DBConnect.getConnection());
    List<Book> cartBooks = new ArrayList<>();
    double totalPrice = 0, tax = 0, grandTotal = 0;

    if(user != null){
        System.out.println("userid : " + user.getId());
        List<Integer> bookIDs = cartDAO.getBookIDs(user.getId());
        for(int bookID : bookIDs){
            cartBooks.add(bookDAO.getBookByID(bookID));
            totalPrice += bookDAO.getBookByID(bookID).getPrice() * cartDAO.getBookQtyInCart(user.getId(), bookID);
        }
        tax = totalPrice * 0.1;
        grandTotal = totalPrice + tax;
    }
    System.out.println("cartBooks : " + cartBooks.size());
%>

        <!-- cart + summary -->
        <section class="my-5" style="min-height: 50vh">
            <div class="container">
                <!-- title -->
                <div class="py-2 mb-4">
            <span class="d-flex align-items-center">
                <h3 class="fw-bold ms-2 mb-0"><i class="fa-brands fa-opencart mx-2"></i> My Shopping Cart</h3>
            </span>
                </div>
                <!-- title -->

                <%if(cartBooks.isEmpty()){%>
                <%if(user == null){%>
                <div class="py-5">
                     <span class="fs-4">
                         <i class="fa-solid fa-right-to-bracket"></i>
                         <span>Please login to see your cart across devices.</span>
                         <a href="login.jsp"><button class="btn btn-add-wishlist">LOGIN</button></a>
                     </span>
                </div>
                <%} else {%>
                <div id="noItemsDiv" class="py-5" style="display: <%= cartBooks.isEmpty() ? "block" : "none" %>;">
                    <span class="fs-4">
                        <i class="fa-solid fa-xmark"></i>
                        <span>There are no items in your cart</span>
                        <a href="collections.jsp"><button class="btn btn-add-wishlist">Explore our collections</button></a>
                    </span>
                </div>
                <%}%>
                <%} else {%>
                <div class="row" id="main-content">
                    <!-- cart -->
                    <div class="col-lg-9">
                        <div class="card border shadow-0 ">
                            <div class="m-4" id="product-list">
                                <%for(Book book : cartBooks){
                                    String coverSrc = "book/" + book.getFileName();
                                %>
                                <!-- product line -->
                                <div class="row gy-3 mb-4">
                                    <div class="col-lg-5">
                                        <div class="me-lg-5">
                                            <div class="d-flex">
                                                <img src="<%= URLDecoder.decode(coverSrc, "UTF-8") %>" class="border rounded me-3" style="width: 96px" />
                                                <div class="">
                                                    <a href="product-detail.jsp?bookID=<%=book.getId()%>" class="nav-link fw-bold"><%=book.getName()%></a>
                                                    <p class="py-2"><%=book.getAuthor()%></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-sm-6 col-6 d-flex flex-row flex-lg-column flex-xl-row text-nowrap">
                                        <div>
                                            <div class="input-group me-3" style="width: 140px;">
                                                <button class="btn btn-white border border-secondary" type="button" id="decrease-button" data-mdb-ripple-color="dark">
                                                    <i class="fas fa-minus"></i>
                                                </button>
                                                <input type="number" id="quantity-input" class="form-control text-center border border-secondary" value="<%=cartDAO.getBookQtyInCart(user.getId(), book.getId())%>" aria-describedby="button-addon1" />
                                                <button class="btn btn-white border border-secondary" type="button" id="increase-button" data-mdb-ripple-color="dark">
                                                    <i class="fas fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="">
                                            <text>
                                                $ <span class="h6" id="subtotal"><%=String.format("%.2f", book.getPrice() * cartDAO.getBookQtyInCart(user.getId(), book.getId()))%></span>
                                            </text> <br />
                                            <small class="text-muted text-nowrap"> $<span class="text-custom" id="book-price"><%=book.getPrice()%></span> / per item </small>
                                        </div>
                                    </div>
                                    <div class="col-lg col-sm-6 d-flex justify-content-sm-center justify-content-md-start justify-content-lg-center justify-content-xl-end mb-2">
                                        <div class="float-md-end" id="btn-remove-cart">
                                            <a href="#" class="btn btn-light border text-danger icon-hover-danger"> Remove</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- product line -->
                                <%}%>
                            </div>

                            <div class="border-top pt-4 mx-4 mb-4">
                                <p><i class="fas fa-truck text-muted fa-lg"></i> Free Delivery within 1-2 weeks</p>
                                <p class="text-muted">
                                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
                                    aliquip
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- cart -->

                    <!-- summary -->
                    <div class="col-lg-3">
                        <div class="card mb-3 border shadow-0">
                            <div class="card-body">
                                <form>
                                    <div class="form-group">
                                        <label class="form-label">Have coupon?</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control border" name="" placeholder="Coupon code" />
                                            <button class="btn btn-light border">Apply</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="card shadow-0 border">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <p class="mb-2">Total price:</p>
                                    <p class="mb-2" id="totalPrice">$<%=String.format("%.2f", totalPrice)%></p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <p class="mb-2">Discount:</p>
                                    <p class="mb-2 text-success">-$0.00</p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <p class="mb-2">TAX:</p>
                                    <p class="mb-2" id="tax">$<%=String.format("%.2f", tax)%></p>
                                </div>
                                <hr />
                                <div class="d-flex justify-content-between">
                                    <p class="mb-2">Grand Total:</p>
                                    <p class="mb-2 fw-bold" id="grandTotal">$<%=String.format("%.2f", grandTotal)%></p>
                                </div>

                                <div class="mt-3">
                                    <a href="#" class="btn btn-success w-100 shadow-0 mb-2"> Make Purchase </a>
                                    <a href="index.jsp" class="btn btn-light w-100 border mt-2"> Back to shop </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- summary -->
                </div>

                <div id="noItemsDiv" class="py-5" style="visibility: hidden;">
                <span class="fs-4">
                    <i class="fa-solid fa-xmark"></i>
                    <span>There are no items in your cart</span>
                    <a href="collections.jsp"><button class="btn btn-add-wishlist">Explore our collections</button></a>
                </span>
                </div>
                <%}
                    assert user != null;
                %>
            </div>
        </section>
        <!-- cart + summary -->

        <!-- Recommended -->
        <section>
            <div class="container my-5">
                <header class="mb-4">
                    <h3>Recommended items</h3>
                </header>

                <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="card px-4 border shadow-0 mb-4 mb-lg-0">
                            <div class="mask px-2" style="height: 50px;">
                                <div class="d-flex justify-content-between">
                                    <h6><span class="badge bg-danger pt-1 mt-3 ms-2">New</span></h6>
                                    <a href="#"><i class="fas fa-heart text-primary fa-lg float-end pt-3 m-2"></i></a>
                                </div>
                            </div>
                            <a href="#" class="">
                                <img src="https://bootstrap-ecommerce.com/bootstrap5-ecommerce/images/items/7.webp" class="card-img-top rounded-2" />
                            </a>
                            <div class="card-body d-flex flex-column pt-3 border-top">
                                <a href="#" class="nav-link">Gaming Headset with Mic</a>
                                <div class="price-wrap mb-2">
                                    <strong class="">$18.95</strong>
                                    <del class="">$24.99</del>
                                </div>
                                <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                    <a href="#" class="btn btn-outline-primary w-100">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="card px-4 border shadow-0 mb-4 mb-lg-0">
                            <div class="mask px-2" style="height: 50px;">
                                <a href="#"><i class="fas fa-heart text-primary fa-lg float-end pt-3 m-2"></i></a>
                            </div>
                            <a href="#" class="">
                                <img src="https://bootstrap-ecommerce.com/bootstrap5-ecommerce/images/items/5.webp" class="card-img-top rounded-2" />
                            </a>
                            <div class="card-body d-flex flex-column pt-3 border-top">
                                <a href="#" class="nav-link">Apple Watch Series 1 Sport </a>
                                <div class="price-wrap mb-2">
                                    <strong class="">$120.00</strong>
                                </div>
                                <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                    <a href="#" class="btn btn-outline-primary w-100">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="card px-4 border shadow-0">
                            <div class="mask px-2" style="height: 50px;">
                                <a href="#"><i class="fas fa-heart text-primary fa-lg float-end pt-3 m-2"></i></a>
                            </div>
                            <a href="#" class="">
                                <img src="https://bootstrap-ecommerce.com/bootstrap5-ecommerce/images/items/9.webp" class="card-img-top rounded-2" />
                            </a>
                            <div class="card-body d-flex flex-column pt-3 border-top">
                                <a href="#" class="nav-link">Men's Denim Jeans Shorts</a>
                                <div class="price-wrap mb-2">
                                    <strong class="">$80.50</strong>
                                </div>
                                <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                    <a href="#" class="btn btn-outline-primary w-100">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="card px-4 border shadow-0">
                            <div class="mask px-2" style="height: 50px;">
                                <a href="#"><i class="fas fa-heart text-primary fa-lg float-end pt-3 m-2"></i></a>
                            </div>
                            <a href="#" class="">
                                <img src="https://bootstrap-ecommerce.com/bootstrap5-ecommerce/images/items/10.webp" class="card-img-top rounded-2" />
                            </a>
                            <div class="card-body d-flex flex-column pt-3 border-top">
                                <a href="#" class="nav-link">Mens T-shirt Cotton Base Layer Slim fit </a>
                                <div class="price-wrap mb-2">
                                    <strong class="">$13.90</strong>
                                </div>
                                <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                    <a href="#" class="btn btn-outline-primary w-100">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Recommended -->

        <!-- Footer -->
        <%@include file="all_component/footer.jsp"%>
        <!-- Footer -->

        <%--Xử lý tăng giảm quantity--%>
        <script>
            // Lấy tất cả các nút "Tăng" và "Giảm"
            const increaseButtons = document.querySelectorAll("#increase-button");
            const decreaseButtons = document.querySelectorAll("#decrease-button");

            // Thêm sự kiện click cho các nút "Tăng"
            increaseButtons.forEach(function(button) {
                button.addEventListener("click", function() {
                    const quantityInput = this.parentNode.querySelector("#quantity-input");
                    handleQuantityChange(quantityInput, "increase");
                });
            });

            // Thêm sự kiện click cho các nút "Giảm"
            decreaseButtons.forEach(function(button) {
                button.addEventListener("click", function() {
                    const quantityInput = this.parentNode.querySelector("#quantity-input");
                    handleQuantityChange(quantityInput, "decrease");
                });
            });

        </script>

        <script>
            // Get all the remove cart buttons
            const removeCartBtns = document.querySelectorAll('#btn-remove-cart');
            const cartQtySpan = document.getElementById('cartQty');

            // Add click event listener to each button
            removeCartBtns.forEach(btn => {
                btn.addEventListener('click', (event) => {
                    removeBookFromCart.call(btn, event);
                });
            });

        </script>

        <script>
            // Hàm xử lý việc tăng/giảm số lượng cho sản phẩm tương ứng
            function handleQuantityChange(quantityInput, operation) {
                let currentValue = parseInt(quantityInput.value);

                if (operation === "increase") {
                    currentValue++;
                } else if (operation === "decrease") {
                    if (currentValue > 1) {
                        currentValue--;
                    }
                }

                quantityInput.value = currentValue;
                updateTotals(quantityInput);
            }

            // Cập nhật subtotal cho sản phẩm hiện tại
            function updateSubtotal(currentQuantityInput){
                const quantity = parseInt(currentQuantityInput.value);
                console.log('quantity : ' + quantity);
                const price = parseFloat(currentQuantityInput.closest('.row').querySelector("#book-price").textContent);
                console.log('price : ' + price);
                const subtotal = quantity * price;
                console.log('subtotal : ' + subtotal);
                currentQuantityInput.closest('.row').querySelector("#subtotal").textContent = subtotal.toFixed(2);
            }

            // Cập nhật summary
            function updateSummary(){
                // Khởi tạo biến totalPrice bằng 0
                let totalPrice = 0;
                // Lặp qua các phần tử input số lượng và cập nhật totalPrice
                const quantityInputs = document.querySelectorAll("#quantity-input");
                quantityInputs.forEach(function(quantityInput) {
                    totalPrice += parseFloat(quantityInput.closest('.row').querySelector("#subtotal").textContent);
                });

                console.log('totalPrice : ' + totalPrice);

                // Cập nhật giá trị <p class="mb-2">$329.00</p>
                document.querySelector("#totalPrice").textContent = totalPrice.toFixed(2);

                // Tính toán thuế (10% của totalPrice)
                const tax = totalPrice * 0.1;

                // Cập nhật giá trị thuế
                document.querySelector("#tax").textContent = tax.toFixed(2);

                // Tính toán tổng giá trị cuối cùng
                const grandTotal = totalPrice + tax;

                // Cập nhật giá trị <p class="mb-2 fw-bold">$283.00</p>
                document.querySelector("#grandTotal").textContent = grandTotal.toFixed(2);
            }

            // Cập nhật hàm updateTotals()
            function updateTotals(currentQuantityInput) {
                updateSubtotal(currentQuantityInput);

                updateSummary();
            }

            function removeBookFromCart(event) {
                event.preventDefault(); // Prevent the default behavior

                // Get the book ID from the card's URL or data attribute
                const bookId = this.closest('.row').querySelector('a').href.split('bookID=')[1];

                // Send the AJAX request to remove the book from the cart
                fetch('RemoveFromCartServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'bookId=' + encodeURIComponent(bookId)
                })
                    .then(response => {
                        if (response.ok) {
                            // Remove the product line from the UI
                            this.closest('.row').remove();

                            // Update the cart quantity
                            response.text().then(function(data) {
                                console.log(data)
                                const cartQty = data ? data : '0';

                                updateCartQty(cartQty);

                                // Show or hide the "No items" div based on the cart status
                                setCartVisibility(cartQty);
                            });
                            updateSummary();

                            // Show the success toast
                            // const removeFromCartSuccessToast = document.getElementById('removeFromCartSuccessToast');
                            // const toast = new bootstrap.Toast(removeFromCartSuccessToast);
                            // toast.show();
                        } else {
                            console.error('Failed to remove book from cart');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
            }

            // Update the cart quantity and show/hide the span
            function updateCartQty(qty) {
                cartQtySpan.innerText = qty;
                if (qty === '0') {
                    cartQtySpan.style.visibility = 'hidden';
                } else {
                    cartQtySpan.style.visibility = 'visible';
                }
            }

            // Show or hide the "No items" div based on the cart status
            function setCartVisibility(cartQty) {
                const noItemsDiv = document.getElementById('noItemsDiv');
                const mainContent = document.getElementById('main-content');

                if (cartQty === '0') {
                    noItemsDiv.style.visibility = 'visible';
                    if (mainContent) {
                        mainContent.style.display = 'none'; // Add a null check for mainContent
                    }
                }
            }

        </script>
</body>
</html>
