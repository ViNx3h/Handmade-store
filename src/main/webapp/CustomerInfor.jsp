<%-- 
    Document   : CustomerInfor
    Created on : Nov 5, 2023, 5:28:22 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.TypeDAO"%>
<%@page import="DAOs.ShoppingCartDAO"%>
<%@page import="Model.customer"%>
<%@page import="DAOs.CustomerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Account</title>
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
                                <a class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Welcome, <%= cus.getFullname()%></a>
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

        <main class="container row" style="margin: 0 auto">
            <div class="container col-md-7 mb-5">
                <h1 class="text-center mt-5 mb-5">ACCOUNT INFORMATION</h1>
                <form method="post" action="/AnimeStore/MyAccount">
                    <!--Enter the username-->
                    Username: <br/>
                    <input class="border bg-light text-secondary rounded p-1 mb-2" type="text" value="<%= cus.getUsername()%>" name="txtUS" readonly="" style="width: 100%;">
                    <br/><br/>

                    Full Name: <br/>
                    <input id="fullname" class="border border-dark rounded p-1 mb-2" type="text" name="txtName" value="<%= cus.getFullname()%>" style="width: 100%;" placeholder="Nguyen Van A">
                    <br/>
                    <small id="fullnameCheck" class="text-danger"></small>
                    <br/>

                    Gender: 
                    <input type="radio" value="Male" name="rdoGen" <%= cus.getGender().equals("Male") ? "checked" : ""%>> Male
                    <input type="radio" value="Female" name="rdoGen" <%= cus.getGender().equals("Female") ? "checked" : ""%>> Female
                    <br/><br/>

                    Birthday: <input id="birthday" type="date" name="txtBD" value="<%= cus.getBirthday()%>" style="width: 100%;">
                    <br/>
                    <small id="birthdayCheck" class="text-danger"></small>
                    <br/>

                    Phone Number: <br/>
                    <input id="phone" class="border border-dark rounded p-1 mb-2" type="tel" value="<%= cus.getPhone_number()%>" pattern="[0-9]{10}" name="phone" style="width: 100%;" placeholder="0123456789"><br/>
                    <small id="phoneCheck" class="text-danger"></small>
                    <br/>

                    Address: <br/>
                    <input id="address" class="border border-dark rounded p-1 mb-2" type="text" name="txtAddress" value="<%= cus.getAddress()%>" style="width: 100%;" placeholder="123 Nguyen Van Cu, Ninh Kieu district"><br/>
                    <small id="addressCheck" class="text-danger"></small>
                    <br/>

                    <!--Update button-->
                    <div class="text-center">
                        <input id="btnUpdateCustomer" class="btn btn-dark text-center mt-2" type="submit" value="Save" name="btnUpdateCustomer"><br/>
                    </div>                    
                </form>
                <%
                    String errorMessage = (String) request.getSession().getAttribute("errorMessage");
                    String successMessage = (String) request.getSession().getAttribute("successMessage");
                    if (errorMessage != null) {
                %>
                <div class="text-center">
                    <p class="text-danger"><%= errorMessage%></p>
                </div>
                <%
                    request.getSession().removeAttribute("errorMessage");
                } else if (successMessage != null) {
                %>
                <div class="text-center">
                    <p class="text-success"><%= successMessage%></p>
                </div>
                <%
                        request.getSession().removeAttribute("successMessage");
                    }
                %>
            </div>

            <div class="col-md-5">
                <h1 class="text-center mt-5 mb-5">UPDATE PASSWORD</h1>
                <form method="post" action="/AnimeStore/MyAccount">

                    <!--Enter the password-->
                    Old Password : 
                    <br/>
                    <input class="border border-dark rounded p-1" type="password" name="txtOldPWD" style="width: 100%;">
                    <br/>
                    <%
                        String nullPass = (String) request.getSession().getAttribute("nullPass");
                        String samePass = (String) request.getSession().getAttribute("samePass");
                        String passError = (String) request.getSession().getAttribute("passError");
                        String nullNewPass = (String) request.getSession().getAttribute("nullNewPass");
                        if (nullPass != null) {
                    %>

                    <small class="text-danger"><%= nullPass%></small><br/>

                    <%
                            request.getSession().removeAttribute("nullPass");
                        }
                    %>
                    <br/>
                    New Password : 
                    <br/>
                    <input class="border border-dark rounded p-1" type="password" name="txtNewPWD" style="width: 100%;">
                    <br/>
                    <%
                        if (samePass != null) {
                    %>
                    <small class="text-danger"><%= samePass%></small><br/>

                    <%
                        request.getSession().removeAttribute("samePass");
                    } else if (nullNewPass != null) {
                    %>
                    <small class="text-danger"><%= nullNewPass%></small><br/>
                    <%
                            request.getSession().removeAttribute("nullNewPass");
                        }
                    %>



                    <div class="text-center">
                        <%
                            if (passError != null) {
                        %>
                        <small class="text-danger"><%= passError%></small><br/>
                        <%
                                request.getSession().removeAttribute("passError");
                            }
                        %>
                        <input id="btnUpdatePassCustomer" class="btn btn-dark text-center mt-2" type="submit" value="Update" onclick="validatePassword()" name="btnUpdatePassCustomer"><br/>
                    </div>

                </form>

                <%
                    String successPass = (String) request.getSession().getAttribute("successPass");
                    if (successPass != null) {
                %>

                <div class="text-center">
                    <p class="text-success"><%= successPass%></p>
                </div>

                <%
                        request.getSession().removeAttribute("successPass");
                    }
                %>
            </div>
        </main>

        <script>
            $(document).ready(function () {

                // Validate Name
                $("#fullnameCheck").hide();
                $("#fullname").keyup(function () {
                    validateName();
                });
                function validateName() {
                    let nameValue = $("#fullname").val().trim();
                    if (nameValue == "") {
                        $("#fullnameCheck").html("Name must not be empty!");
                        $("#fullnameCheck").show();
                    } else if (nameValue.length < 3) {
                        $("#fullnameCheck").html("Name at least 3 letters!");
                        $("#fullnameCheck").show();
                    } else {
                        $("#fullnameCheck").hide();
                    }
                }

                // Validate Phone
                $("#phoneCheck").hide();
                $("#phone").keyup(function () {
                    validatePhone();
                });
                function validatePhone() {
                    let phoneValue = $("#phone").val().trim();
                    if (phoneValue == "") {
                        $("#phoneCheck").html("Phone Number must not be empty!");
                        $("#phoneCheck").show();
                    } else {
                        $("#phoneCheck").hide();
                    }
                }

                // Validate Address
                $("#addressCheck").hide();
                $("#address").keyup(function () {
                    validateAdress();
                });
                function validateAdress() {
                    let addressValue = $("#address").val().trim();
                    if (addressValue == "") {
                    $("#addressCheck").html("Adress must not be empty!");
                            $("#addressCheck").show();
                    } else if (addressValue.length < 5) {
                    $("#addressCheck").html("Adress at least 5 letters!");
                    $("#addressCheck").show();
                    }
                    else {
                    $("#addressCheck").hide();
                    }
                }

                // Validate Birthday
                $("#birthdayCheck").hide();
                $("#birthday").keyup(function () {
                    validateBirthday();
                });
                function validateBirthday() {
                    let birthdayValue = $("#birthday").val();
                    if (birthdayValue === "") {
                        $("#birthdayCheck").html("Birthday must not be empty!");
                        $("#birthdayCheck").show();
                    } else {
                        $("#birthdayCheck").hide();
                    }
                }

            });

        </script>
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
