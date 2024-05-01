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
</header>
<!--Main Navigation-->

<%
    BookDAOIplm bookDAO = new BookDAOIplm(DBConnect.getConnection());
    List<Book> cartBooks = new ArrayList<>();
    double totalPrice = 0, tax = 0, shippingCost = 0, grandTotal = 0;

    if(user != null){
        List<Integer> bookIDs = cartDAO.getBookIDs(user.getId());
        for(int bookID : bookIDs){
            cartBooks.add(bookDAO.getBookByID(bookID));
            totalPrice += bookDAO.getBookByID(bookID).getPrice() * cartDAO.getBookQtyInCart(user.getId(), bookID);
        }
        shippingCost = bookIDs.size() * 1.5;
        tax = totalPrice * 0.1;
        grandTotal = totalPrice + shippingCost +tax;
    }
%>

<section class="bg-light py-5">
    <div class="container" style="min-height: 40vh">
        <%if(user == null){%>
        <div class="card mb-4 border shadow-0">
            <div class="p-4 d-flex justify-content-between">
                <div class="">
                    <h5>Have an account?</h5>
                    <p class="mb-0 text-wrap ">Sign in or Register an new account to explore our book world !</p>
                </div>
                <div class="d-flex align-items-center justify-content-center flex-column flex-md-row">
                    <a href="#" class="btn btn-outline-primary me-0 me-md-2 mb-2 mb-md-0 w-100">Register</a>
                    <a href="#" class="btn btn-primary shadow-0 text-nowrap w-100">Sign in</a>
                </div>
            </div>
        </div>
        <%} else{%>
        <div class="row">
            <div class="col-xl-8 col-lg-8 mb-4">
                <!-- Checkout -->
                <div class="card shadow-0 border">
                    <div class="p-4">
                        <h4 class="card-title mb-3 fw-bold"> <i class="fa-regular fa-credit-card mx-2"></i> Checkout Information</h4>
                        <div class="row">
                            <div class="col-12 mb-3">
                                <p class="mb-0">Your full name</p>
                                <div class="form-outline">
                                    <input type="text" id="typeText" placeholder="Enter your full name" class="form-control" value="<%=user.getName()%>"/>
                                </div>
                            </div>

                            <div class="col-6 mb-3">
                                <p class="mb-0">Phone</p>
                                <div class="form-outline">
                                    <input type="tel" id="typePhone" value="+84 " class="form-control" />
                                </div>
                            </div>

                            <div class="col-6 mb-3">
                                <p class="mb-0">Email</p>
                                <div class="form-outline">
                                    <input type="email" id="typeEmail" placeholder="example@gmail.com" class="form-control" value="<%=user.getEmail()%>"/>
                                </div>
                            </div>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" />
                            <label class="form-check-label" for="flexCheckDefault">Keep me up to date on news</label>
                        </div>

                        <hr class="my-4" />

                        <h5 class="card-title mb-3">Shipping info</h5>

                        <div class="row mb-3">
                            <div class="col-lg-4 mb-3">
                                <!-- Default checked radio -->
                                <div class="form-check h-100 border rounded-3">
                                    <div class="p-3">
                                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" checked />
                                        <label class="form-check-label" for="flexRadioDefault1">
                                            Express delivery <br />
                                            <small class="text-muted">3-4 days via Fedex </small>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 mb-3">
                                <!-- Default radio -->
                                <div class="form-check h-100 border rounded-3">
                                    <div class="p-3">
                                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" />
                                        <label class="form-check-label" for="flexRadioDefault2">
                                            Post office <br />
                                            <small class="text-muted">20-30 days via post </small>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 mb-3">
                                <!-- Default radio -->
                                <div class="form-check h-100 border rounded-3">
                                    <div class="p-3">
                                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault3" />
                                        <label class="form-check-label" for="flexRadioDefault3">
                                            Self pick-up <br />
                                            <small class="text-muted">Come to our shop </small>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-8 mb-3">
                                <p class="mb-0">Address</p>
                                <div class="form-outline">
                                    <input type="text" id="typeText" placeholder="Type here" class="form-control" />
                                </div>
                            </div>

                            <div class="col-sm-4 mb-3">
                                <p class="mb-0">City</p>
                                <select class="form-select">
                                    <option value="1">New York</option>
                                    <option value="2">Moscow</option>
                                    <option value="3">Samarqand</option>
                                </select>
                            </div>

                            <div class="col-sm-4 mb-3">
                                <p class="mb-0">House</p>
                                <div class="form-outline">
                                    <input type="text" id="typeText" placeholder="Type here" class="form-control" />
                                </div>
                            </div>

                            <div class="col-sm-4 col-6 mb-3">
                                <p class="mb-0">Postal code</p>
                                <div class="form-outline">
                                    <input type="text" id="typeText" class="form-control" />
                                </div>
                            </div>

                            <div class="col-sm-4 col-6 mb-3">
                                <p class="mb-0">Zip</p>
                                <div class="form-outline">
                                    <input type="text" id="typeText" class="form-control" />
                                </div>
                            </div>
                        </div>

                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault1" />
                            <label class="form-check-label" for="flexCheckDefault1">Save this address</label>
                        </div>

                        <div class="mb-3">
                            <p class="mb-0">Message to seller</p>
                            <div class="form-outline">
                                <textarea class="form-control" id="textAreaExample1" rows="2"></textarea>
                            </div>
                        </div>

                        <div class="float-end">
                            <button class="btn btn-light border">Cancel</button>
                            <button class="btn btn-success shadow-0 border">Continue</button>
                        </div>
                    </div>
                </div>
                <!-- Checkout -->
            </div>
            <div class="col-xl-4 col-lg-4 d-flex justify-content-center justify-content-lg-end">
                <div class="ms-lg-4 mt-4 mt-lg-0" style="max-width: 320px;">
                    <h5 class="mb-3 fw-bold">Summary</h5>
                    <div class="d-flex justify-content-between">
                        <p class="mb-2">Total price:</p>
                        <p class="mb-2">$<%=String.format("%.2f", totalPrice)%></p>
                    </div>
                    <div class="d-flex justify-content-between">
                        <p class="mb-2">Discount:</p>
                        <p class="mb-2 text-danger">- $0.00</p>
                    </div>
                    <div class="d-flex justify-content-between">
                        <p class="mb-2">Shipping cost:</p>
                        <p class="mb-2">+ $<%=String.format("%.2f", shippingCost)%></p>
                    </div>
                    <div class="d-flex justify-content-between">
                        <p class="mb-2">Tax:</p>
                        <p class="mb-2">+ $<%=String.format("%.2f", tax)%></p>
                    </div>
                    <hr />
                    <div class="d-flex justify-content-between">
                        <p class="mb-2">Grand price:</p>
                        <p class="mb-2 fw-bold">$<%=String.format("%.2f", grandTotal)%></p>
                    </div>

                    <div class="input-group mt-3 mb-4">
                        <input type="text" class="form-control border" name="" placeholder="Promo code" />
                        <button class="btn btn-light text-primary border">Apply</button>
                    </div>

                    <hr />
                    <h6 class="text-dark my-4">Items in cart</h6>

                    <%for(Book book : cartBooks){
                        String coverSrc = "book/" + book.getFileName();
                        double price = book.getPrice();
                        int quantity = cartDAO.getBookQtyInCart(user.getId(), book.getId());
                        double subtotal = price * quantity;
                    %>
                        <!-- Item in cart -->
                        <div class="row mb-4">
                            <div class="col-auto me-3 position-relative">
                                  <span class="position-absolute top-0 translate-middle badge rounded-pill badge-secondary bg-primary">
                                    <%=quantity%>
                                  </span>
                                <img src="<%= URLDecoder.decode(coverSrc, "UTF-8") %>" style="width: 90px" class="img-sm rounded border" />
                            </div>
                            <div class="col">
                                <a href="product-detail.jsp?bookID=<%=book.getId()%>" class="nav-link fw-bold py-2"><%=book.getName()%></a>
                                <div class="price text-muted">Total: $<%=String.format("%.2f", subtotal)%></div>
                            </div>
                        </div>
                        <!-- Item in cart -->
                    <%}%>
                </div>
            </div>
        </div>
        <%}%>
    </div>
</section>

<!-- Footer -->
<%@include file="all_component/footer.jsp"%>
<!-- Footer -->
</body>
</html>
