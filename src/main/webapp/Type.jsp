<%-- 
    Document   : Type
    Created on : Nov 5, 2023, 5:31:56 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.TypeDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of Type</title>
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
                                <a class="nav-link active" href="/AnimeStore/Type">Type</a>
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
            <h1 class="mt-5 mb-4">TYPES</h1>
            <form class="mb-3" method="post" action="/AnimeStore/Type">
                <div class="d-flex">
                    <div>
                        <input id="name" type="text" name="txtName"><br/>
                        <small id="nameCheck" class="text-danger"></small>
                    </div>
                    <div class="mb-2">
                        <input class="btn btn-info text-light " type="submit" id="btnAddNewType" name="btnAddNewType" value="Add New" style=" margin: 0 5px; padding: 2px; width: 100px">
                    </div>
                </div>
            </form>
            <table class="container table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        TypeDAO tDAO = new TypeDAO();
                        ResultSet rs = tDAO.getAll();
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id")%></td>
                        <td><%= rs.getString("name")%></td>
                        <td class="text-secondary">
                            <a class="text-danger" onclick="return confirm('Do you want to delete \'<%= rs.getString("name")%>\' type?')" href="/AnimeStore/DeleteType/<%=rs.getInt("id")%>">Delete</a>
                        </td>
                    </tr>
                    <%
                        String error = (String) request.getSession().getAttribute("deleteError");
                        if (error == "false") {%>
                        
                <script type="text/javascript">
                    var Msg = '<%=session.getAttribute("deleteError")%>';
                    if (Msg == "false") {
                    function alertName(){
                    alert("You can not delete the type");
                    }
                    }
                </script>
                
                <script type="text/javascript"> window.onload = alertName;</script>
                <%
                            request.getSession().removeAttribute("deleteError");
                        }
                    }
                %>
                </tbody>
            </table>
        </main>     

        <script>
            $(document).ready(function () {

            // Validate Name
            $("#nameCheck").hide();
            let nameError = true;
            $("#name").keyup(function () {
            validateName();
            });
            function validateName() {
            let nameValue = $("#name").val().trim();
            if (nameValue == "") {
            $("#nameCheck").html("Name must not be empty!");
            $("#nameCheck").show();
            nameError = false;
            return false;
            } else if (nameValue.length < 3) {
            $("#nameCheck").html("Name at least 3 letters!");
            $("#nameCheck").show();
            nameError = false;
            return false;
            } else {
            nameError = true;
            $("#nameCheck").hide();
            }
            }

            // Add New button
            $("#btnAddNewType").click(function () {
            validateName();
            if (!nameError) {
            alert("Please fill in exactly as required!");
            }
            });
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
