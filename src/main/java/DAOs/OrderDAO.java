/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.order;
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
public class OrderDAO {
    
    Connection conn;

    public OrderDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public order addNew(order newOrder) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into [order] values (?,?,?,?)");
            ps.setInt(1, newOrder.getBill_id());
            ps.setInt(2, newOrder.getPro_id());
            ps.setInt(3, newOrder.getQuantity());
            ps.setLong(4, newOrder.getPrice());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newOrder;
    }
    
    public ResultSet getOrder(int bill_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM [order] where bill_id = ?");
            ps.setInt(1, bill_id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
}
