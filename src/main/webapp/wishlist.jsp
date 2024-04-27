<%@ page import="java.sql.Connection" %> <%@ page import="bookstore.DB.DBConnect" %> <%@ page import="bookstore.DAO.BookDAOIplm" %> <%@ page import="bookstore.entity.Book" %> <%@ page import="java.net.URLDecoder" %> <%@ page
        import="bookstore.DAO.BookDAO" %> <%@ page import="java.util.*" %> <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                                         <a href="#" class="btn-add-wishlist flex-grow-1 fw-bold">
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
         <%}%>

     </div>
 </section>
<%--Content--%>

<!-- Footer -->
<%@include file="all_component/footer.jsp"%>
<!-- Footer -->

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

<script>
    // Get all the remove wishlist buttons
    const removeWishlistBtns = document.querySelectorAll('#btn-remove-wishlist');
    const wishlistQtySpan = document.getElementById('wishlistQty');
    const noItemsDiv = document.getElementById('noItemsDiv');

    // Add click event listener to each button
    removeWishlistBtns.forEach(btn => {
        btn.addEventListener('click', function() {
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
                            if (data === '0') {
                                noItemsDiv.style.display = 'block';
                            } else {
                                noItemsDiv.style.display = 'none';
                            }
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
        });
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
