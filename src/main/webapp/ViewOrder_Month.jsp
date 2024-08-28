<%-- 
    Document   : ViewOrder_Month
    Created on : Nov 7, 2023, 4:55:34 PM
    Author     : Admin
--%>

<%@page import="Model.customer"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Date"%>
<%@page import="DAOs.CustomerDAO"%>
<%@page import="DAOs.BillDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Order by Month</title>
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
                                <a class="nav-link" href="/AnimeStore/ListProduct">Product</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/AnimeStore/Type">Type</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">View Order</a>
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
            <form class="mt-5 mb-5" method="get" action="/AnimeStore/ViewOrder_Month">
                <div class="d-flex">
                    <div>
                        <p>Month:</p>
                    </div>
                    <div style="padding: 0 5px">
                        <input type="month" name="month" value="<%= request.getParameter("month")%>"><br/>
                        <small id="nameCheck" class="text-danger"></small>
                    </div>
                    <div class="mb-2">
                        <input class="btn btn-light" type="submit" name="btnViewOrder_Month" value="View Order" style=" margin: 0 5px; padding: 2px; width: 100px">
                    </div>
                    <%
                        String errorMessage = (String) request.getSession().getAttribute("errorMessage");
                        if (errorMessage != null) {
                    %>

                    <p class="text-danger"><%= errorMessage%></p>

                    <%
                            request.getSession().removeAttribute("errorMessage");
                        }
                    %>
                </div>
            </form>
            <%
                if (request.getParameter("btnViewOrder_Month") != null) {
                    BillDAO bDAO = new BillDAO();
                    CustomerDAO cDAO = new CustomerDAO();
                    long millis = System.currentTimeMillis();
                    // creating a new object of the class Date  
                    Date date = new Date(millis);
                    String month = "";
                    try {
                        month = request.getParameter("month");
                        date = Date.valueOf(request.getParameter("month") + "-01");
                    } catch (Exception e) {
                        request.getSession().setAttribute("errorMessage", "Please choose a month!");
                        response.sendRedirect("/AnimeStore/ViewOrder_Month");
                    }
            %>
            <h5>=> Total Income in <span class="text-danger" style="font-weight: bold"><%= month%> : <%= bDAO.total_income_a_month(date)%>$</span></h5>
            <table class="container table table-bordered">
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Customer</th>
                        <th>Total</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ResultSet rs = bDAO.getBill_byMonth(date);
                        while (rs.next()) {
                            customer cus = cDAO.getCustomer(rs.getString("cus_us"));
                    %>
                    <tr>
                        <td><%= rs.getInt("id")%></td>
                        <td><%= cus.getFullname()%></td>
                        <td><%= rs.getLong("total")%><strong>$</strong></td>
                        <td><%= rs.getDate("date")%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            %>
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
