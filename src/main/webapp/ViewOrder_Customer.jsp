<%-- 
    Document   : ViewOrder
    Created on : Nov 5, 2023, 5:27:53 PM
    Author     : Admin
--%>

<%@page import="Model.product"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.OrderDAO"%>
<%@page import="DAOs.BillDAO"%>
<%@page import="DAOs.TypeDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ShoppingCartDAO"%>
<%@page import="DAOs.CustomerDAO"%>
<%@page import="Model.customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Order</title><link rel="icon" href="<%= request.getContextPath()%>/imgs/favicon-32x32.jpg">
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
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Product</a>
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

        <main class="bg-light">
            <h1 class="text-center pb-5">Your Bill</h1>
            <%
                BillDAO bDAO = new BillDAO();
                OrderDAO oDAO = new OrderDAO();
                ProductDAO pDAO = new ProductDAO();
                ResultSet rsBill = bDAO.getBill(value);
                while (rsBill.next()) {
            %>
            <div class="container border border-3 border-success p-2 mb-5" style="">
                <div class="d-flex justify-content-between">
                    <p><strong>Bill: <%= rsBill.getInt("id")%></strong></p>
                    <p style="margin-bottom: 0"><em><%= rsBill.getDate("date")%></em></p>
                </div><hr style=""/>

                <%
                    ResultSet rsOrder = oDAO.getOrder(rsBill.getInt("id"));
                    while (rsOrder.next()) {
                        product pro = pDAO.getProduct(rsOrder.getInt("pro_id"));
                %>
                <div class="row p-2">
                    <div class="col-sm-2 col-lg-3">
                        <img src="<%= request.getContextPath()%>/imgs/<%= pro.getPicture()%>" style="width: 40%" alt="<%= pro.getName()%>"/>
                    </div>
                    <div class="col-sm-6 col-lg-6">
                        <h4><%= pro.getName()%></h4>
                        <p>x<%= rsOrder.getInt("quantity")%></p>
                    </div>
                    <div class="col-sm-4 col-lg-3">
                        <p class="d-flex justify-content-end"><strong><%= rsOrder.getLong("price")%>$</strong></p>
                    </div>
                </div><hr style=""/>
                <%
                    }
                %>

                <p class="d-flex justify-content-end" style="color: #dc3545; font-size: x-large"><strong>Total: <%= rsBill.getLong("total")%>$</strong></p>
            </div>
            <%
                }
            %>
        </main>                        

        <script src="
                https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous">
        </script>
        <%      } else if (flagAdmin) {
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
