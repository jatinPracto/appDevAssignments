package com.example.employeemanager;
import java.util.Date;
public class EmployeeModel {
    private long id;
    private String name;
    private Date dateOfBirth;
    private String designation;
    private int yearsOfExperience;
    private String address;
    public EmployeeModel() {}
    public EmployeeModel(String name, Date dateOfBirth, String designation, int yearsOfExperience, String address) {
        this.name = name;
        this.dateOfBirth = dateOfBirth;
        this.designation = designation;
        this.yearsOfExperience = yearsOfExperience;
        this.address = address;
    }
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public Date getDateOfBirth() {
        return dateOfBirth;
    }
    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    public String getDesignation() {
        return designation;
    }
    public void setDesignation(String designation) {
        this.designation = designation;
    }
    public int getYearsOfExperience() {
        return yearsOfExperience;
    }
    public void setYearsOfExperience(int yearsOfExperience) {
        this.yearsOfExperience = yearsOfExperience;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
}
