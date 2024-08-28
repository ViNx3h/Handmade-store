/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */
public class order {
    private int bill_id;
    private int pro_id;
    private int quantity;
    private long price;

    public order() {
    }

    public order(int bill_id, int pro_id, int quantity, long price) {
        this.bill_id = bill_id;
        this.pro_id = pro_id;
        this.quantity = quantity;
        this.price = price;
    }

    /**
     * @return the bill_id
     */
    public int getBill_id() {
        return bill_id;
    }

    /**
     * @param bill_id the bill_id to set
     */
    public void setBill_id(int bill_id) {
        this.bill_id = bill_id;
    }

    /**
     * @return the pro_id
     */
    public int getPro_id() {
        return pro_id;
    }

    /**
     * @param pro_id the pro_id to set
     */
    public void setPro_id(int pro_id) {
        this.pro_id = pro_id;
    }

    /**
     * @return the quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * @param quantity the quantity to set
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * @return the price
     */
    public long getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(long price) {
        this.price = price;
    }
        
}
