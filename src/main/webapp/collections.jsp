<%@ page import="java.sql.Connection" %>
<%@ page import="bookstore.DB.DBConnect" %>
<%@ page import="bookstore.DAO.BookDAOIplm" %>
<%@ page import="bookstore.entity.Book" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="bookstore.DAO.BookDAO" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Collections</title>
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
//    List<String> categories = bookDAO.getCategories();
    List<Book> allBooks = bookDAO.getAllBooks();

    String tagParam = request.getParameter("tag");
    String categoryParam = request.getParameter("category");
    String sortByParam = request.getParameter("sort_by");

    Map<String, String> categoryMap = new HashMap<String, String>();
    categoryMap.put("comics-manga", "Comics & Manga");
    categoryMap.put("anime-characters", "Anime & Characters");
    categoryMap.put("learn-japanese", "Learn Japanese");
    categoryMap.put("photography", "Photography");
    categoryMap.put("art-design", "Art & Design");
    categoryMap.put("music-musical", "Music & Musical Score");
    categoryMap.put("dictionary", "Dictionary");
    categoryMap.put("dvd-blu-ray", "DVD & Blu-ray");
    categoryMap.put("cds-vinyl", "CDs & Vinyl");
    categoryMap.put("self-help-hobbies", "Self-Help & Hobbies");

    String filterTitle = "Collections";

    if(tagParam != null){
        if(tagParam.equals("new-release-books")){
            allBooks = bookDAO.getNewReleaseBooks();
            filterTitle = "New Release Books";
        } else if(tagParam.equals("sale-books")) {
            allBooks = bookDAO.getSaleBooks();
            filterTitle = "Sale Books";
        } else if(tagParam.equals("best-sellers")){
            allBooks = bookDAO.getBestSellerBooks();
            filterTitle =  "Best Sellers";
        }
        else {
            allBooks = bookDAO.getBookByName("My Hero Academia");
            filterTitle = "My Hero Academia";
        }
    }

    if(categoryParam != null){
        filterTitle = categoryMap.get(categoryParam);
        allBooks = bookDAO.getBookByCategory(filterTitle);
        System.out.println(allBooks.size());
    }

    if(sortByParam != null){
        if(sortByParam.equals("best-selling")) {
            allBooks.sort(new Comparator<Book>() {
                @Override
                public int compare(Book o1, Book o2) {
                    return o2.getSold() - o1.getSold();
                }
            });
        }
        else {
            String field = sortByParam.split("-")[0];
            String order = sortByParam.split("-")[1];
            allBooks.sort(new Comparator<Book>() {
                @Override
                public int compare(Book o1, Book o2) {
                    if (order.equals("asc")) {
                        if (field.equals("name")) {
                            return o1.getName().compareTo(o2.getName());
                        } else return Double.compare(o1.getPrice(), o2.getPrice());
                    } else {
                        if (field.equals("name")) {
                            return o2.getName().compareTo(o1.getName());
                        } else return Double.compare(o2.getPrice(), o1.getPrice());
                    }
                }
            });
        }
    }
%>

<%--breadcrumb--%>
<div class="container">
    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
        <ol class="breadcrumb text-title">
            <li class="breadcrumb-item"> <a href="index.jsp"> <i class="fa fa-home"></i> Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Collections</li>
            <%if(categoryParam != null) {%>
            <li class="breadcrumb-item active" aria-current="page"><%=filterTitle%></li>
            <%}%>
        </ol>
    </nav>
</div>
<%--breadcrumb--%>

<!-- sidebar + content -->
<section class="border-top">
    <div class="container my-5">
        <div class="row">
            <!-- sidebar -->
            <%@include file="all_component/sidebar.jsp"%>
            <!-- sidebar -->
            <!-- content -->
            <div class="col-lg-9">
                <header class="d-sm-flex align-items-center mb-4 pb-3">
                    <h3 class="fw-bold"><%=filterTitle%></h3>
                    <strong class="d-block py-2 mx-4"><%=allBooks.size()%> Items found </strong>
                    <div class="ms-auto">
                        <span>Sort by</span>
                        <select class="form-select d-inline-block w-auto border pt-1" onchange="sortBooks(this)">
                            <option value="best-selling" <%= sortByParam == null || sortByParam.equals("best-selling") ? "selected" : "" %>>Best selling</option>
                            <option value="name-asc" <%= sortByParam != null && sortByParam.equals("name-asc") ? "selected" : "" %>>Alphabetically A-Z</option>
                            <option value="name-desc" <%= sortByParam != null && sortByParam.equals("name-desc") ? "selected" : "" %>>Alphabetically Z-A</option>
                            <option value="price-asc" <%= sortByParam != null && sortByParam.equals("price-asc") ? "selected" : "" %>>Price, low to high</option>
                            <option value="price-desc" <%= sortByParam != null && sortByParam.equals("price-desc") ? "selected" : "" %>>Price, high to low</option>
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

                <%if(tagParam != null && tagParam.equals("best-sellers")){%>
                    <div class="container text-center">
                        <img src="all_component/img/best-seller.webp" alt="">
                    </div>
                <%}%>

                <div class="container">
                    <div class="row">
                        <% for (Book book : currentPageBooks) { %>
                        <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
                            <a href="product-detail.jsp?bookID=<%=book.getId()%>">
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
