<%--Bootstrap 5--%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<%--font-awesome--%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<%--style.css--%>
<link rel="stylesheet" href="all_component/style.css">

<script>
    function sortBooks(select) {
        var sortBy = select.value;
        var urlParams = new URLSearchParams(window.location.search);
        urlParams.set('sort_by', sortBy);
        window.location.href = window.location.pathname + '?' + urlParams.toString();
    }
    function updateCategory(category) {
        var urlParams = new URLSearchParams(window.location.search);
        urlParams.set('category', category);
        window.location.href = window.location.pathname + '?' + urlParams.toString();
    }
    function clearCategory() {
        var urlParams = new URLSearchParams(window.location.search);
        urlParams.delete('category');
        window.location.href = window.location.pathname + '?' + urlParams.toString();
    }
</script>