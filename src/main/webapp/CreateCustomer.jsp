<%-- 
    Document   : CreateCustomer
    Created on : Nov 4, 2023, 9:07:49 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Account</title>
        <link rel="icon" href="./images/favicon-32x32.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <%
            Cookie[] cList = null;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                boolean flagCustomer = false;
                boolean flagAdmin = false;
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("customer")) {//nguoi dung da dang nhap
                        flagCustomer = true;
                        break; //thoat khoi vong lap
                    } else if (cList[i].getName().equals("admin")) {//nguoi dung da dang nhap
                        flagAdmin = true;
                        break; //thoat khoi vong lap
                    }
                }
                if (flagCustomer) {
                    response.sendRedirect("/AnimeStore/Home");
                } else if (flagAdmin) {
                    response.sendRedirect("/AnimeStore/ListProduct");
                }
            }
        %>
        <div class="p-4 rounded center" style="width: 400px; box-shadow: 0 5px 30px 10px rgba(0, 0, 0, 0.4); margin: 30px auto;">
            <h1 class="text-center">CREATE NEW ACCOUNT</h1>
            <form method="post" action="">
                <!--Enter the username-->
                Username: <br/>
                <input id="username" class="border border-dark rounded p-1 mb-2" type="text" name="txtUS" style="width: 100%;">
                <br/>
                <small id="usernameCheck" class="text-danger"></small>
                <br/>

                <!--Enter the password-->
                Password : <br/>
                <input id="password" class="border border-dark rounded p-1" type="password" name="txtPWD" style="width: 100%;"><br/>
                <small id="passwordCheck" class="text-danger"></small>
                <br/>

                Full Name: <br/>
                <input id="fullname" class="border border-dark rounded p-1 mb-2" type="text" name="txtName" style="width: 100%;"><br/>
                <small id="fullnameCheck" class="text-danger"></small>
                <br/>

                Gender: 
                <input type="radio" value="Male" name="rdoGen"> Male
                <input type="radio" value="Female" name="rdoGen"> Female<br/>
                <%
                    String genderMessage = (String) request.getSession().getAttribute("genderMessage");
                    if (genderMessage != null) {
                %>

                <small class="text-danger"><%= genderMessage%></small>

                <%
                        request.getSession().removeAttribute("genderMessage");
                    }
                %>
                <br/>

                Birthday: <br/>
                <input id="birthday" class="border border-dark rounded p-1 mb-2" type="date" name="txtBD" style="width: 100%"><br/>
                <%
                    String birthdayMessage = (String) request.getSession().getAttribute("birthdayMessage");
                    if (birthdayMessage != null) {
                %>

                <small class="text-danger"><%= birthdayMessage%></small>

                <%
                        request.getSession().removeAttribute("birthdayMessage");
                    }
                %>
                <br/>

                Phone Number: <br/>
                <input id="phone" class="border border-dark rounded p-1 mb-2" type="tel" pattern="[0-9]{10}" name="phone" style="width: 100%;"><br/>
                <small id="phoneCheck" class="text-danger"></small>
                <br/>

                Address: <br/>
                <input id="address" class="border border-dark rounded p-1 mb-2" type="text" name="txtAddress" style="width: 100%;"><br/>
                <small id="addressCheck" class="text-danger"></small>
                <br/>

                <!--Create button-->
                <div class="d-grid">
                    <input id="btnCreate" class="btn btn-warning text-light text-center mt-2" type="submit" value="Create" name="btnCreate"><br/>
                </div>
            </form>

            <%
                String errorMessage = (String) request.getSession().getAttribute("errorMessage");
                String checkMessage = (String) request.getSession().getAttribute("checkMessage");
                String successMessage = (String) request.getSession().getAttribute("successMessage");
                if (errorMessage != null) {
            %>

            <div class="text-center">
                <p class="text-danger"><%= errorMessage%></p>
            </div>

            <%
                request.getSession().removeAttribute("errorMessage");
            } else if (checkMessage != null) {
            %>

            <div class="text-center">
                <p class="text-danger"><%= checkMessage%></p>
            </div>

            <%
                request.getSession().removeAttribute("checkMessage");
            } else if (successMessage != null) {
            %>

            <div class="text-center">
                <p class="text-success"><%= successMessage%></p>
            </div>

            <%
                    request.getSession().removeAttribute("successMessage");
                }
            %>

            <hr/>

            <div class="text-center">
                <a class="btn btn-light" href="/AnimeStore/LoginCustomer">Back</a>
            </div>
        </div>
        <script>
            $(document).ready(function () {

                // Validate Username
                $("#usernameCheck").hide();
                $("#username").keyup(function () {
                    validateUsername();
                });
                function validateUsername() {
                    let usernameValue = $("#username").val().trim();
                    if (usernameValue == "") {
                        $("#usernameCheck").html("Username must not be empty!");
                        $("#usernameCheck").show();
                    } else if (usernameValue.length < 3) {
                        $("#usernameCheck").html("Username at least 3 letters!");
                        $("#usernameCheck").show();
                    } else {
                        $("#usernameCheck").hide();
                    }
                }

                // Validate Password
                $("#passwordCheck").hide();
                $("#password").keyup(function () {
                    validatePassword();
                });
                function validatePassword() {
                    let passwordValue = $("#password").val().trim();
                    if (passwordValue == "") {
                        $("#passwordCheck").html("Password must not be empty!");
                        $("#passwordCheck").show();
                    } else if (password.length < 3) {
                        $("#passwordCheck").html("Password at least 3 letters!");
                        $("#passwordCheck").show();
                    } else {
                        $("#passwordCheck").hide();
                    }
                }

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

            });
        </script>

        <script src="
                https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous">
        </script>
    </body>
</html>
