package com.pms.dao;

import com.pms.model.Patient;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    private Patient map(ResultSet rs) throws SQLException {
        Patient p = new Patient();
        p.setPatientID(rs.getInt("patientID"));
        p.setFirstName(rs.getString("firstName"));
        p.setLastName(rs.getString("lastName"));
        p.setTelephone(rs.getString("telephone"));
        p.setEmail(rs.getString("email"));
        p.setAddress(rs.getString("address"));
        p.setPImageLink(rs.getString("pImageLink"));
        p.setNurseID(rs.getInt("nurseID"));
        p.setUserID(rs.getInt("userID"));
        return p;
    }

    public void addPatient(Patient patient) {
        String sql = "INSERT INTO Patients (firstName,lastName,telephone,email,address,pImageLink,nurseID,userID) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, patient.getFirstName());
            ps.setString(2, patient.getLastName());
            ps.setString(3, patient.getTelephone());
            ps.setString(4, patient.getEmail());
            ps.setString(5, patient.getAddress());
            ps.setString(6, patient.getPImageLink());
            ps.setInt(7, patient.getNurseID());
            ps.setInt(8, patient.getUserID());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Patient> getByNurse(int nurseID) {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM Patients WHERE nurseID = ? ORDER BY firstName";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, nurseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Patient getByUserID(int userID) {
        String sql = "SELECT * FROM Patients WHERE userID = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public Patient getByID(int patientID) {
        String sql = "SELECT * FROM Patients WHERE patientID = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, patientID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public int countByNurse(int nurseID) {
        String sql = "SELECT COUNT(*) FROM Patients WHERE nurseID = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, nurseID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public List<Patient> getAll() {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM Patients ORDER BY firstName";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM Patients";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
}
