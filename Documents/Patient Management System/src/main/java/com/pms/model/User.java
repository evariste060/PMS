package com.pms.model;

public class User {
    private int    userID;
    private String username;
    private String password;
    private String userType;

    public User() {}

    public User(int userID, String username, String userType) {
        this.userID    = userID;
        this.username  = username;
        this.userType  = userType;
    }

    public int    getUserID()               { return userID;   }
    public void   setUserID(int userID)     { this.userID = userID; }
    public String getUsername()             { return username; }
    public void   setUsername(String v)     { this.username = v; }
    public String getPassword()             { return password; }
    public void   setPassword(String v)     { this.password = v; }
    public String getUserType()             { return userType; }
    public void   setUserType(String v)     { this.userType = v; }
}
