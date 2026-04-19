package com.pms.servlet;

import com.pms.dao.DiagnosisDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/diagnosis/*")
public class DiagnosisServlet extends HttpServlet {

    private final DiagnosisDAO diagnosisDAO = new DiagnosisDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String pi = req.getPathInfo();

        if (pi != null && pi.equals("/update")) {
            int    diagnosisID = Integer.parseInt(req.getParameter("diagnosisID"));
            String result      = req.getParameter("result").trim();

            if (!result.isBlank()) {
                diagnosisDAO.updateResult(diagnosisID, result);
                res.sendRedirect(req.getContextPath() + "/doctor/cases?success=Result+updated+successfully.");
            } else {
                res.sendRedirect(req.getContextPath() + "/doctor/cases?error=Result+cannot+be+empty.");
            }
        } else {
            res.sendRedirect(req.getContextPath() + "/doctor/dashboard");
        }
    }
}
