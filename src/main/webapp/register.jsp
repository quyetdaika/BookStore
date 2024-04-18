<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
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

<!-- Register form -->
<section class="vh-100" style="background-color: #eee;">
    <div class="container h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-lg-12 col-xl-11">
                <div class="card text-black" style="border-radius: 25px;">
                    <div class="card-body p-md-5">
                        <div class="row justify-content-center">
                            <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
                                <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Sign up</p>

                                <c:if test="${not empty successMsg}">
                                    <p class="text-success">${successMsg}</p>
                                    <c:remove var="successMsg" scope="session" />
                                </c:if>

                                <form action="register" method="post" class="mx-1 mx-md-4">
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                        <div data-mdb-input-init class="form-outline flex-fill mb-0">
                                            <input type="text" id="form3Example1c" class="form-control" name="fullName" required />
                                            <label class="form-label" for="form3Example1c">Your Name</label>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                        <div data-mdb-input-init class="form-outline flex-fill mb-0">
                                            <input type="email" id="form3Example3c" class="form-control" name="email" required />
                                            <label class="form-label" for="form3Example3c">Your Email</label>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                                        <div data-mdb-input-init class="form-outline flex-fill mb-0">
                                            <input type="password" id="password" class="form-control" name="password" required />
                                            <label class="form-label" for="form3Example4c">Password</label>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                                        <div data-mdb-input-init class="form-submit flex-fill mb-0">
                                            <input type="password" id="repeatPassword" class="form-control" required onchange="checkPassword()" />
                                            <label class="form-label" for="form3Example4cd">Repeat your password</label>
                                            <br>
                                            <label class="form-label text-danger" id="passwordErr"></label>
                                        </div>
                                    </div>

                                    <div class="form-check d-flex justify-content-center mb-5">
                                        <input class="form-check-input me-2" type="checkbox" value="" id="agreeCheckbox" name="agreeTerms" required />
                                        <label class="form-check-label" for="form2Example3">I agree to all statements in <a href="#!">Terms of service</a></label>
                                        <p id="notAgree" class="text-center text-danger d-none">Please agree to the terms of service.</p>
                                    </div>

                                    <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                        <button type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg" onclick="checkRegister()">Register</button>
                                    </div>
                                </form>
                            </div>
                            <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                                <img src="all_component/img/banner3.webp" class="img-fluid" alt="Sample image" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>



<!-- Register form -->

<!-- Footer -->
<%@include file="all_component/footer.jsp"%>
<!-- Footer -->

</body>

<script>
    function checkPassword(){
        password = document.getElementById("password").value;
        repeatPassword = document.getElementById("repeatPassword").value;
        if(password !== repeatPassword) {
            document.getElementById("passwordErr").innerHTML = "Repeat password not match !";
            return false;
        } else {
            document.getElementById("passwordErr").innerHTML = "";
            return true;
        }
    }

    function checkAgreement(){
        const agreeCheckbox = document.getElementById('agreeCheckbox');
        const notAgree = document.getElementById('notAgree');

        if (!agreeCheckbox.checked) {
            notAgree.classList.remove('d-none'); // Make the error message visible
            return false; // Prevent form submission
        } else {
            notAgree.classList.add('d-none'); // Hide the error message if checkbox is checked
            // Form submission can proceed
            return true;
        }
    }

    function checkRegister() {
        return checkPassword() && checkAgreement();
    }
</script>

</html>