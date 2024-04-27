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
