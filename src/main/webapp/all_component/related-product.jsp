<%@ page import="java.net.URLDecoder" %>

<section class="my-5">
    <div class="container border-top py-4">
        <div class="row align-items-center justify-content-between">
            <div class="col-auto">
                <h4 class="fw-bold">Related Products</h4>
            </div>
        </div>
        <div class="row g-4">
            <%
                int i = 0;
                for(Book book : relatedBooks){
                    if(i >= 4) break;
                    String coverSrc = "book/" + book.getFileName();
            %>
                    <div class="col-lg-3 col-md-6 col-12 px-5">
                        <a href="product-detail.jsp?bookID=<%=book.getId()%>">
                            <div class="card border-0 h-100">
                                <div class="product-image">
                                    <img src="<%= URLDecoder.decode(coverSrc, "UTF-8") %>" class="card-img-top img-fluid mx-auto d-block p-4" alt="...">
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <div class="mb-3">
                                        <p class="text-title mb-0"><%=book.getName()%></p>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <p class="fw-bold fs-4 mb-0" style="color: #212121">$<%=book.getPrice()%></p>
                                        <div class="col-auto">
                                            <i class="fa-regular fa-heart fa-beat-fade fa-xl" style="color: #ff0505;" data-bs-toggle="tooltip" data-bs-placement="top" title="Add to Wishlist"></i>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center mt-auto">
                                        <a href="#" class="btn-add-to-cart-2 flex-grow-1 fw-bold">
                                            </i>ADD TO CART
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
            <%
                    i++;
                }
            %>
        </div>
    </div>
</section>

<script>
    // Thêm sự kiện click cho tất cả các nút ".btn-add-cart-2" bằng Event Delegation
    const addToCartBtns = document.querySelectorAll('.btn-add-to-cart-2');
    // Add click event listener to each button
    addToCartBtns.forEach(btn => {
        btn.addEventListener('click', function(event) {

            event.preventDefault(); // Ngăn chặn hành vi mặc định của liên kết

            // Kiểm tra trạng thái đăng nhập
            <% if (user == null) { %>
            // Hiển thị toast nếu chưa đăng nhập
            var toast = new bootstrap.Toast(loginToAddCartToast);
            toast.show();
            <% } else { %>
            // Get the book ID from the card's URL or data attribute
            const bookId = this.closest('.card').querySelector('a').href.split('bookID=')[1];

            // Gọi Servlet để thêm sản phẩm vào giỏ hàng
            fetch('AddToCartServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'bookId=' + encodeURIComponent(bookId) + '&quantity=' + encodeURIComponent('1')
            })
                .then(response => {
                    if (response.ok) {
                        // Lấy số lượng hiện tại từ phản hồi của servlet
                        response.text().then(function(data) {
                            // Cập nhật số lượng hiển thị trong giao diện người dùng
                            updateCartQty(data);

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
            <% } %>
        });
    });
</script>