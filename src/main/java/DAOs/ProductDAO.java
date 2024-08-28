/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.product;
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
public class ProductDAO {

    Connection conn;

    public ProductDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from product");
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAll(int type_id) {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from product where type_id = " + type_id);
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getTop4(int type_id) {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select top 4 * from product where type_id = " + type_id + "AND quantity > 0");
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public product getProduct(int pro_id) {
        product pro = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from product Where id = ?");
            ps.setInt(1, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                pro = new product(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity"), rs.getLong("price"), rs.getString("picture"), rs.getString("description"), rs.getInt("type_id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pro;
    }

    public product updateQuantity(int pro_id, int newQuantity) {
        product pro = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Update product Set quantity = ? Where id = ?");
            ps.setInt(1, newQuantity);
            ps.setInt(2, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                pro = new product(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity"), rs.getLong("price"), rs.getString("picture"), rs.getString("description"), rs.getInt("type_id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pro;
    }

    public product addNew(product newPro) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into product values (?,?,?,?,?,?)");
            ps.setString(1, newPro.getName());
            ps.setInt(2, newPro.getQuantity());
            ps.setLong(3, newPro.getPrice());
            ps.setString(4, newPro.getPicture());
            ps.setString(5, newPro.getDescription());
            ps.setInt(6, newPro.getType_id());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newPro;
    }
    
    public product update_withoutPicture(int id, product newPro) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Update product Set name=?, quantity=?, price=?, description=?, type_id=? Where id=?");
            ps.setString(1, newPro.getName());
            ps.setInt(2, newPro.getQuantity());
            ps.setLong(3, newPro.getPrice());
            ps.setString(4, newPro.getDescription());
            ps.setInt(5, newPro.getType_id());
            ps.setInt(6, id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newPro;
    }

    public product update(int id, product newPro) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Update product Set name=?, quantity=?, price=?, picture=?, description=?, type_id=? Where id=?");
            ps.setString(1, newPro.getName());
            ps.setInt(2, newPro.getQuantity());
            ps.setLong(3, newPro.getPrice());
            ps.setString(4, newPro.getPicture());
            ps.setString(5, newPro.getDescription());
            ps.setInt(6, newPro.getType_id());
            ps.setInt(7, id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newPro;
    }
    
    
    
    public void delete(int id) {
        try {
            PreparedStatement ps = conn.prepareCall("Delete from product Where id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
