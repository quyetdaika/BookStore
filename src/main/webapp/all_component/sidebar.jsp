<div class="col-lg-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="fw-bold">Category</h4>
        <button class="btn btn-outline-warning btn-sm" onclick="clearCategory()">Clear</button>
    </div>
    <div class="border-top py-2">
        <ul class="list-unstyled px-3">
            <%for(Map.Entry<String, String> entry : categoryMap.entrySet()) {%>
            <li class="my-2">
                <a href="javascript:void(0);" class="text-title icon-hover" onclick="updateCategory('<%=entry.getKey()%>')">
                    <%if(entry.getValue().equals(categoryMap.get(categoryParam))) {%>
                        <i class="fa-regular fa-circle-dot px-2"></i>
                    <%} else {%>
                        <i class="fa-regular fa-circle px-2"></i>
                    <%}%>
                    <%=entry.getValue()%>
                </a>
            </li>
            <%}%>
        </ul>
    </div>
</div>