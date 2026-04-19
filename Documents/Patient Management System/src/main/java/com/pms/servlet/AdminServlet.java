package com.pms.servlet;

import com.pms.dao.*;
import com.pms.model.Doctor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final DoctorDAO    doctorDAO    = new DoctorDAO();
    private final NurseDAO     nurseDAO     = new NurseDAO();
    private final DiagnosisDAO diagnosisDAO = new DiagnosisDAO();
    private final UserDAO      userDAO      = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        switch (action(req)) {
            case "dashboard"  -> dashboard(req, res);
            case "doctors"    -> doctors(req, res);
            case "add-doctor" -> forward(req, res, "/WEB-INF/views/admin/add-doctor.jsp");
            default           -> res.sendRedirect(req.getContextPath() + "/admin/dashboard");
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
        req.setAttribute("diagnosisCount", diagnosisDAO.getAll().size());
        req.setAttribute("doctors",        doctorDAO.getAllDoctors());
        forward(req, res, "/WEB-INF/views/admin/dashboard.jsp");
    }

    private void doctors(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("doctors", doctorDAO.getAllDoctors());
        forward(req, res, "/WEB-INF/views/admin/doctors.jsp");
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

    private void forward(HttpServletRequest req, HttpServletResponse res, String view)
            throws ServletException, IOException {
        req.getRequestDispatcher(view).forward(req, res);
    }
}
