package com.pms.servlet;

import com.pms.dao.DiagnosisDAO;
import com.pms.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/patient/*")
public class PatientServlet extends HttpServlet {

    private final DiagnosisDAO diagnosisDAO = new DiagnosisDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Patient patient = (Patient) req.getSession().getAttribute("loggedPatient");
        String  action  = pathAction(req);

        if ("dashboard".equals(action)) {
            req.setAttribute("diagnoses", diagnosisDAO.getByPatient(patient.getPatientID()));
            req.getRequestDispatcher("/WEB-INF/views/patient/dashboard.jsp").forward(req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/patient/dashboard");
        }
    }

    private String pathAction(HttpServletRequest req) {
        String pi = req.getPathInfo();
        return (pi == null || pi.equals("/")) ? "dashboard" : pi.substring(1);
    }
}
