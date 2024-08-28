<%-- 
    Document   : index
    Created on : Nov 3, 2023, 5:40:44 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Handmade Store</title>
        <link rel="icon" href="<%= request.getContextPath()%>/imgs/favicon-32x32.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body class="container-fluid" style="padding: 15% 0;">
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
            <h1 class="text-center mb-4">Choose Your Role:</h1>
                <a class="btn btn-warning text-light d-grid m-3" href="/AnimeStore/LoginCustomer">Customer</a>
                <a class="btn btn-warning text-light d-grid m-3" href="/AnimeStore/LoginAdministrator">Administrator</a>
        </div>

        <script src="
                https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous">
        </script>
    </body>
</html>
