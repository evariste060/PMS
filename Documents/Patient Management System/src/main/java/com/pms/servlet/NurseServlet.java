package com.pms.servlet;

import com.pms.dao.*;
import com.pms.model.Diagnosis;
import com.pms.model.Nurse;
import com.pms.model.Patient;
import com.pms.util.FileUploadUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/nurse/*")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)   /* 5 MB */
public class NurseServlet extends HttpServlet {

    private final PatientDAO   patientDAO   = new PatientDAO();
    private final DiagnosisDAO diagnosisDAO = new DiagnosisDAO();
    private final UserDAO      userDAO      = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Nurse nurse = loggedNurse(req);
        switch (action(req)) {
            case "dashboard"     -> dashboard(req, res, nurse);
            case "patients"      -> patients(req, res, nurse);
            case "add-patient"   -> forward(req, res, "/WEB-INF/views/nurse/add-patient.jsp");
            case "add-diagnosis" -> diagnosisForm(req, res, nurse);
            default              -> res.sendRedirect(req.getContextPath() + "/nurse/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Nurse nurse = loggedNurse(req);
        switch (action(req)) {
            case "add-patient"   -> addPatient(req, res, nurse);
            case "add-diagnosis" -> addDiagnosis(req, res, nurse);
            default              -> res.sendRedirect(req.getContextPath() + "/nurse/dashboard");
        }
    }

    /* ── pages ── */

    private void dashboard(HttpServletRequest req, HttpServletResponse res, Nurse nurse)
            throws ServletException, IOException {
        int nid = nurse.getNurseID();
        req.setAttribute("patientCount",       patientDAO.countByNurse(nid));
        req.setAttribute("totalDiagnoses",     diagnosisDAO.countByNurse(nid));
        req.setAttribute("referrableCount",    diagnosisDAO.countReferrableByNurse(nid));
        req.setAttribute("notReferrableCount", diagnosisDAO.countNotReferrableByNurse(nid));
        req.setAttribute("patients",           patientDAO.getByNurse(nid));
        forward(req, res, "/WEB-INF/views/nurse/dashboard.jsp");
    }

    private void patients(HttpServletRequest req, HttpServletResponse res, Nurse nurse)
            throws ServletException, IOException {
        req.setAttribute("patients", patientDAO.getByNurse(nurse.getNurseID()));
        forward(req, res, "/WEB-INF/views/nurse/patients.jsp");
    }

    private void diagnosisForm(HttpServletRequest req, HttpServletResponse res, Nurse nurse)
            throws ServletException, IOException {
        req.setAttribute("patients", patientDAO.getByNurse(nurse.getNurseID()));
        forward(req, res, "/WEB-INF/views/nurse/add-diagnosis.jsp");
    }

    /* ── actions ── */

    private void addPatient(HttpServletRequest req, HttpServletResponse res, Nurse nurse)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (userDAO.usernameExists(username)) {
            req.setAttribute("error", "Username \"" + username + "\" is already taken.");
            forward(req, res, "/WEB-INF/views/nurse/add-patient.jsp");
            return;
        }

        Part   imagePart  = req.getPart("patientImage");
        String uploadDir  = getServletContext().getRealPath("/images");
        String imageUrl   = FileUploadUtil.saveImage(imagePart, uploadDir);

        int userID = userDAO.createUser(username, password, "Patient");
        if (userID == -1) {
            req.setAttribute("error", "Failed to create patient account.");
            forward(req, res, "/WEB-INF/views/nurse/add-patient.jsp");
            return;
        }

        Patient p = new Patient();
        p.setFirstName(req.getParameter("firstName"));
        p.setLastName(req.getParameter("lastName"));
        p.setTelephone(req.getParameter("telephone"));
        p.setEmail(req.getParameter("email"));
        p.setAddress(req.getParameter("address"));
        p.setPImageLink(imageUrl);
        p.setNurseID(nurse.getNurseID());
        p.setUserID(userID);
        patientDAO.addPatient(p);

        res.sendRedirect(req.getContextPath() + "/nurse/patients?success=Patient+registered+successfully.");
    }

    private void addDiagnosis(HttpServletRequest req, HttpServletResponse res, Nurse nurse)
            throws ServletException, IOException {
        int    patientID = Integer.parseInt(req.getParameter("patientID"));
        String status    = req.getParameter("diagnosisStatus");

        Diagnosis d = new Diagnosis();
        d.setPatientID(patientID);
        d.setNurseID(nurse.getNurseID());
        d.setDoctorID(nurse.getDoctorID());   /* auto-assign nurse's supervising doctor */
        d.setDiagnosisStatus(status);
        diagnosisDAO.addDiagnosis(d);

        res.sendRedirect(req.getContextPath() + "/nurse/dashboard?success=Diagnosis+submitted+successfully.");
    }

    /* ── helpers ── */

    private Nurse loggedNurse(HttpServletRequest req) {
        return (Nurse) req.getSession().getAttribute("loggedNurse");
    }

    private String action(HttpServletRequest req) {
        String pi = req.getPathInfo();
        return (pi == null || pi.equals("/")) ? "dashboard" : pi.substring(1);
    }

    private void forward(HttpServletRequest req, HttpServletResponse res, String view)
            throws ServletException, IOException {
        req.getRequestDispatcher(view).forward(req, res);
    }
}
