package com.pms.filter;

import com.pms.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req = (HttpServletRequest)  request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Most reliable way to get the path — strip the context path from the full URI
        // e.g. URI = /PatientManagementSystem/admin/dashboard
        //      ctx = /PatientManagementSystem
        //      path = /admin/dashboard
        String uri  = req.getRequestURI();
        String ctx  = req.getContextPath();
        String path = uri.substring(ctx.length());

        /* ── always allow public resources ── */
        if (path.equals("/login")
                || path.equals("/index.jsp")
                || path.isEmpty()
                || path.equals("/")
                || path.startsWith("/images/")
                || path.endsWith(".css")
                || path.endsWith(".js")
                || path.endsWith(".png")
                || path.endsWith(".jpg")
                || path.endsWith(".jpeg")
                || path.endsWith(".gif")
                || path.endsWith(".ico")) {
            chain.doFilter(request, response);
            return;
        }

        /* ── check session ── */
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        if (user == null) {
            res.sendRedirect(ctx + "/login");
            return;
        }

        /* ── role-based path guard ── */
        String  role    = user.getUserType();
        boolean allowed =
                (path.startsWith("/admin")     && "Admin".equals(role))   ||
                (path.startsWith("/doctor")    && "Doctor".equals(role))  ||
                (path.startsWith("/nurse")     && "Nurse".equals(role))   ||
                (path.startsWith("/patient")   && "Patient".equals(role)) ||
                (path.startsWith("/diagnosis") && "Doctor".equals(role))  ||
                path.equals("/logout");

        if (!allowed) {
            res.sendRedirect(ctx + "/login");
            return;
        }

        chain.doFilter(request, response);
    }
}
