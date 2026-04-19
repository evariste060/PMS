package com.pms.model;

import java.sql.Timestamp;

public class Diagnosis {
    private int       diagnosisID;
    private int       patientID;
    private int       nurseID;
    private int       doctorID;
    private String    diagnosisStatus;
    private String    result;
    private Timestamp createdAt;

    /* display fields populated from SQL JOINs */
    private String patientName;
    private String nurseName;
    private String doctorName;
    private String patientImage;

    public Diagnosis() {}

    public int       getDiagnosisID()              { return diagnosisID; }
    public void      setDiagnosisID(int v)         { this.diagnosisID = v; }
    public int       getPatientID()                { return patientID; }
    public void      setPatientID(int v)           { this.patientID = v; }
    public int       getNurseID()                  { return nurseID; }
    public void      setNurseID(int v)             { this.nurseID = v; }
    public int       getDoctorID()                 { return doctorID; }
    public void      setDoctorID(int v)            { this.doctorID = v; }
    public String    getDiagnosisStatus()          { return diagnosisStatus; }
    public void      setDiagnosisStatus(String v)  { this.diagnosisStatus = v; }
    public String    getResult()                   { return result; }
    public void      setResult(String v)           { this.result = v; }
    public Timestamp getCreatedAt()                { return createdAt; }
    public void      setCreatedAt(Timestamp v)     { this.createdAt = v; }
    public String    getPatientName()              { return patientName; }
    public void      setPatientName(String v)      { this.patientName = v; }
    public String    getNurseName()                { return nurseName; }
    public void      setNurseName(String v)        { this.nurseName = v; }
    public String    getDoctorName()               { return doctorName; }
    public void      setDoctorName(String v)       { this.doctorName = v; }
    public String    getPatientImage()             { return patientImage; }
    public void      setPatientImage(String v)     { this.patientImage = v; }

    public boolean isPending()   { return "Pending".equalsIgnoreCase(result); }
    public boolean isNegative()  { return "Negative".equalsIgnoreCase(result); }
    public boolean isConfirmed() { return !isPending() && !isNegative(); }
}
