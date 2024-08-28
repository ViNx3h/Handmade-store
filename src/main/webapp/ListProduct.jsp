<%-- 
    Document   : ListProduct
    Created on : Nov 4, 2023, 8:45:08 AM
    Author     : Admin
--%>

<%@page import="Model.type"%>
<%@page import="DAOs.TypeDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Model.administrator"%>
<%@page import="DAOs.AdminDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of Product</title>
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

        <main class="container">
            <h1 class="mt-5 mb-4">PRODUCTS</h1>
            <a class="btn btn-info text-light mb-3" href="/AnimeStore/AddNewProduct">Add New</a>
            <table class="container table table-bordered">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Picture</th>
                        <th>Description</th>
                        <th>Type</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ProductDAO pDAO = new ProductDAO();
                        TypeDAO tDAO = new TypeDAO();
                        ResultSet rs = pDAO.getAll();
                        while (rs.next()) {
                            type type = tDAO.getType(rs.getInt("type_id"));
                    %>
                    <tr>
                        <td><%= rs.getString("name")%></td>
                        <td><%= rs.getInt("quantity")%></td>
                        <td><%= rs.getLong("price")%><strong>$</strong></td>
                        <td><img src="<%= request.getContextPath()%>/imgs/<%= rs.getString("picture")%>" alt="<%= rs.getString("name")%>" width="100px"/></td>
                        <td><%= rs.getString("description")%></td>
                        <td><%= type.getName()%></td>
                        <td class="text-secondary">
                            <a class="text-danger" href="/AnimeStore/Update/<%=rs.getInt("id")%>">Update</a> | <a class="text-danger" onclick="return confirm('Do you want to delete \'<%= rs.getString("name")%>\' product?')" href="/AnimeStore/DeleteProduct/<%=rs.getInt("id")%>">Delete</a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </main>

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
