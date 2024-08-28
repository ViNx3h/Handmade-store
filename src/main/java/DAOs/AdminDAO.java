/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.administrator;
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
public class AdminDAO {
    
    Connection conn;

    public AdminDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM administrator WHERE username = ?");
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
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM administrator WHERE username = ? AND password = ?");
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
    
    public administrator getAdmin(String username) {
        administrator admin = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from administrator Where username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                admin = new administrator(rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("gender"), rs.getDate("birthday"), rs.getString("phone_number"), rs.getString("address"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return admin;
    }
    
    public administrator update(String username, administrator newInfo) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Update administrator Set fullname=?, gender=?, birthday=?, phone_number=?, address=? Where username=?");
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
            PreparedStatement ps = conn.prepareStatement("Update administrator Set password=? Where username=?");
            ps.setString(1, password);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
