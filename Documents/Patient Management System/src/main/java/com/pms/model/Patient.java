package com.pms.model;

public class Patient {
    private int    patientID;
    private String firstName;
    private String lastName;
    private String telephone;
    private String email;
    private String address;
    private String pImageLink;
    private int    nurseID;
    private int    userID;

    public Patient() {}

    public int    getPatientID()            { return patientID; }
    public void   setPatientID(int v)       { this.patientID = v; }
    public String getFirstName()            { return firstName; }
    public void   setFirstName(String v)    { this.firstName = v; }
    public String getLastName()             { return lastName; }
    public void   setLastName(String v)     { this.lastName = v; }
    public String getTelephone()            { return telephone; }
    public void   setTelephone(String v)    { this.telephone = v; }
    public String getEmail()                { return email; }
    public void   setEmail(String v)        { this.email = v; }
    public String getAddress()              { return address; }
    public void   setAddress(String v)      { this.address = v; }
    public String getPImageLink()           { return pImageLink; }
    public void   setPImageLink(String v)   { this.pImageLink = v; }
    public int    getNurseID()              { return nurseID; }
    public void   setNurseID(int v)         { this.nurseID = v; }
    public int    getUserID()               { return userID; }
    public void   setUserID(int v)          { this.userID = v; }

    public String getFullName() { return firstName + " " + lastName; }
}
