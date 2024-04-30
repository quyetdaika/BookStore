<%@ page import="java.sql.Connection" %> <%@ page import="bookstore.DB.DBConnect" %> <%@ page import="bookstore.DAO.BookDAOIplm" %> <%@ page import="bookstore.entity.Book" %> <%@ page import="java.net.URLDecoder" %> <%@ page
        import="bookstore.DAO.BookDAO" %> <%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Wishlist</title>
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
    List<Book> wishlistBooks = new ArrayList<>();
    if(user != null){
        List<Integer> bookIDs = wishlistDAO.getBookIDs(user.getId());
        for(int bookID : bookIDs){
            wishlistBooks.add(bookDAO.getBookByID(bookID));
        }
    }
%>

 <section style="min-height: 50vh">
     <div class="container p-4">
         <%--Title--%>
         <div style="padding: 20px">
            <span class="d-flex align-items-center">
                <i class="fa-solid fa-heart fa-2xl" style="color: #ED356F;"></i>
                <h3 class="fw-bold ms-2 mb-0">My Wishlist</h3>
            </span>
         </div>
         <%--Title--%>


         <%if(wishlistBooks.isEmpty()){%>
             <%if(user == null){%>
                 <div class="py-5">
                     <span class="fs-4">
                         <i class="fa-solid fa-right-to-bracket"></i>
                         <span>Please login to save your wishlist across devices.</span>
                         <a href="login.jsp"><button class="btn btn-add-wishlist">LOGIN</button></a>
                     </span>
                 </div>
             <%} else {%>
                <div id="noItemsDiv" class="py-5" style="display: <%= wishlistBooks.isEmpty() ? "block" : "none" %>;">
                    <span class="fs-4">
                        <i class="fa-solid fa-xmark"></i>
                        <span>There are no items in this wishlist</span>
                        <a href="collections.jsp"><button class="btn btn-add-wishlist">Explore our collections</button></a>
                    </span>
                 </div>
             <%}%>
         <%} else {%>
             <div class="container my-2">
                 <span style="color: #EF497D" class="text-uppercase fw-bold">
                     <span id="btn-add-all-to-cart" class="p-2 btn-no-bg">add all to cart</span>
                     <span id="btn-remove-all-from-wishlist" class="p-2 btn-no-bg">remove all from wishlist</span>
                 </span>
             </div>

             <div class="container">
                 <div class="row">
                     <%--Product list--%>
                     <%
                         for(Book book : wishlistBooks){
                             String coverSrc = "book/" + book.getFileName();
                     %>
                     <div class="col-lg-3 col-md-6 col-12 my-2">
                         <a href="product-detail.jsp?bookID=<%=book.getId()%>">
                             <div class="card border h-100">
                                 <div class="product-image">
                                     <img src="<%= URLDecoder.decode(coverSrc, "UTF-8") %>" class="card-img-top img-fluid mx-auto d-block p-4" alt="...">
                                 </div>
                                 <div class="card-body d-flex flex-column">
                                     <div class="mb-3">
                                         <p class="text-title mb-0"><%=book.getName()%></p>
                                     </div>
                                     <div class="d-flex justify-content-between align-items-center mb-3">
                                         <p class="fw-bold fs-4 mb-0">$<%=book.getPrice()%></p>
                                     </div>
                                     <div class="d-flex align-items-center mt-auto">
                                         <a href="#" id="btn-add-to-cart" class="btn-add-wishlist flex-grow-1 fw-bold">
                                             ADD TO CART
                                         </a>
                                         <button id="btn-remove-wishlist" class="btn" style="transition: color 0.3s;" onmouseover="this.querySelector('i.fa-trash-can').style.color = 'red';" onmouseout="this.querySelector('i.fa-trash-can').style.color = 'black';">
                                             <i class="fa-solid fa-trash-can fa-lg"></i>
                                         </button>
                                     </div>
                                 </div>
                             </div>
                         </a>
                     </div>
                     <%
                         }
                     %>
                 </div>
             </div>
             <%--Product list--%>

             <div id="noItemsDiv" class="py-5" style="visibility: hidden">
                    <span class="fs-4">
                        <i class="fa-solid fa-xmark"></i>
                        <span>There are no items in this wishlist</span>
                        <a href="collections.jsp"><button class="btn btn-add-wishlist">Explore our collections</button></a>
                    </span>
             </div>
         <%}
             assert user != null;
         %>

     </div>
 </section>
<%--Content--%>

<!-- Footer -->
<%@include file="all_component/footer.jsp"%>
<!-- Footer -->

<!-- Toast -->
<%@include file="all_component/toast.jsp"%>
<!-- Toast -->


<!-- Handle add to card btn -->
<script>
    const addToCartSuccessToast = document.getElementById('addToCartSuccessToast');
    const loginToAddCartToast = document.getElementById('loginToAddCartToast');
    const cartQtySpan = document.getElementById('cartQty');
    const addToCartBtns = document.querySelectorAll('#btn-add-to-cart');

    // Thêm sự kiện click cho tất cả các nút ".btn-add-cart-2" bằng Event Delegation

    // Add click event listener to each button
    addToCartBtns.forEach(btn => {
        // Remove from wishlist
        btn.addEventListener('click', () => {
            removeBookFromWishlist.call(btn);
        });

        // Add to cart
        btn.addEventListener('click', (event) => {
            addToCart.call(btn, event);
        });
    });
</script>

<%--Handle remove book from wishlist btn--%>
<script>
    // Get all the remove wishlist buttons
    const removeWishlistBtns = document.querySelectorAll('#btn-remove-wishlist');
    const wishlistQtySpan = document.getElementById('wishlistQty');
    const noItemsDiv = document.getElementById('noItemsDiv');

    // Add click event listener to each button
    removeWishlistBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            removeBookFromWishlist.call(btn);
        });
    });

</script>

<%--Handle add all to cart--%>
<script>
    const addAllToCartBtn = document.getElementById('btn-add-all-to-cart');

    addAllToCartBtn.addEventListener('click', () => {
        addAllToCart();
    });
</script>

<%--Handle remove all from wishlist--%>
<script>
    const removeAllFromWishlistBtn = document.getElementById('btn-remove-all-from-wishlist');

    removeAllFromWishlistBtn.addEventListener('click', () => {
        removeAllFromWishlist();
    });
</script>


<%--All Function--%>
<script>
    function addToCart(event){
        event.preventDefault(); // Prevent the default behavior

        const quantity = 1;

        // Get the book ID from the card's URL or data attribute
        const bookId = this.closest('.card').querySelector('a').href.split('bookID=')[1];

        // Gọi Servlet để thêm sản phẩm vào giỏ hàng
        fetch('AddToCartServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'bookId=' + encodeURIComponent(bookId) + '&quantity=' + encodeURIComponent(quantity)
        })
            .then(response => {
                if (response.ok) {
                    // Remove the book card from the UI
                    this.closest('.col-lg-3').remove();

                    // Lấy số lượng hiện tại từ phản hồi của servlet
                    response.text().then(function(cartQty) {
                        // Cập nhật số lượng hiển thị trong giao diện người dùng
                        updateCartQty(cartQty);

                        console.log(wishlistQtySpan.innerText);

                        // Update the wishlist quantity
                        updateWishlistQty(wishlistQtySpan.innerText ? wishlistQtySpan.innerText : '0');

                        // Show or hide the "No items" div based on the wishlist status
                        setButtonVisibility(wishlistQtySpan.innerText ? wishlistQtySpan.innerText : '0');

                        // Hiển thị toast thông báo thành công
                        var toast = new bootstrap.Toast(addToCartSuccessToast);
                        toast.show();
                    });

                } else {
                    console.error('Failed to add book to cart');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    function removeBookFromWishlist(){
        // Get the book ID from the card's URL or data attribute
        const bookId = this.closest('.card').querySelector('a').href.split('bookID=')[1];

        // Send the AJAX request to remove the book from the wishlist
        fetch('RemoveFromWishlistServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'bookId=' + encodeURIComponent(bookId)
        })
            .then(response => {
                if (response.ok) {
                    // Remove the book card from the UI
                    this.closest('.col-lg-3').remove();

                    // Update the wishlist quantity
                    response.text().then(function(data) {
                        updateWishlistQty(data);

                        // Show or hide the "No items" div based on the wishlist status
                        setButtonVisibility(data);
                    });

                    // Show the success toast
                    const removeFromWishlistSuccessToast = document.getElementById('removeFromWishlistSuccessToast');
                    const toast = new bootstrap.Toast(removeFromWishlistSuccessToast);
                    toast.show();
                } else {
                    console.error('Failed to remove book from wishlist');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    function addAllToCart() {
        <%if(user != null){%>
        const bookCards = document.querySelectorAll('.col-lg-3');

        // Get all the book IDs from the wishlist
        <%
            List<Integer> bookIDs = wishlistDAO.getBookIDs(user.getId());
            String bookIDsString = String.join(",", bookIDs.stream().map(Object::toString).collect(Collectors.toList()));
        %>


        // Send the AJAX request to add all books to the cart
        fetch('AddAllToCartServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'userId=<%= user.getId() %>&bookIds=<%= bookIDsString %>'
        })
            .then(response => {
                if (response.ok) {
                    // Remove all book cards from the UI
                    const bookCards = document.querySelectorAll('.col-lg-3');
                    bookCards.forEach(card => card.remove());

                    // Update the cart quantity
                    response.text().then(function(data) {
                        updateCartQty(data);
                    });

                    // Update the wishlist quantity
                    updateWishlistQty('0');

                    // Show the "No items" div
                    setButtonVisibility('0');

                    // Show the success toast
                    const addAllToCartSuccessToast = document.getElementById('addAllToCartSuccessToast');
                    const toast = new bootstrap.Toast(addAllToCartSuccessToast);
                    toast.show();
                } else {
                    console.error('Failed to add all books to cart');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        <%}%>
    }

    // Hàm xóa tất cả book khỏi wishlist
    function removeAllFromWishlist() {
        <%if(user != null){%>
            // Send the AJAX request to remove all books from the wishlist
            fetch('RemoveAllFromWishlistServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'userId=<%= user.getId() %>'
            })
                .then(response => {
                    if (response.ok) {
                        // Remove all book cards from the UI
                        const bookCards = document.querySelectorAll('.col-lg-3');
                        bookCards.forEach(card => card.remove());

                        // Update the wishlist quantity
                        updateWishlistQty('0');

                        // Show the "No items" div
                        setButtonVisibility('0');

                        // Show the success toast
                        const removeAllFromWishlistSuccessToast = document.getElementById('removeAllFromWishlistSuccessToast');
                        const toast = new bootstrap.Toast(removeAllFromWishlistSuccessToast);
                        toast.show();
                    } else {
                        console.error('Failed to remove all books from wishlist');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        <%}%>
    }

    // Hàm cập nhật số lượng sản phẩm trong Wishlist và hiển thị/ẩn span
    function updateWishlistQty(qty) {
        wishlistQtySpan.innerText = qty;
        if (qty === '0') {
            wishlistQtySpan.style.visibility = 'hidden';
        } else {
            wishlistQtySpan.style.visibility = 'visible';
        }
    }

    // Hàm cập nhật số lượng sản phẩm trong cart và hiển thị/ẩn span
    function updateCartQty(qty) {
        cartQtySpan.innerText = qty;
        if (qty === '0') {
            cartQtySpan.style.visibility = 'hidden';
        } else {
            cartQtySpan.style.visibility = 'visible';
        }
    }

    // Hàm ẩn / hiện các nút và span
    function setButtonVisibility(wishlistQty){
        if(wishlistQty === '0'){
            noItemsDiv.style.visibility = 'visible';
            removeAllFromWishlistBtn.style.visibility = 'hidden';
            addAllToCartBtn.style.visibility = 'hidden';
        } else {
            noItemsDiv.style.visibility = 'hidden';
            removeAllFromWishlistBtn.style.visibility = 'visible';
            addAllToCartBtn.style.visibility = 'visible';
        }
    }
</script>

</body>
</html>
