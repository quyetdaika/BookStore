<%@ page import="java.net.URLDecoder" %>
<section class="my-5">
    <div class="container border-top py-4">
        <div class="row align-items-center justify-content-between">
            <div class="col-auto">
                <h2 class="fw-bold">New Release</h2>
            </div>
            <div class="col-auto">
                <a href="">More new release books></a>
            </div>
        </div>
        <div class="row g-4">
            <%
                for(Book book : newReleaseBooks){
                    String coverSrc = "book/" + book.getFileName();
            %>
                <div class="col-lg-3 col-md-6 col-12 px-5">
                    <a href="">
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
                }
            %>
        </div>
    </div>
</section>