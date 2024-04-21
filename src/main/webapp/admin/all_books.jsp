<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Book</title>
    <%--    <%@include file="admin_components/head.jsp"%>--%>
    <%@include file="../all_component/all_css.jsp"%>
</head>
<body>
<%--<%@include file="admin_components/navbar.jsp"%>--%>

<div class="container py-5">
    <div class="row justify-content-center mb-3">
        <div class="col-md-12">
            <div class="card shadow-0 border rounded-3">
                <div class="card-body">
                    <div class="row g-0">
                        <div class="col-xl-3 col-md-4 d-flex justify-content-center">
                            <div class="bg-image hover-zoom ripple rounded ripple-surface me-md-3 mb-3 mb-md-0">
                                <img src="https://bootstrap-ecommerce.com/bootstrap5-ecommerce/images/items/9.webp" class="w-100" />
                                <a href="#!">
                                    <div class="hover-overlay">
                                        <div class="mask" style="background-color: rgba(253, 253, 253, 0.15);"></div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-5 col-sm-7">
                            <h5>Men's Denim Jeans Shorts</h5>
                            <div class="d-flex flex-row">
                                <div class="text-warning mb-1 me-2">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="far fa-star"></i>
                                    <i class="far fa-star"></i>
                                    <span class="ms-1">
                          3
                        </span>
                                </div>
                                <span class="text-muted">73 orders</span>
                            </div>

                            <p class="text mb-4 mb-md-0">
                                Re-engineered Digital Crown with hapti Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua tempor incididunt ut
                                labore et dolore magna [...]
                            </p>
                        </div>
                        <div class="col-xl-3 col-md-3 col-sm-5">
                            <div class="d-flex flex-row align-items-center mb-1">
                                <h4 class="mb-1 me-1">$34,50</h4>
                                <span class="text-danger"><s>$49.99</s></span>
                            </div>
                            <h6 class="text-warning">Paid shipping</h6>
                            <div class="mt-4">
                                <button class="btn btn-primary shadow-0" type="button">Buy this</button>
                                <a href="#!" class="btn btn-light border px-2 pt-2 icon-hover"><i class="fas fa-heart fa-lg px-1"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--<%@include file="admin_components/footer.jsp"%>--%>
</body>
</html>