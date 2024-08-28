<%-- 
    Document   : Home
    Created on : Mar 17, 2024, 3:23:00 PM
    Author     : tiend
--%>

<%@page import="DAOs.ShoppingCartDAO"%>
<%@page import="Model.product"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Model.customer"%>
<%@page import="DAOs.CustomerDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.TypeDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="icon" href="<%= request.getContextPath()%>/imgs/favicon-32x32.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!-- Add css -->
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/home_product.css">
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
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break; //thoat khoi vong lap
                    } else if (cList[i].getName().equals("admin")) {//nguoi dung da dang nhap
                        flagAdmin = true;
                        break; //thoat khoi vong lap
                    }
                }
                if (flagCustomer) {
        %>
        <header>
            <!-- Menu -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <a href="/AnimeStore/Home" class="navbar-brand"><img id="logo" src="<%= request.getContextPath()%>/imgs/Logo.jpg" alt="Hame Logo"></a>
                    <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                        <ul class="navbar-nav">

                            <li class="nav-item">
                                <a class="nav-link active" href="/AnimeStore/Home">Home</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Product</a>
                                <ul class="dropdown-menu">
                                    <%
                                        TypeDAO tDAO = new TypeDAO();
                                        ResultSet rs = tDAO.getAll();
                                        while (rs.next()) {
                                    %>
                                    <li><a class="dropdown-item " href="/AnimeStore/Product/<%= rs.getInt("id")%>"><%= rs.getString("name")%></a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </li>

                        </ul>
                        <ul class="navbar-nav" id="Cart">
                            <li class="nav-item" >
                                <%
                                    ShoppingCartDAO scDAO = new ShoppingCartDAO();
                                %>
                                <a class="nav-link" href="/AnimeStore/ShoppingCart"><img class="navbar-brand" id="logoOrder" src="<%= request.getContextPath()%>/imgs/cart.png" alt="Logo Order"> (<%= scDAO.getQuantityOrder(value)%>)</a>
                            </li>
                            <li class="nav-item dropdown">
                                <%
                                    CustomerDAO cDAO = new CustomerDAO();
                                    customer cus = cDAO.getCustomer(value);
                                %>
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" >Welcome, <%= cus.getFullname()%></a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/AnimeStore/MyAccount">My Account</a></li>
                                    <li><a class="dropdown-item" href="/AnimeStore/ViewOrder">View Order History</a></li>
                                    <li><a class="dropdown-item" href="/AnimeStore/SignOutCustomer">Sign out</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Slide -->
            <div class="container-fluid">
                <div id="myCorousel" class="carousel slide" data-bs-ride="carousel">

                    <!-- Indicators/dots -->
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#myCorousel" data-bs-slide-to="0" class="active"></button>
                        <button type="button" data-bs-target="#myCorousel" data-bs-slide-to="1"></button>
                    </div>

                    <!-- The slideshow/carousel -->
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="<%= request.getContextPath()%>/imgs/present1.jpg" class="d-block" id="slide" alt="Slide 1">
                        </div>
                        <div class="carousel-item " >
                            <img src="<%= request.getContextPath()%>/imgs/present2.jpg" class="d-block" id="slide" alt="Slide 2" style="height: 675px">
                        </div>
                    </div>

                    <!-- Left and right controls/icons -->
                    <a class="carousel-control-prev" href="#myCorousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                    </a>
                    <a class="carousel-control-next" href="#myCorousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon"></span>
                    </a>
                </div>
            </div>
        </header>

        <main>
            <div class="container mt-5">
                <hr>
                <%
                    ProductDAO pDAO = new ProductDAO();
                    rs = tDAO.getAll();
                    while (rs.next()) {
                        ResultSet rs2 = pDAO.getTop4(rs.getInt("id"));
                %>
                <h1 class="text-center"><%= rs.getString("name")%></h1>
                <div class="row" id="card-wool">
                    <%
                        while (rs2.next()) {
                    %>
                    <div class="col-sm-6 col-md-3">
                        <div class="card p-1">
                            <img class="card-img-top" src="<%= request.getContextPath()%>/imgs/<%= rs2.getString("picture")%>" alt="Card image">
                            <div class="card-body text-center">
                                <h4 class="card-title"><%= rs2.getString("name")%></h4>
                                <div class="card-text">
                                    <small class="mt-3"><em><%= rs2.getString("description")%></em></small><br/>
                                    <small>Quantity: <%= rs2.getInt("quantity")%></small>
                                    <h5><strong><%= rs2.getLong("price")%>$</strong></h5>
                                </div>
                                <a href="/AnimeStore/AddCart/<%= rs2.getInt("id")%>" class="btn">Add Cart</a>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <div class="text-center m-5">
                    <a href="/AnimeStore/Product/<%= rs.getInt("id")%>" class="btn" id="look-all">All items</a>
                </div>
                <hr>
                <%
                    }
                %>
            </div>
        </main>

        <script src="
                https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous">
        </script>
        <%
                } else if (flagAdmin) {
                    response.sendRedirect("/AnimeStore/ListProduct");
                } else {
                    response.sendRedirect("/index.jsp");
                }
            } else {
                response.sendRedirect("/index.jsp");
            }
        %>
    </body>
</html>
