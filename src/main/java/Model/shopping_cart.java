/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */
public class shopping_cart {
    private String cus_us;
    private int pro_id;
    private int quantity;
    private long price;

    public shopping_cart() {
    }

    public shopping_cart(String cus_us, int pro_id, int quantity, long price) {
        this.cus_us = cus_us;
        this.pro_id = pro_id;
        this.quantity = quantity;
        this.price = price;
    }

    /**
     * @return the cus_us
     */
    public String getCus_us() {
        return cus_us;
    }

    /**
     * @param cus_us the cus_us to set
     */
    public void setCus_us(String cus_us) {
        this.cus_us = cus_us;
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
