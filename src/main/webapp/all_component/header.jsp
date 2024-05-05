<%@ page import="bookstore.entities.User" %>
<%@ page import="bookstore.subsystem.mysqlsubsystem.MySQLConnector" %>
<%@ page import="bookstore.subsystem.mysqlsubsystem.MySQLWishlistDAO" %>
<%@ page import="bookstore.subsystem.mysqlsubsystem.MySQLCartDAO" %>
<%@ page import="bookstore.subsystem.iface.IWishlistDAO" %>
<%@ page import="bookstore.subsystem.iface.ICartDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<%
    User user = (User)session.getAttribute("userObj");
    ICartDAO cartDAO = new MySQLCartDAO(MySQLConnector.getConnection());
    IWishlistDAO wishlistDAO = new MySQLWishlistDAO(MySQLConnector.getConnection());
    int wishlistQty = 0, cartQty = 0;
    if(user != null) {
        wishlistQty = wishlistDAO.getBookIDs(user.getId()).size();
        cartQty = cartDAO.getSumQuantity(user.getId());
    }
%>

<div class="container">
    <div class="row">
        <!-- Left element -->
        <div class="col-6">
            <a href="index.jsp">
                <img src="all_component/img/logo2%20no%20tran%20resize%20color.png" alt="" height="100">
            </a>
            <span class="small" style="font-family: 'Fira Code', monospace;">Contact with Quyet on</span>

            <a data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-sm ml-2" style="background-color: #3b5998;" href="https://www.facebook.com/nvq29Apr/" role="button" target="_blank">
                <i class="fab fa-facebook-f fa-fw"></i>
            </a>

            <a data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-sm" style="background-color: #333333;" href="https://github.com/nvq29Apr" role="button" target="_blame">
                <i class="fab fa-github fa-fw"></i>
            </a>

            <a data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-sm" style="background-color: #481449;" href="https://app.slack.com/client/T02QFU9TCTD/D05JL21JNT0" role="button" target="_blank">
                <i class="fab fa-slack-hash fa-fw"></i>
            </a>

        </div>

        <!-- Left element -->

        <!-- Right element -->
        <div class="col-6">
            <div class="container align-items-center flex-column">
                <%if(user != null){%>
                <!-- User & Log out -->
                    <div class="row d-flex justify-content-center m-2">
                        <span class="text-center">
                            <i class="fa-regular fa-user fs-6"></i>
                            <span class="fw-bold fs-6"><%=user.getEmail()%></span>
                            <span class="mx-2"><a href="logout" class="text-custom fs-6">Sign out</a></span>
                        </span>
                    </div>
                <!-- User & Log out -->
                <%} else {%>
                <!-- Sign in & sign up -->
                    <div class="row d-flex justify-content-center m-2">
                        <span class="text-center">
                            <a href="login.jsp" class="text-custom fs-6">Sign in</a>
                            <span>or</span>
                            <a href="register.jsp" class="text-custom fs-6">Create an Account</a>
                        </span>
                    </div>
                    <!-- Sign in & sign up -->
                <%}%>

                <!-- Search, wishlist, cart -->
                <div class="row text-center">
                    <div class="col-9 bg-custom py-3">
                        <form action="search-results.jsp" class="input-group" id="searchForm">
                            <input type="search" class="bg-custom text-white flex-grow-1 border-0 align-items-center flex-column" id="searchInput" placeholder="Search all products...">
                            <input type="hidden" name="q" id="searchQuery">
                            <button type="submit" class="bg-custom border-0 d-flex justify-content-center align-items-center flex-column"><i class="fa-solid fa-magnifying-glass text-white "></i></button>
                        </form>
                    </div>
                    <a href="wishlist.jsp" class="col text-white bg-custom mx-1 d-flex justify-content-center align-items-center flex-column position-relative">
                        <i class="fa-regular fa-heart fa-xl"></i>
                        <span id="wishlistQty" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"><%=wishlistQty != 0 ? wishlistQty : ""%></span>
                    </a>
                    <a href="cart.jsp" class="col text-white bg-custom d-flex justify-content-center align-items-center flex-row position-relative">
                        <i class="fa-brands fa-opencart mx-2"></i>
                        CART
                        <span id="cartQty" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"><%=cartQty != 0 ? cartQty : ""%></span>
                    </a>
                </div>
                <!-- Search, wishlist, cart -->
            </div>
        </div>
        <!-- Right element -->
    </div>
</div>

<script>
    // Lắng nghe sự kiện submit của form
    document.getElementById('searchForm').addEventListener('submit', function(event) {
        // Ngăn chặn hành vi mặc định của form
        event.preventDefault();

        // Lấy giá trị nhập từ ô tìm kiếm
        var searchValue = document.getElementById('searchInput').value;

        // Gán giá trị nhập vào input ẩn
        document.getElementById('searchQuery').value = searchValue;

        // Gửi form
        this.submit();
    });
</script>
