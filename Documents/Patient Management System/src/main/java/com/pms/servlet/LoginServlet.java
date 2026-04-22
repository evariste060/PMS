package com.pms.servlet;

import com.pms.dao.DoctorDAO;
import com.pms.dao.NurseDAO;
import com.pms.dao.PatientDAO;
import com.pms.dao.UserDAO;
import com.pms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO    userDAO    = new UserDAO();
    private final DoctorDAO  doctorDAO  = new DoctorDAO();
    private final NurseDAO   nurseDAO   = new NurseDAO();
    private final PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            User user = (User) session.getAttribute("loggedUser");
            boolean profileReady = switch (user.getUserType()) {
                case "Doctor"  -> session.getAttribute("loggedDoctor")  != null;
                case "Nurse"   -> session.getAttribute("loggedNurse")   != null;
                case "Patient" -> session.getAttribute("loggedPatient") != null;
                default        -> true;
            };
            if (profileReady) {
                redirectByRole(req, res, user);
                return;
            }
            /* stale session — profile attribute missing; start fresh */
            session.invalidate();
        }
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.login(username, password);

        if (user == null) {
            req.setAttribute("error", "Invalid username or password.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("loggedUser", user);

        switch (user.getUserType()) {
            case "Doctor" -> {
                var doctor = doctorDAO.getByUserID(user.getUserID());
                if (doctor == null) {
                    session.invalidate();
                    req.setAttribute("error", "Doctor profile not found. Ask the administrator to re-register this account.");
                    req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
                    return;
                }
                session.setAttribute("loggedDoctor", doctor);
            }
            case "Nurse" -> {
                var nurse = nurseDAO.getByUserID(user.getUserID());
                if (nurse == null) {
                    session.invalidate();
                    req.setAttribute("error", "Nurse profile not found. Ask your supervising doctor to re-register this account.");
                    req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
                    return;
                }
                session.setAttribute("loggedNurse", nurse);
            }
            case "Patient" -> {
                var patient = patientDAO.getByUserID(user.getUserID());
                if (patient == null) {
                    session.invalidate();
                    req.setAttribute("error", "Patient profile not found. Ask your nurse to re-register this account.");
                    req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
                    return;
                }
                session.setAttribute("loggedPatient", patient);
            }
        }

        redirectByRole(req, res, user);
    }

    private void redirectByRole(HttpServletRequest req, HttpServletResponse res, User user)
            throws IOException {
        String ctx = req.getContextPath();
        switch (user.getUserType()) {
            case "Admin"   -> res.sendRedirect(ctx + "/admin/dashboard");
            case "Doctor"  -> res.sendRedirect(ctx + "/doctor/dashboard");
            case "Nurse"   -> res.sendRedirect(ctx + "/nurse/dashboard");
            case "Patient" -> res.sendRedirect(ctx + "/patient/dashboard");
            default        -> res.sendRedirect(ctx + "/login");
        }
    }
}
