<%-- 
    Document   : Product
    Created on : Nov 6, 2023, 8:38:53 AM
    Author     : Admin
--%>

<%@page import="DAOs.ShoppingCartDAO"%>
<%@page import="Model.type"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.TypeDAO"%>
<%@page import="Model.customer"%>
<%@page import="DAOs.CustomerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Page</title>

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
                                <a class="nav-link" href="/AnimeStore/Home">Home</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Product</a>
                                <ul class="dropdown-menu">
                                    <%
                                        TypeDAO tDAO = new TypeDAO();
                                        ResultSet rs = tDAO.getAll();
                                        while (rs.next()) {
                                    %>
                                    <li><a class="dropdown-item" href="/AnimeStore/Product/<%= rs.getInt("id")%>"><%= rs.getString("name")%></a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <%
                                    ShoppingCartDAO scDAO = new ShoppingCartDAO();
                                %>
                                <a class="nav-link" href="/AnimeStore/ShoppingCart">Shopping Cart (<%= scDAO.getQuantityOrder(value)%>)</a>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <li class="nav-item dropdown">
                                <%
                                    CustomerDAO cDAO = new CustomerDAO();
                                    customer cus = cDAO.getCustomer(value);
                                %>
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Welcome, <%= cus.getFullname()%></a>
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
        </header>

        <main>
            <div class="container mt-5">
                <%
                    ProductDAO pDAO = new ProductDAO();
                    type type = (type) session.getAttribute("type");
                    ResultSet rs2 = pDAO.getAll(type.getId());
                %>
                <h1 class="text-center m-5"><%= type.getName()%></h1>
                <div class="row" id="card-wool">
                    <%
                        while (rs2.next()) {
                    %>
                    <div class="col-sm-6 col-md-3 mb-4">
                        <div class="card p-1">
                            <img class="card-img-top" src="<%= request.getContextPath()%>/imgs/<%= rs2.getString("picture")%>" alt="Card image">
                            <div class="card-body text-center">
                                <h4 class="card-title"><%= rs2.getString("name")%></h4>
                                <div class="card-text">
                                    <small class="mt-3"><em><%= rs2.getString("description")%></em></small><br/>
                                    <small>Quantity: <%= rs2.getInt("quantity")%></small>
                                    <h5><strong><%= rs2.getLong("price")%>$</strong></h5>
                                </div>
                                <%
                                    if (rs2.getInt("quantity") != 0) {
                                %>
                                <a href="/AnimeStore/AddCart/<%= rs2.getInt("id")%>" id="button" class="btn">Add Cart</a>
                                <%
                                    } else {
                                %>
                                <p class="bg-light rounded text-secondary p-2" style="width: 100px; margin: 0 auto">Sold Out</p>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
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
