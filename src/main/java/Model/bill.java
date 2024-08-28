/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class bill {

    private int id;
    private Date date;
    private long total;
    private String cus_us;

    public bill() {
    }

    public bill(int id, Date date, long total, String cus_us) {
        this.id = id;
        this.date = date;
        this.total = total;
        this.cus_us = cus_us;
    }

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the date
     */
    public Date getDate() {
        return date;
    }

    /**
     * @return the total
     */
    public long getTotal() {
        return total;
    }

    /**
     * @param total the total to set
     */
    public void setTotal(long total) {
        this.total = total;
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
     * @param date the date to set
     */
    public void setDate(Date date) {
        this.date = date;
    }

}
