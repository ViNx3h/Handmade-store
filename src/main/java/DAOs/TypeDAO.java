/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.type;
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
public class TypeDAO {
    
    Connection conn;

    public TypeDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from type");
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public ResultSet getAll_exist(int id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from type Where id <> ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public type getType(int id) {
        type type = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from type Where id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                type = new type(rs.getInt("id"), rs.getString("name"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return type;
    }
    
    public type addNew(type newType) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into type values (?)");
            ps.setString(1, newType.getName());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newType;
    }
    
    public boolean delete(int id) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareCall("Delete from type Where id=?");
            ps.setInt(1, id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count != 0);
    }
}
