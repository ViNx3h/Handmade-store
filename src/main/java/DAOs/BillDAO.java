/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.bill;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class BillDAO {
    
    Connection conn;

    public BillDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public bill addNew(bill newBill) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into bill values (GETDATE(),?,?)");
            ps.setLong(1, newBill.getTotal());
            ps.setString(2, newBill.getCus_us());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newBill;
    }
    
    public int getID() {
        int id = 0;
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT TOP 1 id FROM bill ORDER BY id DESC");
            if(rs.next()) {
                id = rs.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }
    
    public ResultSet getBill(String cus_us) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM bill where cus_us = ?");
            ps.setString(1, cus_us);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public ResultSet getBill_byDate(Date date) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM bill where [date] = ?");
            ps.setDate(1, date);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public long total_income_a_date(Date date) {
        long total_income = 0;
        ResultSet rs;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT SUM(total) as total FROM bill WHERE [date] = ?");
            ps.setDate(1, date);
            rs = ps.executeQuery();
            if(rs.next()) {
                total_income = rs.getLong("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return total_income;
    }
    
    public ResultSet getBill_byMonth(Date date) {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM bill WHERE Month([date]) = Month('" + date + "') AND Year([date]) = Year('" + date + "')");
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public long total_income_a_month(Date date) {
        long total_income = 0;
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT SUM(total) as total FROM bill WHERE Month([date]) = Month('" + date + "') AND Year([date]) = Year('" + date + "')");
            if(rs.next()) {
                total_income = rs.getLong("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return total_income;
    }
    
    public ResultSet getBill_byYear(int year) {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM bill WHERE Year([date]) = " + year);
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public long total_income_a_year(int year) {
        long total_income = 0;
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT SUM(total) as total FROM bill WHERE Year([date]) = " + year);
            if(rs.next()) {
                total_income = rs.getLong("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return total_income;
    }
}
