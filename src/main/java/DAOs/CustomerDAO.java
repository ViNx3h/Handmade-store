/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.customer;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class CustomerDAO {
    
    Connection conn;

    public CustomerDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String getPwdMd5(String input) {
        try {

            // Static getInstance method is called with hashing MD5
            MessageDigest md = MessageDigest.getInstance("MD5");

            // digest() method is called to calculate message digest
            // of an input digest() return array of byte
            byte[] messageDigest = md.digest(input.getBytes());

            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);

            // Convert message digest into hex value
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } // For specifying wrong message digest algorithms
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
    
    public boolean check_username(String us) {
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM customer WHERE username = ?");
            ps.setString(1, us);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean check_password(String us, String pwd) {
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM customer WHERE username = ? AND password = ?");
            ps.setString(1, us);
            ps.setString(2, pwd);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public customer getCustomer(String username) {
        customer cus = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from customer Where username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                cus = new customer(rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("gender"), rs.getDate("birthday"), rs.getString("phone_number"), rs.getString("address"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cus;
    }
    
    public customer addNew(customer newCustomer) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into customer values (?,?,?,?,?,?,?)");
            ps.setString(1, newCustomer.getUsername());
            ps.setString(2, newCustomer.getPassword());
            ps.setString(3, newCustomer.getFullname());
            ps.setString(4, newCustomer.getGender());
            ps.setDate(5, newCustomer.getBirthday());
            ps.setString(6, newCustomer.getPhone_number());
            ps.setString(7, newCustomer.getAddress());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newCustomer;
    }
    
    public customer update(String username, customer newInfo) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Update customer Set fullname=?, gender=?, birthday=?, phone_number=?, address=? Where username=?");
            ps.setString(1, newInfo.getFullname());
            ps.setString(2, newInfo.getGender());
            ps.setDate(3, newInfo.getBirthday());
            ps.setString(4, newInfo.getPhone_number());
            ps.setString(5, newInfo.getAddress());
            ps.setString(6, username);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newInfo;
    }
    
    public void updatePass(String username, String password) {
        try {
            PreparedStatement ps = conn.prepareStatement("Update customer Set password=? Where username=?");
            ps.setString(1, password);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public boolean checkPassword(String pass){
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from customer Where password = ?");
            ps.setString(1, pass);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
