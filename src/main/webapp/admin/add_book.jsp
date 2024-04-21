<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Book</title>
    <%@include file="head.jsp"%>
    <%@include file="all_css.jsp"%>
</head>
<body>
<%--<%@include file="admin_components/navbar.jsp"%>--%>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h4>Add Book</h4>
                </div>
                <c:if test="${not empty successMsg}">
                    <p class="text-success text-center">${successMsg}</p>
                    <c:remove var="successMsg"  scope="session"></c:remove>
                </c:if>

                <c:if test="${not empty failedMsg}">
                    <p class="text-danger text-center">${failedMsg}</p>
                    <c:remove var="failedMsg" scope="session"></c:remove>
                </c:if>
                <div class="card-body">
                    <form action="../add_book" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="name" class="form-label">Book Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="author" class="form-label">Author</label>
                            <input type="text" class="form-control" id="author" name="author" required>
                        </div>
                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="number" class="form-control" id="price" name="price" step="0.01" required>
                        </div>
                        <div class="mb-3">
                            <label for="category" class="form-label">Category</label>
                            <select class="form-select" id="category" name="category" required>
                                <option value="" disabled selected>Select Category</option>
                                <option value="Comics & Manga">Comics & Manga</option>
                                <option value="Anime & Characters">Anime & Characters</option>
                                <option value="Photography">Photography</option>
                                <option value="Learn Japanese">Learn Japanese</option>
                                <option value="Art & Design">Art & Design</option>
                                <option value="Dictionary">Dictionary</option>
                                <option value="Music & Musical Score">Music & Musical Score</option>
                                <option value="DVD & Blu-ray">DVD & Blu-ray</option>
                                <option value="CDs & Vinyl">CDs & Vinyl</option>
                                <option value="Self-Help & Hobbies">Self-Help & Hobbies</option>
                                <!-- Add more category options as needed -->
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="page" class="form-label">Number of Pages</label>
                            <input type="number" class="form-control" id="page" name="page" required>
                        </div>
                        <div class="mb-3">
                            <label for="deepth" class="form-label">Book Depth (cm)</label>
                            <input type="number" class="form-control" id="deepth" name="deepth" step="0.01" required>
                        </div>
                        <div class="mb-3">
                            <label for="height" class="form-label">Book Height (cm)</label>
                            <input type="number" class="form-control" id="height" name="height" step="0.01" required>
                        </div>
                        <div class="mb-3">
                            <label for="width" class="form-label">Book Width (cm)</label>
                            <input type="number" class="form-control" id="width" name="width" step="0.01" required>
                        </div>
                        <div class="mb-3">
                            <label for="bookImage" class="form-label">Book Cover Image</label>
                            <input type="file" class="form-control" id="bookImage" name="bookImage" accept="image/*" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Add Book</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%--<%@include file="admin_components/footer.jsp"%>--%>
</body>
</html>