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
public class administrator {
    private String username;
    private String password;
    private String fullname;
    private String gender;
    private Date birthday;
    private String phone_number;
    private String address;

    public administrator() {
    }

    public administrator(String username, String password, String fullname, String gender, Date birthday, String phone_number, String address) {
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.gender = gender;
        this.birthday = birthday;
        this.phone_number = phone_number;
        this.address = address;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the full name
     */
    public String getFullname() {
        return fullname;
    }

    /**
     * @param fullname the full name to set
     */
    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    /**
     * @return the gender
     */
    public String getGender() {
        return gender;
    }

    /**
     * @param gender the gender to set
     */
    public void setGender(String gender) {
        this.gender = gender;
    }

    /**
     * @return the birthday
     */
    public Date getBirthday() {
        return birthday;
    }

    /**
     * @param birthday the birthday to set
     */
    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    /**
     * @return the phone_number
     */
    public String getPhone_number() {
        return phone_number;
    }

    /**
     * @param phone_number the phone_number to set
     */
    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    /**
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * @param address the address to set
     */
    public void setAddress(String address) {
        this.address = address;
    }
    
}
