package com.pms.servlet;

import com.pms.dao.*;
import com.pms.model.Doctor;
import com.pms.model.Nurse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/doctor/*")
public class DoctorServlet extends HttpServlet {

    private final NurseDAO     nurseDAO     = new NurseDAO();
    private final DiagnosisDAO diagnosisDAO = new DiagnosisDAO();
    private final UserDAO      userDAO      = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Doctor doctor = loggedDoctor(req);
        switch (action(req)) {
            case "dashboard"  -> dashboard(req, res, doctor);
            case "nurses"     -> nurses(req, res, doctor);
            case "add-nurse"  -> forward(req, res, "/WEB-INF/views/doctor/add-nurse.jsp");
            case "cases"      -> cases(req, res, doctor);
            default           -> res.sendRedirect(req.getContextPath() + "/doctor/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Doctor doctor = loggedDoctor(req);
        if ("add-nurse".equals(action(req))) addNurse(req, res, doctor);
        else res.sendRedirect(req.getContextPath() + "/doctor/dashboard");
    }

    /* ── pages ── */

    private void dashboard(HttpServletRequest req, HttpServletResponse res, Doctor doctor)
            throws ServletException, IOException {
        int did = doctor.getDoctorID();
        req.setAttribute("nurseCount",     nurseDAO.countByDoctor(did));
        req.setAttribute("totalCases",     diagnosisDAO.getByHospital(did).size());
        req.setAttribute("pendingCount",   diagnosisDAO.countPendingByDoctor(did));
        req.setAttribute("confirmedCount", diagnosisDAO.countConfirmedByDoctor(did));
        req.setAttribute("nurses",         nurseDAO.getByDoctor(did));
        forward(req, res, "/WEB-INF/views/doctor/dashboard.jsp");
    }

    private void nurses(HttpServletRequest req, HttpServletResponse res, Doctor doctor)
            throws ServletException, IOException {
        req.setAttribute("nurses", nurseDAO.getByDoctor(doctor.getDoctorID()));
        forward(req, res, "/WEB-INF/views/doctor/nurses.jsp");
    }

    private void cases(HttpServletRequest req, HttpServletResponse res, Doctor doctor)
            throws ServletException, IOException {
        req.setAttribute("diagnoses", diagnosisDAO.getByHospital(doctor.getDoctorID()));
        forward(req, res, "/WEB-INF/views/doctor/cases.jsp");
    }

    private void addNurse(HttpServletRequest req, HttpServletResponse res, Doctor doctor)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (userDAO.usernameExists(username)) {
            req.setAttribute("error", "Username \"" + username + "\" is already taken.");
            forward(req, res, "/WEB-INF/views/doctor/add-nurse.jsp");
            return;
        }

        int userID = userDAO.createUser(username, password, "Nurse");
        if (userID == -1) {
            req.setAttribute("error", "Failed to create login account.");
            forward(req, res, "/WEB-INF/views/doctor/add-nurse.jsp");
            return;
        }

        Nurse n = new Nurse();
        n.setFirstName(req.getParameter("firstName"));
        n.setLastName(req.getParameter("lastName"));
        n.setTelephone(req.getParameter("telephone"));
        n.setEmail(req.getParameter("email"));
        n.setAddress(req.getParameter("address"));
        n.setHealthCenter(req.getParameter("healthCenter"));
        n.setDoctorID(doctor.getDoctorID());
        n.setUserID(userID);
        nurseDAO.addNurse(n);

        res.sendRedirect(req.getContextPath() + "/doctor/nurses?success=Nurse+registered+successfully.");
    }

    /* ── helpers ── */

    private Doctor loggedDoctor(HttpServletRequest req) {
        return (Doctor) req.getSession().getAttribute("loggedDoctor");
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
