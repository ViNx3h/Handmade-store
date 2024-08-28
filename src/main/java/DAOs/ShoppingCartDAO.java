/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.shopping_cart;
import java.sql.Connection;
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
public class ShoppingCartDAO {

    Connection conn;

    public ShoppingCartDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAll(String cus_us) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from shopping_cart where cus_us = ?");
            ps.setString(1, cus_us);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public int getQuantityOrder(String cus_us) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(pro_id) as count FROM shopping_cart WHERE cus_us=?");
            ps.setString(1, cus_us);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public shopping_cart addNew(shopping_cart newSC) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into shopping_cart values (?,?,?,?)");
            ps.setString(1, newSC.getCus_us());
            ps.setInt(2, newSC.getPro_id());
            ps.setInt(3, newSC.getQuantity());
            ps.setLong(4, newSC.getPrice());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newSC;
    }

    public void delete(String cus_us) {
        try {
            PreparedStatement ps = conn.prepareCall("Delete from shopping_cart Where cus_us=?");
            ps.setString(1, cus_us);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteProduct(String cus_us, int pro_id) {
        try {
            PreparedStatement ps = conn.prepareCall("Delete from shopping_cart Where cus_us=? and pro_id=?");
            ps.setString(1, cus_us);
            ps.setInt(2, pro_id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean existProduct(String cus_us, int pro_id) {
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM shopping_cart WHERE cus_us=? AND pro_id=?");
            ps.setString(1, cus_us);
            ps.setInt(2, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void updateQuantity(String cus_us, int pro_id) {
        try {
            PreparedStatement ps = conn.prepareCall("update shopping_cart set quantity = quantity + 1 Where cus_us=? and pro_id=?");
            ps.setString(1, cus_us);
            ps.setInt(2, pro_id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean downQuantity(int pro_id, int quantity) {
        if (quantity > 1) {
            try {
                PreparedStatement ps = conn.prepareStatement("update shopping_cart set quantity = quantity - 1 Where pro_id=?");
                ps.setInt(1, pro_id);
                ps.executeUpdate();
                return true;
            } catch (SQLException ex) {
                Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;
    }

    public boolean upQuantity(int pro_id, int quantity, int pro_quantity) {
        if (quantity < pro_quantity) {
            try {
                PreparedStatement ps = conn.prepareStatement("update shopping_cart set quantity = quantity + 1 Where pro_id=?");
                ps.setInt(1, pro_id);
                ps.executeUpdate();
                return true;
            } catch (SQLException ex) {
                Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;
    }

}
