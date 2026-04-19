<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("loggedUser") == null ||
        !"Admin".equals(((com.pms.model.User)session.getAttribute("loggedUser")).getUserType())) {
        response.sendRedirect(request.getContextPath() + "/login"); return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>PMS &mdash; Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100 min-h-screen">
<div class="flex min-h-screen">

    <%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

    <main class="flex-1 ml-64">
        <!-- Top bar -->
        <header class="bg-white shadow-sm px-8 py-4 flex items-center justify-between sticky top-0 z-10">
            <div>
                <h1 class="text-xl font-bold text-gray-800">Admin Dashboard</h1>
                <p class="text-gray-400 text-xs mt-0.5">System overview &amp; management</p>
            </div>
            <div class="flex items-center gap-2 text-gray-500 text-sm">
                <i class="fas fa-calendar-days text-blue-500"></i>
                <span><%= new java.util.Date().toString().substring(0,10) %></span>
            </div>
        </header>

        <div class="p-8">

            <!-- Alerts -->
            <c:if test="${not empty param.success}">
                <div class="mb-6 bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-xl flex items-center gap-3 text-sm">
                    <i class="fas fa-circle-check text-green-500"></i> ${param.success}
                </div>
            </c:if>

            <!-- Stat cards -->
            <div class="grid grid-cols-1 sm:grid-cols-3 gap-6 mb-8">
                <div class="bg-white rounded-2xl shadow-sm p-6 flex items-center gap-5 border border-gray-100">
                    <div class="w-14 h-14 bg-blue-100 rounded-xl flex items-center justify-center flex-shrink-0">
                        <i class="fas fa-user-doctor text-blue-600 text-2xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-400 text-sm">Total Doctors</p>
                        <p class="text-3xl font-extrabold text-gray-800">${doctorCount}</p>
                    </div>
                </div>
                <div class="bg-white rounded-2xl shadow-sm p-6 flex items-center gap-5 border border-gray-100">
                    <div class="w-14 h-14 bg-teal-100 rounded-xl flex items-center justify-center flex-shrink-0">
                        <i class="fas fa-user-nurse text-teal-600 text-2xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-400 text-sm">Total Nurses</p>
                        <p class="text-3xl font-extrabold text-gray-800">${nurseCount}</p>
                    </div>
                </div>
                <div class="bg-white rounded-2xl shadow-sm p-6 flex items-center gap-5 border border-gray-100">
                    <div class="w-14 h-14 bg-violet-100 rounded-xl flex items-center justify-center flex-shrink-0">
                        <i class="fas fa-notes-medical text-violet-600 text-2xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-400 text-sm">Total Cases</p>
                        <p class="text-3xl font-extrabold text-gray-800">${diagnosisCount}</p>
                    </div>
                </div>
            </div>

            <!-- Doctors table -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
                    <h2 class="font-bold text-gray-800 flex items-center gap-2">
                        <i class="fas fa-user-doctor text-blue-500"></i> Registered Doctors
                    </h2>
                    <a href="${pageContext.request.contextPath}/admin/add-doctor"
                       class="bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium px-4 py-2 rounded-xl flex items-center gap-2 transition">
                        <i class="fas fa-plus"></i> Add Doctor
                    </a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead>
                            <tr class="bg-gray-50 text-gray-500 text-xs uppercase border-b border-gray-100">
                                <th class="px-6 py-3 text-left font-semibold">#</th>
                                <th class="px-6 py-3 text-left font-semibold">Doctor</th>
                                <th class="px-6 py-3 text-left font-semibold">Hospital</th>
                                <th class="px-6 py-3 text-left font-semibold">Email</th>
                                <th class="px-6 py-3 text-left font-semibold">Phone</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                            <c:choose>
                                <c:when test="${empty doctors}">
                                    <tr>
                                        <td colspan="5" class="text-center py-12 text-gray-400">
                                            <i class="fas fa-user-doctor text-4xl mb-3 block opacity-30"></i>
                                            No doctors registered yet.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${doctors}" var="d" varStatus="s">
                                        <tr class="hover:bg-gray-50 transition-colors">
                                            <td class="px-6 py-4 text-gray-400">${s.count}</td>
                                            <td class="px-6 py-4">
                                                <div class="flex items-center gap-3">
                                                    <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center">
                                                        <i class="fas fa-user-doctor text-blue-600 text-xs"></i>
                                                    </div>
                                                    <span class="font-medium text-gray-800">Dr. ${d.firstName} ${d.lastName}</span>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-gray-600">${d.hospitalName}</td>
                                            <td class="px-6 py-4 text-gray-500">${d.email}</td>
                                            <td class="px-6 py-4 text-gray-500">${d.telephone}</td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>
