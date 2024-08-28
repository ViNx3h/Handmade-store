<%-- 
    Document   : UpdateProduct
    Created on : Nov 5, 2023, 5:29:06 PM
    Author     : Admin
--%>

<%@page import="Model.type"%>
<%@page import="Model.product"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.TypeDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Product</title>
        <link rel="icon" href="<%= request.getContextPath()%>/imgs/favicon-32x32.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!-- Add css -->
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/home_product.css">
        <style>
            input {
                width: 100%;
            }
            textarea {
                width: 100%;
            }
            select {
                width: 100%;
            }
        </style>
    </head>
    <body>
        <%
            Cookie[] cList = null;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                boolean flagCustomer = false;
                boolean flagAdmin = false;
                String value = "";
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("customer")) {//nguoi dung da dang nhap
                        flagCustomer = true;
                        break; //thoat khoi vong lap
                    } else if (cList[i].getName().equals("admin")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        flagAdmin = true;
                        break; //thoat khoi vong lap
                    }
                }
                if (flagCustomer) {
                    response.sendRedirect("/AnimeStore/Home");
                } else if (flagAdmin) {
        %>
        <header>
            <!-- Menu -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <img class="navbar-brand" id="logo" src="<%= request.getContextPath()%>/imgs/Logo.jpg" alt="Hame Logo">
                    <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link active" href="/AnimeStore/ListProduct">Product</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/AnimeStore/Type">Type</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">View Order</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/AnimeStore/ViewOrder_Date">Date</a></li>
                                    <li><a class="dropdown-item" href="/AnimeStore/ViewOrder_Month">Month</a></li>
                                    <li><a class="dropdown-item" href="/AnimeStore/ViewOrder_Year">Year</a></li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="">Hello, Admin <%= value%></a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/AnimeStore/AccountAdmin">My account</a></li>
                                    <li><a class="dropdown-item" href="/AnimeStore/SignOutAdmin">Sign out</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <main class="container" style="width: 60%;">
            <h1 class="text-center m-3">Update Product</h1>
            <%
                product pro = (product) session.getAttribute("pro");
            %>
            <form method="post" action="/AnimeStore/ListProduct" enctype="multipart/form-data">

                <strong>ID:</strong><br/>
                <input class="border bg-light text-secondary" type="text" name="txtID" value="<%= pro.getId()%>" readonly=""><br/><br/>

                <strong>Name:</strong><br/>
                <input id="name" type="text" name="txtName" value="<%= pro.getName()%>"><br/>
                <small id="nameCheck" class="text-danger"></small><br/>

                <strong>Quantity:</strong><br/>
                <input id="quan" type="number" name="txtQuan" min="1" value="<%= pro.getQuantity()%>"><br/>
                <small id="quanCheck" class="text-danger"></small><br/>

                <strong>Price:</strong><br/>
                <input id="price" type="number" name="txtPrice" min="1" value="<%= pro.getPrice()%>"><br/>
                <small id="priceCheck" class="text-danger"></small><br/>

                <strong>Picture:</strong>
                <div class="border border-1 border-dark">
                    <input id="picture" class="p-1" type="file" name="picture" accept="image/*">
                </div>
                <small id="pictureCheck" class="text-danger"></small><br/>

                <strong>Type:</strong><br/>
                <select name="type">
                    <%
                        TypeDAO tDAO = new TypeDAO();
                        type type = tDAO.getType(pro.getType_id());
                    %>

                    <option value="<%= type.getId()%>"><%= type.getName()%></option>

                    <%
                        ResultSet rs = tDAO.getAll_exist(type.getId());
                        while (rs.next()) {
                    %>
                    <option value="<%= rs.getInt("id")%>"><%= rs.getString("name")%></option>
                    <%
                        }
                    %>
                </select>
                <br/><br/>

                <strong>Description:</strong><br/>
                <textarea id="des" name="txtDes"><%= pro.getDescription()%></textarea><br/>
                <small id="desCheck" class="text-danger"></small><br/>

                <input class="btn btn-info text-light mt-1 mb-5" type="submit" value="Update" name="btnUpdateProduct">
            </form>
            <%
                String errorMessage = (String) request.getSession().getAttribute("errorMessage");
                if (errorMessage != null) {
            %>

            <div class="text-center">
                <p class="text-danger"><%= errorMessage%></p>
            </div>

            <%
                    request.getSession().removeAttribute("errorMessage");
                }
            %>
        </main>                        

        <script>
            $(document).ready(function () {

                // Validate Name
                $("#nameCheck").hide();
                $("#name").keyup(function () {
                    validateName();
                });
                function validateName() {
                    let nameValue = $("#name").val().trim();
                    if (nameValue == "") {
                        $("#nameCheck").html("Name must not be empty!");
                        $("#nameCheck").show();
                    } else if (nameValue.length < 3) {
                        $("#nameCheck").html("Name at least 3 letters!");
                        $("#nameCheck").show();
                    } else {
                        $("#nameCheck").hide();
                    }
                }

                // Validate Quantity
                $("#quanCheck").hide();
                let quanError = true;
                $("#quan").keyup(function () {
                    validateQuan();
                });

                function validateQuan() {
                    let quanValue = $("#quan").val();
                    if (quanValue == "") {
                        $("#quanCheck").html("Quantity must not be empty!");
                        $("#quanCheck").show();
                        quanError = false;
                        return false;
                    } else if (quanValue <= 0) {
                        $("#quanCheck").html("Quantity must be greater than 0!");
                        $("#quanCheck").show();
                        quanError = false;
                        return false;
                    } else {
                        $("#quanCheck").hide();
                    }
                }

                // Validate Price
                $("#priceCheck").hide();
                let priceError = true;
                $("#price").keyup(function () {
                    validatePrice();
                });

                function validatePrice() {
                    let priceValue = $("#price").val();
                    if (priceValue == "") {
                        $("#priceCheck").html("Price must not be empty!");
                        $("#priceCheck").show();
                        priceError = false;
                        return false;
                    } else if (priceValue <= 0) {
                        $("#priceCheck").html("Price must be greater than 0!");
                        $("#priceCheck").show();
                        priceError = false;
                        return false;
                    } else {
                        $("#priceCheck").hide();
                    }
                }

                // Validate Address
                $("#desCheck").hide();
                $("#des").keyup(function () {
                    validateAdress();
                });
                function validateAdress() {
                    let desValue = $("#des").val().trim();
                    if (desValue == "") {
                    $("#desCheck").html("Description must not be empty!");
                            $("#desCheck").show();
                    } else if (desValue.length < 5) {
                    $("#desCheck").html("Description at least 5 letters!");
                    $("#desCheck").show();
                    }
                    else {
                    $("#desCheck").hide();
                    }
                }

            });
        </script>

        <script src="
                https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous">
        </script>
        <%
                } else {
                    response.sendRedirect("/index.jsp");
                }
            } else {
                response.sendRedirect("/index.jsp");
            }
        %>                        
    </body>
</html>
