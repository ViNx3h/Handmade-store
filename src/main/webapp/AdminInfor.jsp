<%-- 
    Document   : AdminInfor
    Created on : Nov 7, 2023, 1:07:26 PM
    Author     : Admin
--%>

<%@page import="Model.administrator"%>
<%@page import="DAOs.AdminDAO"%>
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

        <%
            AdminDAO aDAO = new AdminDAO();
            administrator admin = aDAO.getAdmin(value);
        %>
        <main class="container row" style="margin: 0 auto">
            <div class="container col-md-7 mb-5">
                <h1 class="text-center mt-5 mb-5">ACCOUNT INFORMATION</h1>
                <form method="post" action="/AnimeStore/AccountAdmin">
                    <!--Enter the username-->
                    Username: <br/>
                    <input class="border bg-light text-secondary rounded p-1 mb-2" type="text" value="<%= admin.getUsername()%>" name="txtUS" readonly="" style="width: 100%;">
                    <br/><br/>

                    Full Name: <br/>
                    <input id="fullname" class="border border-dark rounded p-1 mb-2" type="text" name="txtName" value="<%= admin.getFullname()%>" style="width: 100%;" placeholder="Nguyen Van A">
                    <br/>
                    <small id="fullnameCheck" class="text-danger"></small>
                    <br/>

                    Gender: 
                    <input type="radio" value="Male" name="rdoGen" <%= admin.getGender().equals("Male") ? "checked" : ""%>> Male
                    <input type="radio" value="Female" name="rdoGen" <%= admin.getGender().equals("Female") ? "checked" : ""%>> Female
                    <br/><br/>

                    Birthday: <input id="birthday" type="date" name="txtBD" value="<%= admin.getBirthday()%>" style="width: 100%;">
                    <br/>
                    <small id="birthdayCheck" class="text-danger"></small>
                    <br/>

                    Phone Number: <br/>
                    <input id="phone" class="border border-dark rounded p-1 mb-2" type="tel" value="<%= admin.getPhone_number()%>" pattern="[0-9]{10}" name="phone" style="width: 100%;" placeholder="0123456789"><br/>
                    <small id="phoneCheck" class="text-danger"></small>
                    <br/>

                    Address: <br/>
                    <input id="address" class="border border-dark rounded p-1 mb-2" type="text" name="txtAddress" value="<%= admin.getAddress()%>" style="width: 100%;" placeholder="123 Nguyen Van Cu, Ninh Kieu district"><br/>
                    <small id="addressCheck" class="text-danger"></small>
                    <br/>

                    <!--Update button-->
                    <div class="text-center">
                        <input class="btn btn-dark text-center mt-2" type="submit" value="Save" name="btnUpdateAdmin"><br/>
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
                <form method="post" action="/AnimeStore/AccountAdmin">

                    <!--Enter the password-->
                    New Password : <br/>
                    <input class="border border-dark rounded p-1" type="password" name="txtPWD" style="width: 100%;">
                    <br/>

                    <%
                        String errorPass = (String) request.getSession().getAttribute("errorPass");
                        String samePass = (String) request.getSession().getAttribute("samePass");
                        if (errorPass != null) {
                    %>

                    <small class="text-danger"><%= errorPass%></small><br/>

                    <%
                        request.getSession().removeAttribute("errorPass");
                    } else if (samePass != null) {
                    %>

                    <small class="text-danger"><%= samePass%></small><br/>

                    <%
                            request.getSession().removeAttribute("samePass");
                        }
                    %>

                    <div class="text-center">
                        <input id="btnUpdatePassAdmin" class="btn btn-dark text-center mt-2" type="submit" value="Update" name="btnUpdatePassAdmin"><br/>
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
                    }
                    else {
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
                } else {
                    response.sendRedirect("/index.jsp");
                }
            } else {
                response.sendRedirect("/index.jsp");
            }
        %>
    </body>
</html>
