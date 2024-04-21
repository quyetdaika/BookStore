<%@ page import="java.sql.Connection" %>
<%@ page import="bookstore.DB.DBConnect" %>
<%@ page import="bookstore.DAO.BookDAOIplm" %>
<%@ page import="java.util.List" %>
<%@ page import="bookstore.entity.Book" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="bookstore.DAO.BookDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    List<String> categories = bookDAO.getCategories();
    List<Book> allBooks = new ArrayList<>();

    String tagParam = request.getParameter("tag");
    String categoryParam = request.getParameter("category");

    Map<String, String> categoryMap = new HashMap<String, String>();
    categoryMap.put("comics-manga", "Comics & Manga");
    categoryMap.put("anime-characters", "Anime & Characters");
    categoryMap.put("learn-japanese", "Learn Japanese");
    categoryMap.put("photography", "Photography");
    categoryMap.put("art-design", "Art & Design");
    categoryMap.put("music-musical", "Music & Musical Score");

    String filterTitle = "";

    if(tagParam != null){
        if(tagParam.equals("new-release-books")){
            allBooks = bookDAO.getNewReleaseBooks();
            filterTitle = "New Release Books";
        } else {
            allBooks = bookDAO.getSaleBooks();
            filterTitle = "Sale Books";
        }
    }

    if(categoryParam != null){
        filterTitle = categoryMap.get(categoryParam);
        allBooks = bookDAO.getBookByCategory(filterTitle);
        System.out.println(allBooks.size());
    }
%>

<div class="container">
    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
        <ol class="breadcrumb text-title">
            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Collections</li>
            <%if(categoryParam != null) {%>
            <li class="breadcrumb-item active" aria-current="page"><%=filterTitle%></li>
            <%}%>
        </ol>
    </nav>
</div>


<!-- sidebar + content -->
<section class="border-top">
    <div class="container my-5">
        <div class="row">
            <!-- sidebar -->
            <div class="col-lg-3">
                <h4 class="fw-bold">Category</h4>
                <div class="border-top py-2">
                    <ul class="list-unstyled px-3">
                        <%for(Map.Entry<String, String> entry : categoryMap.entrySet()) {%>
                        <li class="my-2">
                            <a href="collections.jsp?category=<%=entry.getKey()%>" class="text-title icon-hover">
                            <%if(entry.getValue().equals(filterTitle)) {%>
                                    <i class="fa-regular fa-circle-dot"></i>
                                <%} else {%>
                                <i class="fa-regular fa-circle"></i>
                                <%}%>
                                <%=entry.getValue()%>
                            </a>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
            <!-- sidebar -->
            <!-- content -->
            <div class="col-lg-9">
                <header class="d-sm-flex align-items-center mb-4 pb-3">
                    <h3 class="fw-bold"><%=filterTitle%></h3>
                    <strong class="d-block py-2 mx-4"><%=allBooks.size()%> Items found </strong>
                    <div class="ms-auto">
                        <select class="form-select d-inline-block w-auto border pt-1">
                            <option value="0">Best match</option>
                            <option value="1">Recommended</option>
                            <option value="2">High rated</option>
                            <option value="3">Randomly</option>
                        </select>
                        <div class="btn-group shadow-0 border">
                            <a href="#" class="btn btn-light" title="List view">
                                <i class="fa fa-bars fa-lg"></i>
                            </a>
                            <a href="#" class="btn btn-light active" title="Grid view">
                                <i class="fa fa-th fa-lg"></i>
                            </a>
                        </div>
                    </div>
                </header>

                <%
                    // Số lượng sản phẩm trên mỗi trang
                    int itemsPerPage = 16;

                    // Tổng số lượng sản phẩm
                    int totalItems = allBooks.size();

                    // Tổng số trang
                    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

                    // Lấy số trang hiện tại từ tham số truyền vào (nếu không có thì mặc định là trang đầu tiên)
                    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

                    // Xác định vị trí bắt đầu của sản phẩm trong trang hiện tại
                    int startIndex = (currentPage - 1) * itemsPerPage;

                    // Xác định vị trí kết thúc của sản phẩm trong trang hiện tại
                    int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

                    // Danh sách sản phẩm của trang hiện tại
                    List<Book> currentPageBooks = allBooks.subList(startIndex, endIndex);

                    // Tạo query string để bao gồm các parameter hiện tại trong các liên kết phân trang
                    String queryString = "";
                    if(tagParam != null) {
                        queryString += "&tag=" + tagParam;
                    }
                    if(categoryParam != null) {
                        queryString += "&category=" + categoryParam;
                    }
                %>

                <div class="container">
                    <div class="row">
                        <% for (Book book : currentPageBooks) { %>
                        <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
                            <a href="">
                                <div class="card border-0">
                                    <img src="<%= URLDecoder.decode("book/" + book.getFileName(), "UTF-8") %>" class="card-img-top img-fluid mx-auto d-block p-4" alt="...">
                                    <div class="card-body">
                                        <div class="row justify-content-between align-items-center">
                                            <p class="text-title"><%= book.getName() %></p>
                                            <div class="col">
                                                <div>
                                                    <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                                    <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                                    <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                                    <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                                    <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                                </div>
                                                <p class="fw-bold fs-4">$<%= book.getPrice() %></p>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fa-regular fa-heart fa-beat-fade fa-xl" style="color: #ff0505;" data-bs-toggle="tooltip" data-bs-placement="top" title="Add to Wishlist"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Pagination -->
                <nav aria-label="Page navigation example" class="d-flex justify-content-center mt-3">
                    <ul class="pagination">
                        <%-- Nút Previous --%>
                        <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                            <a class="page-link" href="?page=<%= currentPage - 1 %><%= queryString %>" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>

                        <%-- Danh sách các trang --%>
                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <li class="page-item <%= currentPage == i ? "active" : "" %>">
                            <a class="page-link" href="?page=<%= i %><%= queryString %>"><%= i %></a>
                        </li>
                        <% } %>

                        <%-- Nút Next --%>
                        <li class="page-item <%= currentPage == totalPages ? "disabled" : "" %>">
                            <a class="page-link" href="?page=<%= currentPage + 1 %><%= queryString %>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
                <!-- Pagination -->
            </div>
        </div>
    </div>
</section>
<!-- sidebar + content -->

<!-- Footer -->
<%@include file="all_component/footer.jsp"%>
<!-- Footer -->
</body>
</html>