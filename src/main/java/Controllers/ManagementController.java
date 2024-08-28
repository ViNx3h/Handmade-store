/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AdminDAO;
import DAOs.BillDAO;
import DAOs.CustomerDAO;
import DAOs.OrderDAO;
import DAOs.ProductDAO;
import DAOs.ShoppingCartDAO;
import DAOs.TypeDAO;
import Model.administrator;
import Model.bill;
import Model.customer;
import Model.order;
import Model.product;
import Model.shopping_cart;
import Model.type;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.ResultSet;

/**
 *
 * @author Admin
 */
@WebServlet("/Relay")
@MultipartConfig
public class ManagementController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagementController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagementController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI(); // Get the URL
        if (path.endsWith("/LoginCustomer")) { //Login for Customer
            request.getRequestDispatcher("/LoginCustomer.jsp").forward(request, response);
        } else if (path.endsWith("/LoginAdministrator")) { //Login for Admin
            request.getRequestDispatcher("/LoginAdministrator.jsp").forward(request, response);
        } else if (path.endsWith("/Home")) { //Home Page for Customer
            request.getRequestDispatcher("/Home.jsp").forward(request, response);
        } else if (path.endsWith("/ListProduct")) { //List product for Admin
            request.getRequestDispatcher("/ListProduct.jsp").forward(request, response);
        } else if (path.endsWith("/CreateCustomer")) { // Create new account for customer
            request.getRequestDispatcher("/CreateCustomer.jsp").forward(request, response);
        } else if (path.endsWith("/SignOutCustomer")) { // Sign out for Customer
            Cookie[] cList;
            cList = request.getCookies();
            for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                if (cList1.getName().equals("customer")) { //nguoi dung da dang nhap
                    cList1.setMaxAge(0);
                    response.addCookie(cList1);
                    break; //thoat khoi vong lap
                }
            }
            response.sendRedirect("/AnimeStore/LoginCustomer");
        } else if (path.endsWith("/SignOutAdmin")) { // Sign out for Admin
            Cookie[] cList;
            cList = request.getCookies();
            for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                if (cList1.getName().equals("admin")) { //nguoi dung da dang nhap
                    cList1.setMaxAge(0);
                    response.addCookie(cList1);
                    break; //thoat khoi vong lap
                }
            }
            response.sendRedirect("/AnimeStore/LoginAdministrator");
        } else if (path.startsWith("/AnimeStore/Product")) {
            String[] s = path.split("/");
            try {
                int type_id = Integer.parseInt(s[s.length - 1]);
                TypeDAO tDAO = new TypeDAO();
                type type = tDAO.getType(type_id);
                if (type == null) {
                    response.sendRedirect("/AnimeStore/Home");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("type", type);
                    request.getRequestDispatcher("/Product.jsp").forward(request, response);
                }
            } catch (Exception e) {
                response.sendRedirect("/AnimeStore/Home");
            }
        } else if (path.endsWith("/ShoppingCart")) {
            request.getRequestDispatcher("/ShoppingCart.jsp").forward(request, response);
        } else if (path.startsWith("/AnimeStore/AddCart")) {
            String[] s = path.split("/");
            try {
                int pro_id = Integer.parseInt(s[s.length - 1]);
                Cookie[] cList;
                cList = request.getCookies();
                String value = null;
                for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                    if (cList1.getName().equals("customer")) { //nguoi dung da dang nhap
                        value = cList1.getValue();
                        break; //thoat khoi vong lap
                    }
                }
                ShoppingCartDAO scDAO = new ShoppingCartDAO();
                boolean existProduct = scDAO.existProduct(value, pro_id);
                if (existProduct) {
                    scDAO.updateQuantity(value, pro_id);
                    response.sendRedirect("/AnimeStore/ShoppingCart");
                } else {
                    shopping_cart scNew = new shopping_cart(value, pro_id, 1, 0);
                    shopping_cart sc = scDAO.addNew(scNew);
                    if (sc == null) {
                        HttpSession session = request.getSession();
                        type type = (type) session.getAttribute("type");
                        response.sendRedirect("/AnimeStore/Product" + type.getId());
                    } else {
                        response.sendRedirect("/AnimeStore/ShoppingCart");
                    }
                }
            } catch (Exception e) {
                HttpSession session = request.getSession();
                type type = (type) session.getAttribute("type");
                response.sendRedirect("/AnimeStore/Product" + type.getId());
            }
        } else if (path.endsWith("/ViewOrder")) {
            request.getRequestDispatcher("/ViewOrder_Customer.jsp").forward(request, response);
        } else if (path.endsWith("/ViewOrder_Process")) {
            try {
                Cookie[] cList;
                cList = request.getCookies();
                String value = null;
                for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                    if (cList1.getName().equals("customer")) { //nguoi dung da dang nhap
                        value = cList1.getValue();
                        break; //thoat khoi vong lap
                    }
                }
                ShoppingCartDAO scDAO = new ShoppingCartDAO();
                BillDAO bDAO = new BillDAO();

                long millis = System.currentTimeMillis();
                // creating a new object of the class Date  
                Date date = new Date(millis);
                bill billNew = new bill(0, date, 0, value);
                bill bill = bDAO.addNew(billNew);
                if (bill == null) {
                    response.sendRedirect("/AnimeStore/ShoppingCart");
                } else {
                    int bill_id = bDAO.getID();
                    ProductDAO pDAO = new ProductDAO();
                    OrderDAO oDAO = new OrderDAO();
                    ResultSet rs = scDAO.getAll(value);
                    while (rs.next()) {
                        product pro = pDAO.getProduct(rs.getInt("pro_id"));
                        order orderNew = new order(bill_id, rs.getInt("pro_id"), rs.getInt("quantity"), rs.getLong("price"));
                        order order = oDAO.addNew(orderNew);
                        if (order == null) {
                            response.sendRedirect("/AnimeStore/ShoppingCart");
                        } else {
                            pDAO.updateQuantity(rs.getInt("pro_id"), pro.getQuantity() - rs.getInt("quantity"));
                        }
                    }
                    scDAO.delete(value);
                    response.sendRedirect("/AnimeStore/ViewOrder");
                }
            } catch (Exception e) {
            }
        } else if (path.endsWith("/AddNewProduct")) {
            request.getRequestDispatcher("/AddNewProduct.jsp").forward(request, response);
        } else if (path.endsWith("/Type")) {
            request.getRequestDispatcher("/Type.jsp").forward(request, response);
        } else if (path.startsWith("/AnimeStore/DeleteProduct/")) {
            String[] s = path.split("/");
            try {
                int id = Integer.parseInt(s[s.length - 1]);
                ProductDAO pDAO = new ProductDAO();
                pDAO.delete(id);
                response.sendRedirect("/AnimeStore/ListProduct");
            } catch (Exception e) {
                response.sendRedirect("/AnimeStore/ListProduct");
            }
        } else if (path.startsWith("/AnimeStore/DeleteType")) {
            String[] s = path.split("/");
            try {
                int id = Integer.parseInt(s[s.length - 1]);
                TypeDAO tDAO = new TypeDAO();
                boolean checkDelete = tDAO.delete(id);
                if (checkDelete) {
                    request.getSession().setAttribute("deleteError", "true");
                    response.sendRedirect("/AnimeStore/Type");
                } else {
                    request.getSession().setAttribute("deleteError", "false");
                    response.sendRedirect("/AnimeStore/Type");
                }
            } catch (Exception e) {
                response.sendRedirect("/AnimeStore/Type");
            }
        } else if (path.endsWith("/ViewOrder_Date")) {
            request.getRequestDispatcher("/ViewOrder_Date.jsp").forward(request, response);
        } else if (path.endsWith("/MyAccount")) {
            request.getRequestDispatcher("/CustomerInfor.jsp").forward(request, response);
        } else if (path.startsWith("/AnimeStore/DeleteShoppingCart")) {
            String[] s = path.split("/");
            try {
                String cus_us = s[s.length - 2];
                int pro_id = Integer.parseInt(s[s.length - 1]);
                ShoppingCartDAO scDAO = new ShoppingCartDAO();
                scDAO.deleteProduct(cus_us, pro_id);
                response.sendRedirect("/AnimeStore/ShoppingCart");
            } catch (Exception e) {
                response.sendRedirect("/AnimeStore/ShoppingCart");
            }
        } else if (path.endsWith("/ViewOrder_Month")) {
            request.getRequestDispatcher("/ViewOrder_Month.jsp").forward(request, response);
        } else if (path.endsWith("/ViewOrder_Year")) {
            request.getRequestDispatcher("/ViewOrder_Year.jsp").forward(request, response);
        } else if (path.endsWith("/AccountAdmin")) {
            request.getRequestDispatcher("/AdminInfor.jsp").forward(request, response);
        } else if (path.startsWith("/AnimeStore/Update")) {
            String[] s = path.split("/");
            try {
                int id = Integer.parseInt(s[s.length - 1]);
                ProductDAO pDAO = new ProductDAO();
                product pro = pDAO.getProduct(id);
                if (pro == null) {
                    response.sendRedirect("/AnimeStore/ListProduct");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("pro", pro);
                    request.getRequestDispatcher("/UpdateProduct.jsp").forward(request, response);
                }
            } catch (ServletException | IOException | NumberFormatException e) {
                response.sendRedirect("/AnimeStore/ListProduct");
            }
        } else if (path.startsWith("/AnimeStore/upQuantity")) {
            String[] s = path.split("/");
            try {
                int id = Integer.parseInt(s[s.length - 3]);
                int quantity = Integer.parseInt(s[s.length - 2]);
                int pro_quantity = Integer.parseInt(s[s.length - 1]);

                ShoppingCartDAO scDAO = new ShoppingCartDAO();
                boolean up = scDAO.upQuantity(id, quantity, pro_quantity);
                if (up) {
                    request.getRequestDispatcher("/ShoppingCart.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("upEror", "false");
                    request.getRequestDispatcher("/ShoppingCart.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
            }
        } else if (path.startsWith("/AnimeStore/downQuantity")) {
            String[] s = path.split("/");
            try {
                int id = Integer.parseInt(s[s.length - 2]);
                int quantity = Integer.parseInt(s[s.length - 1]);

                ShoppingCartDAO scDAO = new ShoppingCartDAO();
                boolean down = scDAO.downQuantity(id, quantity);
                if (down) {
                    request.getRequestDispatcher("/ShoppingCart.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("downError", "false");
                    request.getRequestDispatcher("/ShoppingCart.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //
        if (request.getParameter("btnLoginCustomer") != null) { //Nguoi dung da nhan nut submit
            CustomerDAO cDAO = new CustomerDAO();
            String us = request.getParameter("txtUScus");
            if (!cDAO.check_username(us)) {
                request.getSession().setAttribute("errorMessage", "Account does not exist!");
                response.sendRedirect("/AnimeStore/LoginCustomer");
            } else {
                String pwd = cDAO.getPwdMd5(request.getParameter("txtPWDcus"));
                if (!cDAO.check_password(us, pwd)) {
                    request.getSession().setAttribute("errorMessage", "Password is not correct!");
                    response.sendRedirect("/AnimeStore/LoginCustomer");
                } else {
                    Cookie c = new Cookie("customer", us);
                    c.setMaxAge(3 * 24 * 60 * 60); //Thiet lap han su dung 3 ngay
                    response.addCookie(c);//Day cookie xuong may duong dung (client)
                    response.sendRedirect("/AnimeStore/Home");
                }
            }
        }

        //
        if (request.getParameter("btnLoginAdmin") != null) { //Nguoi dung da nhan nut submit
            try {
                AdminDAO aDAO = new AdminDAO();
                String us = request.getParameter("txtUSad");
                if (!aDAO.check_username(us)) {
                    request.getSession().setAttribute("errorMessage", "Account does not exist!");
                    response.sendRedirect("/AnimeStore/LoginAdministrator");
                } else {
                    String pwd = aDAO.getPwdMd5(request.getParameter("txtPWDad"));
                    if (!aDAO.check_password(us, pwd)) {
                        request.getSession().setAttribute("errorMessage", "Password is not correct!");
                        response.sendRedirect("/AnimeStore/LoginAdministrator");
                    } else {
                        Cookie c = new Cookie("admin", us);
                        c.setMaxAge(3 * 24 * 60 * 60); //Thiet lap han su dung 3 ngay
                        response.addCookie(c);//Day cookie xuong may duong dung (client)
                        response.sendRedirect("/AnimeStore/ListProduct");
                    }
                }
            } catch (IOException e) {
                response.sendRedirect("/AnimeStore/LoginAdministrator");
            }
        }

        if (request.getParameter("btnCreate") != null) {
            CustomerDAO cDAO = new CustomerDAO();
            String username = request.getParameter("txtUS");
            String password = request.getParameter("txtPWD");
            String name = request.getParameter("txtName");
            String gender = request.getParameter("rdoGen");
            String date = request.getParameter("txtBD");
            String phone = request.getParameter("phone");
            String address = request.getParameter("txtAddress");

            if (username.equals("") || password.equals("") || name.equals("") || gender == null
                    || date.equals("") || phone.equals("") || address.equals("")) {
                request.getSession().setAttribute("errorMessage", "Please fill in all the information!");
                if (gender == null) {
                    request.getSession().setAttribute("genderMessage", "Gender must not be empty!");
                }
                if (date.equals("")) {
                    request.getSession().setAttribute("birthdayMessage", "Birthday must not be empty!");
                }
                response.sendRedirect("/AnimeStore/CreateCustomer");
            } else {
                customer checkCus = cDAO.getCustomer(username);
                if (checkCus != null) {
                    request.getSession().setAttribute("checkMessage", "The account is already exist!");
                    response.sendRedirect("/AnimeStore/CreateCustomer");
                } else {
                    Date birthday = Date.valueOf(date);
                    String pass_md5 = cDAO.getPwdMd5(password);
                    customer newCus = new customer(username, pass_md5, name, gender, birthday, phone, address);
                    customer rs = cDAO.addNew(newCus);
                    if (rs == null) {
                        request.getSession().setAttribute("errorMessage", "Create Fail!");
                        response.sendRedirect("/AnimeStore/CreateCustomer");
                    } else {
                        request.getSession().setAttribute("successMessage", "Create Successfully!");
                        response.sendRedirect("/AnimeStore/CreateCustomer");
                    }
                }
            }
        }

        if (request.getParameter("btnUpdateCustomer") != null) {
            CustomerDAO cDAO = new CustomerDAO();
            customer rs;
            String username = request.getParameter("txtUS");
            String name = request.getParameter("txtName");
            String gender = request.getParameter("rdoGen");
            Date birthday = Date.valueOf(request.getParameter("txtBD"));
            String phone = request.getParameter("phone");
            String address = request.getParameter("txtAddress");

            if (name.equals("") || phone.equals("") || address.equals("")) {
                rs = null;
            } else {
                customer newInfo = new customer(username, "", name, gender, birthday, phone, address);
                rs = cDAO.update(username, newInfo);
            }
            if (rs == null) {
                request.getSession().setAttribute("errorMessage", "Update Fail!");
                response.sendRedirect("/AnimeStore/MyAccount");
            } else {
                request.getSession().setAttribute("successMessage", "Update Successfully!");
                response.sendRedirect("/AnimeStore/MyAccount");
            }
        }

        if (request.getParameter("btnUpdatePassCustomer") != null) {
            CustomerDAO cDAO = new CustomerDAO();
            Cookie[] cList;
            cList = request.getCookies();
            String value = null;
            for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                if (cList1.getName().equals("customer")) { //nguoi dung da dang nhap
                    value = cList1.getValue();
                    break; //thoat khoi vong lap
                }
            }
            String oldPass = request.getParameter("txtOldPWD");
            String newPass = request.getParameter("txtNewPWD");

            if (oldPass.trim() != "") {
                customer cus = cDAO.getCustomer(value);
                boolean checkPass = cDAO.checkPassword(cDAO.getPwdMd5(oldPass));
                if (!checkPass) {
                    request.getSession().setAttribute("passError", "Password incorrect!");
                    response.sendRedirect("/AnimeStore/MyAccount");
                } else {
                    String pwd_md5 = cDAO.getPwdMd5(newPass);
                    if (pwd_md5.equals(cus.getPassword())) {
                        request.getSession().setAttribute("samePass", "The new password must be different from the current password!");
                        response.sendRedirect("/AnimeStore/MyAccount");
                    } else {
                        if (newPass.trim() != "") {
                            cDAO.updatePass(value, pwd_md5);
                            request.getSession().setAttribute("successPass", "Update Password Successfully!");
                            response.sendRedirect("/AnimeStore/MyAccount");
                        } else {
                            request.getSession().setAttribute("nullNewPass", "New password must not be empty!");
                            response.sendRedirect("/AnimeStore/MyAccount");
                        }
                    }
                }
            } else {
                request.getSession().setAttribute("nullPass", "Password must not be empty!");
                response.sendRedirect("/AnimeStore/MyAccount");
            }
        }

        if (request.getParameter("btnUpdateAdmin") != null) {
            AdminDAO aDAO = new AdminDAO();
            administrator rs;
            String username = request.getParameter("txtUS");
            String name = request.getParameter("txtName");
            String gender = request.getParameter("rdoGen");
            Date birthday = Date.valueOf(request.getParameter("txtBD"));
            String phone = request.getParameter("phone");
            String address = request.getParameter("txtAddress");

            if (name.equals("") || phone.equals("") || address.equals("")) {
                rs = null;
            } else {
                administrator newInfo = new administrator(username, "", name, gender, birthday, phone, address);
                rs = aDAO.update(username, newInfo);
            }
            if (rs == null) {
                request.getSession().setAttribute("errorMessage", "Update Fail!");
                response.sendRedirect("/AnimeStore/AccountAdmin");
            } else {
                request.getSession().setAttribute("successMessage", "Update Successfully!");
                response.sendRedirect("/AnimeStore/AccountAdmin");
            }
        }

        if (request.getParameter("btnUpdatePassAdmin") != null) {
            AdminDAO aDAO = new AdminDAO();
            Cookie[] cList;
            cList = request.getCookies();
            String value = null;
            for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                if (cList1.getName().equals("admin")) { //nguoi dung da dang nhap
                    value = cList1.getValue();
                    break; //thoat khoi vong lap
                }
            }
            String password = request.getParameter("txtPWD");

            administrator admin = aDAO.getAdmin(value);

            if (password.equals("")) {
                request.getSession().setAttribute("errorPass", "Password must not be empty!");
                response.sendRedirect("/AnimeStore/AccountAdmin");
            } else {
                String pwd_md5 = aDAO.getPwdMd5(request.getParameter("txtPWD"));
                if (pwd_md5.equals(admin.getPassword())) {
                    request.getSession().setAttribute("samePass", "The new password must be different from the current password!");
                    response.sendRedirect("/AnimeStore/AccountAdmin");
                } else {
                    aDAO.updatePass(value, pwd_md5);
                    request.getSession().setAttribute("successPass", "Update Password Successfully!");
                    response.sendRedirect("/AnimeStore/AccountAdmin");
                }
            }
        }

        if (request.getParameter("btnAddNewType") != null) { //Nguoi dung da nhan nut submit
            type type;
            String name = request.getParameter("txtName");

            if (name.equals("")) {
                response.sendRedirect("/AnimeStore/Type");
            } else {
                type newType = new type(0, name);
                TypeDAO tDAO = new TypeDAO();
                type = tDAO.addNew(newType);
                if (type == null) {
                    response.sendRedirect("/AnimeStore/Type");
                } else {
                    response.sendRedirect("/AnimeStore/Type");
                }
            }
        }
        if (request.getParameter("btnAddNewProduct") != null) { //Nguoi dung da nhan nut submit
            product pro = null;
            String name = request.getParameter("txtName");
            try {
                int quan = Integer.parseInt(request.getParameter("txtQuan"));
                long price = Long.parseLong(request.getParameter("txtPrice"));

                Part part = request.getPart("picture");
                String realPath = "C:\\Users\\VINH\\Documents\\NetBeansProjects\\HandmadeStore\\src\\main\\webapp\\imgs";
                Path fileName = Paths.get(part.getSubmittedFileName());
                if (!Files.exists(Paths.get(realPath))) {
                    Files.createDirectories(Paths.get(realPath));
                }
                String picture = fileName.getFileName().toString();

                int type_id = Integer.parseInt(request.getParameter("type"));
                String description = request.getParameter("txtDes");

                if (name.equals("") || quan < 1 || price < 1 || picture.equals("")
                        || description.equals("")) {
                    response.sendRedirect("/AnimeStore/AddNewProduct");
                } else {
                   
                    product newPro = new product(0, name, quan, price, picture, description, type_id);
                    ProductDAO pDAO = new ProductDAO();
                    pro = pDAO.addNew(newPro);
                }
                if (pro == null) {
                    response.sendRedirect("/AnimeStore/AddNewProduct");
                } else {
                    response.sendRedirect("/AnimeStore/ListProduct");
                }

            } catch (ServletException | IOException | NumberFormatException e) {
            }
        }

        if (request.getParameter("btnUpdateProduct") != null) {
            HttpSession session = request.getSession();
            ProductDAO pDAO = new ProductDAO();
            product rs = null;
            int id = Integer.parseInt(request.getParameter("txtID"));
            String name = request.getParameter("txtName");
            try {
                int pro_quan = Integer.parseInt(request.getParameter("txtQuan"));
                long pro_price = Long.parseLong(request.getParameter("txtPrice"));
                String pro_des = request.getParameter("txtDes");
                int type_id = Integer.parseInt(request.getParameter("type"));

                product pro = (product) session.getAttribute("pro");

                Part part = request.getPart("picture");
                //String realPath = request.getServletContext().getRealPath("/imgs");
                String realPath = "C:\\Users\\VINH\\Documents\\NetBeansProjects\\HandmadeStore\\src\\main\\webapp\\imgs";
                Path fileName = Paths.get(part.getSubmittedFileName());
                if (!Files.exists(Paths.get(realPath))) {
                    Files.createDirectories(Paths.get(realPath));
                }
                String pro_pic = fileName.getFileName().toString();

                if (name.equals("") || pro_quan < 1 || pro_price < 1 || pro_des.equals("")) {
                    product oldInfo = pDAO.getProduct(id);
                    session.setAttribute("pro", oldInfo);
                    request.getSession().setAttribute("errorMessage", "Update Fail!");
                    response.sendRedirect("/AnimeStore/Update/" + id);
                } else {
                    if (pro_pic.equals("")) {
                        product newInfo = new product(id, name, pro_quan, pro_price, "", pro_des, type_id);
                        rs = pDAO.update_withoutPicture(id, newInfo);
                    } else {
                       
                        File filePic = new File("C:\\Users\\VINH\\Documents\\NetBeansProjects\\HandmadeStore\\src\\main\\webapp\\imgs" + pro.getPicture());
                        filePic.delete();
                        product newInfo = new product(id, name, pro_quan, pro_price, pro_pic, pro_des, type_id);
                        rs = pDAO.update(id, newInfo);
                    }
                }

                if (rs == null) {
                    product oldInfo = pDAO.getProduct(id);
                    session.setAttribute("pro", oldInfo);
                    request.getSession().setAttribute("errorMessage", "Update Fail!");
                    response.sendRedirect("/AnimeStore/Update/" + id);
                } else {
                    response.sendRedirect("/AnimeStore/ListProduct");
                }
            } catch (ServletException | IOException | NumberFormatException e) {
                response.sendRedirect("/AnimeStore/ListProduct");
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
