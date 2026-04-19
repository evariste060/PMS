package com.pms.dao;

import com.pms.model.Doctor;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {

    private Doctor map(ResultSet rs) throws SQLException {
        Doctor d = new Doctor();
        d.setDoctorID(rs.getInt("doctorID"));
        d.setFirstName(rs.getString("firstName"));
        d.setLastName(rs.getString("lastName"));
        d.setTelephone(rs.getString("telephone"));
        d.setEmail(rs.getString("email"));
        d.setAddress(rs.getString("address"));
        d.setHospitalName(rs.getString("hospitalName"));
        d.setUserID(rs.getInt("userID"));
        return d;
    }

    public void addDoctor(Doctor doctor) {
        String sql = "INSERT INTO Doctors (firstName,lastName,telephone,email,address,hospitalName,userID) VALUES (?,?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, doctor.getFirstName());
            ps.setString(2, doctor.getLastName());
            ps.setString(3, doctor.getTelephone());
            ps.setString(4, doctor.getEmail());
            ps.setString(5, doctor.getAddress());
            ps.setString(6, doctor.getHospitalName());
            ps.setInt(7, doctor.getUserID());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Doctor> getAllDoctors() {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT * FROM Doctors ORDER BY firstName";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Doctor getByUserID(int userID) {
        String sql = "SELECT * FROM Doctors WHERE userID = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public Doctor getByID(int doctorID) {
        String sql = "SELECT * FROM Doctors WHERE doctorID = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, doctorID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public int count() {
        String sql = "SELECT COUNT(*) FROM Doctors";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
}
