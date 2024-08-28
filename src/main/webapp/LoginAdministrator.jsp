<%-- 
    Document   : LoginAdministrator
    Created on : Nov 3, 2023, 5:41:27 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login for Administrator</title>
        <link rel="icon" href="<%= request.getContextPath()%>/imgs/favicon-32x32.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body class="container-fluid" style="padding: 7% 0;">
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
        
        <div class="p-4 rounded center" style="width: 400px; box-shadow: 0 5px 30px 10px rgba(0, 0, 0, 0.4); margin: auto;">
            <h1 class="text-center">SIGN IN</h1>
            <form method="post" action="/AnimeStore/ListProduct">
                <!--Enter the username-->
                Username: <br/>
                <input id="username" class="border border-dark rounded p-1 mb-2" type="text" name="txtUSad" style="width: 100%;"><br/>
                <small id="usercheck" class="text-danger"></small>
                <br/>
                <!--Enter the password-->
                Password : <br/>
                <input id="password" class="border border-dark rounded p-1" type="password" name="txtPWDad" style="width: 100%;"><br/>
                <small id="passwordCheck" class="text-danger"></small>
                <br/>
                <!--Login button-->
                <div class="d-grid">
                    <input id="btnLoginAdmin" class="btn btn-warning mt-4 text-center text-light" type="submit" value="Login" name="btnLoginAdmin"><br/>
                </div>
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
            
            <hr style="margin-top: 0">
            
            <div class="text-center">
                <a class="btn btn-light" href="/index.jsp">Back</a>
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
                }
                else {
                $("#passwordCheck").hide();
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
