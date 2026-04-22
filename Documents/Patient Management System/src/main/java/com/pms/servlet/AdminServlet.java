package com.pms.servlet;

import com.pms.dao.*;
import com.pms.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final DoctorDAO    doctorDAO    = new DoctorDAO();
    private final NurseDAO     nurseDAO     = new NurseDAO();
    private final PatientDAO   patientDAO   = new PatientDAO();
    private final DiagnosisDAO diagnosisDAO = new DiagnosisDAO();
    private final UserDAO      userDAO      = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        switch (action(req)) {
            case "dashboard"     -> dashboard(req, res);
            case "doctors"       -> doctors(req, res);
            case "doctor-detail" -> doctorDetail(req, res);
            case "nurses"        -> nurses(req, res);
            case "nurse-detail"  -> nurseDetail(req, res);
            case "patients"      -> patients(req, res);
            case "diagnoses"     -> diagnoses(req, res);
            case "add-doctor"    -> forward(req, res, "/WEB-INF/views/admin/add-doctor.jsp");
            default              -> res.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if ("add-doctor".equals(action(req))) addDoctor(req, res);
        else res.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }

    /* ── pages ── */

    private void dashboard(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("doctorCount",    doctorDAO.count());
        req.setAttribute("nurseCount",     nurseDAO.countAll());
        req.setAttribute("patientCount",   patientDAO.countAll());
        req.setAttribute("diagnosisCount", diagnosisDAO.getAll().size());
        req.setAttribute("doctors",        doctorDAO.getAllDoctors());
        forward(req, res, "/WEB-INF/views/admin/dashboard.jsp");
    }

    private void doctors(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("doctors", doctorDAO.getAllDoctors());
        forward(req, res, "/WEB-INF/views/admin/doctors.jsp");
    }

    private void doctorDetail(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int doctorID = parseID(req.getParameter("id"));
        if (doctorID == -1) { res.sendRedirect(req.getContextPath() + "/admin/doctors"); return; }

        Doctor doctor = doctorDAO.getByID(doctorID);
        if (doctor == null) { res.sendRedirect(req.getContextPath() + "/admin/doctors"); return; }

        List<Nurse> nurseList = nurseDAO.getByDoctor(doctorID);
        req.setAttribute("doctor", doctor);
        req.setAttribute("nurses", nurseList);
        req.setAttribute("nurseCount", nurseList.size());
        forward(req, res, "/WEB-INF/views/admin/doctor-detail.jsp");
    }

    private void nurses(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        List<Nurse> nurseList = nurseDAO.getAll();
        Map<Integer, String> doctorNames = new HashMap<>();
        for (Doctor d : doctorDAO.getAllDoctors())
            doctorNames.put(d.getDoctorID(), "Dr. " + d.getFirstName() + " " + d.getLastName());

        req.setAttribute("nurses", nurseList);
        req.setAttribute("doctorNames", doctorNames);
        forward(req, res, "/WEB-INF/views/admin/nurses.jsp");
    }

    private void nurseDetail(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int nurseID = parseID(req.getParameter("id"));
        if (nurseID == -1) { res.sendRedirect(req.getContextPath() + "/admin/nurses"); return; }

        Nurse nurse = nurseDAO.getByID(nurseID);
        if (nurse == null) { res.sendRedirect(req.getContextPath() + "/admin/nurses"); return; }

        Doctor doctor = doctorDAO.getByID(nurse.getDoctorID());
        List<Patient> patientList = patientDAO.getByNurse(nurseID);

        req.setAttribute("nurse", nurse);
        req.setAttribute("doctor", doctor);
        req.setAttribute("patients", patientList);
        req.setAttribute("patientCount", patientList.size());
        forward(req, res, "/WEB-INF/views/admin/nurse-detail.jsp");
    }

    private void patients(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        List<Patient> patientList = patientDAO.getAll();
        Map<Integer, String> nurseNames = new HashMap<>();
        for (Nurse n : nurseDAO.getAll())
            nurseNames.put(n.getNurseID(), n.getFirstName() + " " + n.getLastName());

        req.setAttribute("patients", patientList);
        req.setAttribute("nurseNames", nurseNames);
        forward(req, res, "/WEB-INF/views/admin/patients.jsp");
    }

    private void diagnoses(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("diagnoses", diagnosisDAO.getAll());
        forward(req, res, "/WEB-INF/views/admin/diagnoses.jsp");
    }

    private void addDoctor(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (userDAO.usernameExists(username)) {
            req.setAttribute("error", "Username \"" + username + "\" is already taken.");
            forward(req, res, "/WEB-INF/views/admin/add-doctor.jsp");
            return;
        }

        int userID = userDAO.createUser(username, password, "Doctor");
        if (userID == -1) {
            req.setAttribute("error", "Failed to create login account. Please try again.");
            forward(req, res, "/WEB-INF/views/admin/add-doctor.jsp");
            return;
        }

        Doctor d = new Doctor();
        d.setFirstName(req.getParameter("firstName"));
        d.setLastName(req.getParameter("lastName"));
        d.setTelephone(req.getParameter("telephone"));
        d.setEmail(req.getParameter("email"));
        d.setAddress(req.getParameter("address"));
        d.setHospitalName(req.getParameter("hospitalName"));
        d.setUserID(userID);
        doctorDAO.addDoctor(d);

        res.sendRedirect(req.getContextPath() + "/admin/doctors?success=Doctor+registered+successfully.");
    }

    /* ── helpers ── */

    private String action(HttpServletRequest req) {
        String pi = req.getPathInfo();
        return (pi == null || pi.equals("/")) ? "dashboard" : pi.substring(1);
    }

    private int parseID(String val) {
        try { return Integer.parseInt(val); } catch (Exception e) { return -1; }
    }

    private void forward(HttpServletRequest req, HttpServletResponse res, String view)
            throws ServletException, IOException {
        req.getRequestDispatcher(view).forward(req, res);
    }
}
