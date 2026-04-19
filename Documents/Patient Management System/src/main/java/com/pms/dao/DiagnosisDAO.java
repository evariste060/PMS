package com.pms.dao;

import com.pms.model.Diagnosis;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiagnosisDAO {

    private static final String SELECT_JOIN =
        "SELECT d.*, " +
        "  CONCAT(p.firstName,' ',p.lastName) AS patientName, " +
        "  p.pImageLink                        AS patientImage, " +
        "  CONCAT(n.firstName,' ',n.lastName)  AS nurseName, " +
        "  CONCAT(IFNULL(doc.firstName,''),' ',IFNULL(doc.lastName,'')) AS doctorName " +
        "FROM Diagnosis d " +
        "JOIN Patients p  ON d.patientID = p.patientID " +
        "JOIN Nurses n    ON d.nurseID   = n.nurseID " +
        "LEFT JOIN Doctors doc ON d.doctorID = doc.doctorID ";

    private Diagnosis map(ResultSet rs) throws SQLException {
        Diagnosis d = new Diagnosis();
        d.setDiagnosisID(rs.getInt("diagnosisID"));
        d.setPatientID(rs.getInt("patientID"));
        d.setNurseID(rs.getInt("nurseID"));
        d.setDoctorID(rs.getInt("doctorID"));
        d.setDiagnosisStatus(rs.getString("diagnosisStatus"));
        d.setResult(rs.getString("result"));
        d.setCreatedAt(rs.getTimestamp("createdAt"));
        d.setPatientName(rs.getString("patientName"));
        d.setPatientImage(rs.getString("patientImage"));
        d.setNurseName(rs.getString("nurseName"));
        d.setDoctorName(rs.getString("doctorName").trim());
        return d;
    }

    /** Inserts a diagnosis; result is auto-set: Referrable→Pending, Not Referrable→Negative. */
    public void addDiagnosis(Diagnosis diagnosis) {
        String result = "Referrable".equals(diagnosis.getDiagnosisStatus()) ? "Pending" : "Negative";
        String sql = "INSERT INTO Diagnosis (patientID,nurseID,doctorID,diagnosisStatus,result) VALUES (?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, diagnosis.getPatientID());
            ps.setInt(2, diagnosis.getNurseID());
            ps.setInt(3, diagnosis.getDoctorID());
            ps.setString(4, diagnosis.getDiagnosisStatus());
            ps.setString(5, result);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void updateResult(int diagnosisID, String result) {
        String sql = "UPDATE Diagnosis SET result = ? WHERE diagnosisID = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, result);
            ps.setInt(2, diagnosisID);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Diagnosis> getByNurse(int nurseID) {
        return query(SELECT_JOIN + "WHERE d.nurseID = ? ORDER BY d.createdAt DESC", nurseID);
    }

    public List<Diagnosis> getByPatient(int patientID) {
        return query(SELECT_JOIN + "WHERE d.patientID = ? ORDER BY d.createdAt DESC", patientID);
    }

    public List<Diagnosis> getByHospital(int doctorID) {
        return query(SELECT_JOIN + "WHERE d.doctorID = ? ORDER BY d.createdAt DESC", doctorID);
    }

    public List<Diagnosis> getAll() {
        List<Diagnosis> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(SELECT_JOIN + "ORDER BY d.createdAt DESC")) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int countByNurse(int nurseID) {
        return countWhere("nurseID", nurseID, null, null);
    }

    public int countReferrableByNurse(int nurseID) {
        return countWhere2("nurseID", nurseID, "diagnosisStatus", "Referrable");
    }

    public int countNotReferrableByNurse(int nurseID) {
        return countWhere2("nurseID", nurseID, "diagnosisStatus", "Not Referrable");
    }

    public int countPendingByDoctor(int doctorID) {
        return countWhere2("doctorID", doctorID, "result", "Pending");
    }

    public int countConfirmedByDoctor(int doctorID) {
        String sql = "SELECT COUNT(*) FROM Diagnosis WHERE doctorID=? AND result NOT IN ('Pending','Negative')";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, doctorID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    /* ── helpers ── */

    private List<Diagnosis> query(String sql, int param) {
        List<Diagnosis> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, param);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    private int countWhere(String col1, int val1, String col2, String val2) {
        String sql = "SELECT COUNT(*) FROM Diagnosis WHERE " + col1 + "=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, val1);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private int countWhere2(String col1, int val1, String col2, String val2) {
        String sql = "SELECT COUNT(*) FROM Diagnosis WHERE " + col1 + "=? AND " + col2 + "=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, val1);
            ps.setString(2, val2);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
}
