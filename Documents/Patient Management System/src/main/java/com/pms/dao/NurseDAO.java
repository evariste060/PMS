package com.pms.dao;

import com.pms.model.Nurse;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NurseDAO {

    private Nurse map(ResultSet rs) throws SQLException {
        Nurse n = new Nurse();
        n.setNurseID(rs.getInt("nurseID"));
        n.setFirstName(rs.getString("firstName"));
        n.setLastName(rs.getString("lastName"));
        n.setTelephone(rs.getString("telephone"));
        n.setEmail(rs.getString("email"));
        n.setAddress(rs.getString("address"));
        n.setHealthCenter(rs.getString("healthCenter"));
        n.setDoctorID(rs.getInt("doctorID"));
        n.setUserID(rs.getInt("userID"));
        return n;
    }

    public void addNurse(Nurse nurse) {
        String sql = "INSERT INTO Nurses (firstName,lastName,telephone,email,address,healthCenter,doctorID,userID) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, nurse.getFirstName());
            ps.setString(2, nurse.getLastName());
            ps.setString(3, nurse.getTelephone());
            ps.setString(4, nurse.getEmail());
            ps.setString(5, nurse.getAddress());
            ps.setString(6, nurse.getHealthCenter());
            ps.setInt(7, nurse.getDoctorID());
            ps.setInt(8, nurse.getUserID());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Nurse> getByDoctor(int doctorID) {
        List<Nurse> list = new ArrayList<>();
        String sql = "SELECT * FROM Nurses WHERE doctorID = ? ORDER BY firstName";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, doctorID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Nurse getByUserID(int userID) {
        String sql = "SELECT * FROM Nurses WHERE userID = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public Nurse getByID(int nurseID) {
        String sql = "SELECT * FROM Nurses WHERE nurseID = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, nurseID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM Nurses";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public int countByDoctor(int doctorID) {
        String sql = "SELECT COUNT(*) FROM Nurses WHERE doctorID = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, doctorID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public List<Nurse> getAll() {
        List<Nurse> list = new ArrayList<>();
        String sql = "SELECT * FROM Nurses ORDER BY firstName";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
