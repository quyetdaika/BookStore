<%@ page import="java.net.URLDecoder" %>
<section class="my-5">
    <div class="container border-top py-4">
        <div class="row align-items-center justify-content-between">
            <div class="col-auto">
                <h4 class="fw-bold">Sale Books</h4>
            </div>
            <div class="col-auto">
                <a href="collections.jsp?tag=sale-books">More sale books></a>
            </div>
        </div>
        <div class="row g-4">
            <%
                int j = 0;
                for(Book book : saleBooks){
                    if(j >= 4) break;
                    String coverSrc = "book/" + book.getFileName();
            %>
            <div class="col-lg-3 col-md-6 col-12 px-5">
                <a href="product-detail.jsp?bookID=<%=book.getId()%>">
                    <div class="card border-0">
                        <img src="<%= URLDecoder.decode(coverSrc, "UTF-8") %>" class="card-img-top img-fluid mx-auto d-block p-4" alt="...">
                        <div class="card-body">
                            <div class="row justify-content-between align-items-center">
                                <p class="text-title"><%=book.getName()%></p>
                                <div class="col">
                                    <div>
                                        <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                        <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                        <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                        <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                        <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                    </div>
                                    <p class="fw-bold fs-4">$<%=book.getPrice()%></p>
                                </div>
                                <div class="col-auto">
                                    <i class="fa-regular fa-heart fa-beat-fade fa-xl" style="color: #ff0505;" data-bs-toggle="tooltip" data-bs-placement="top" title="Add to Wishlist"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <%
                    j++;
                }
            %>
        </div>
    </div>
</section>