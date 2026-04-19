<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("loggedUser") == null ||
        !"Nurse".equals(((com.pms.model.User)session.getAttribute("loggedUser")).getUserType())) {
        response.sendRedirect(request.getContextPath() + "/login"); return;
    }
    com.pms.model.Nurse nurse = (com.pms.model.Nurse) session.getAttribute("loggedNurse");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>PMS &mdash; Nurse Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100 min-h-screen">
<div class="flex min-h-screen">

    <%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

    <main class="flex-1 ml-64">
        <header class="bg-white shadow-sm px-8 py-4 flex items-center justify-between sticky top-0 z-10">
            <div>
                <h1 class="text-xl font-bold text-gray-800">Nurse Dashboard</h1>
                <p class="text-gray-400 text-xs mt-0.5">
                    <i class="fas fa-house-medical text-teal-400 mr-1"></i>
                    <%= nurse != null ? nurse.getHealthCenter() : "" %>
                </p>
            </div>
        </header>

        <div class="p-8">

            <c:if test="${not empty param.success}">
                <div class="mb-6 bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-xl flex items-center gap-3 text-sm">
                    <i class="fas fa-circle-check text-green-500"></i> ${param.success}
                </div>
            </c:if>

            <!-- Hero -->
            <div class="bg-gradient-to-r from-teal-600 to-cyan-500 rounded-2xl p-6 mb-8 text-white flex items-center justify-between">
                <div>
                    <p class="text-teal-100 text-sm mb-1">Welcome back,</p>
                    <h2 class="text-2xl font-bold"><%= nurse != null ? nurse.getFullName() : "" %></h2>
                    <p class="text-teal-200 text-sm mt-1"><i class="fas fa-location-dot mr-1"></i><%= nurse != null ? nurse.getAddress() : "" %></p>
                </div>
                <div class="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center">
                    <i class="fas fa-user-nurse text-white text-3xl"></i>
                </div>
            </div>

            <!-- Stats -->
            <div class="grid grid-cols-2 lg:grid-cols-4 gap-5 mb-8">
                <div class="bg-white rounded-2xl shadow-sm p-5 border border-gray-100">
                    <div class="w-10 h-10 bg-blue-100 rounded-xl flex items-center justify-center mb-3">
                        <i class="fas fa-bed-pulse text-blue-600"></i>
                    </div>
                    <p class="text-2xl font-extrabold text-gray-800">${patientCount}</p>
                    <p class="text-gray-400 text-xs mt-0.5">My Patients</p>
                </div>
                <div class="bg-white rounded-2xl shadow-sm p-5 border border-gray-100">
                    <div class="w-10 h-10 bg-violet-100 rounded-xl flex items-center justify-center mb-3">
                        <i class="fas fa-notes-medical text-violet-600"></i>
                    </div>
                    <p class="text-2xl font-extrabold text-gray-800">${totalDiagnoses}</p>
                    <p class="text-gray-400 text-xs mt-0.5">Total Diagnoses</p>
                </div>
                <div class="bg-white rounded-2xl shadow-sm p-5 border border-gray-100">
                    <div class="w-10 h-10 bg-orange-100 rounded-xl flex items-center justify-center mb-3">
                        <i class="fas fa-triangle-exclamation text-orange-500"></i>
                    </div>
                    <p class="text-2xl font-extrabold text-gray-800">${referrableCount}</p>
                    <p class="text-gray-400 text-xs mt-0.5">Referrable</p>
                </div>
                <div class="bg-white rounded-2xl shadow-sm p-5 border border-gray-100">
                    <div class="w-10 h-10 bg-green-100 rounded-xl flex items-center justify-center mb-3">
                        <i class="fas fa-circle-check text-green-600"></i>
                    </div>
                    <p class="text-2xl font-extrabold text-gray-800">${notReferrableCount}</p>
                    <p class="text-gray-400 text-xs mt-0.5">Not Referrable</p>
                </div>
            </div>

            <!-- Quick actions -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-8">
                <a href="${pageContext.request.contextPath}/nurse/add-patient"
                   class="bg-white border border-gray-100 rounded-2xl p-5 flex items-center gap-4 shadow-sm hover:shadow-md hover:border-teal-200 transition group">
                    <div class="w-12 h-12 bg-teal-100 group-hover:bg-teal-200 rounded-xl flex items-center justify-center transition">
                        <i class="fas fa-user-plus text-teal-600 text-xl"></i>
                    </div>
                    <div>
                        <p class="font-bold text-gray-800">Register Patient</p>
                        <p class="text-gray-400 text-xs">Add a new patient with photo</p>
                    </div>
                    <i class="fas fa-chevron-right text-gray-300 ml-auto group-hover:text-teal-400 transition"></i>
                </a>
                <a href="${pageContext.request.contextPath}/nurse/add-diagnosis"
                   class="bg-white border border-gray-100 rounded-2xl p-5 flex items-center gap-4 shadow-sm hover:shadow-md hover:border-violet-200 transition group">
                    <div class="w-12 h-12 bg-violet-100 group-hover:bg-violet-200 rounded-xl flex items-center justify-center transition">
                        <i class="fas fa-notes-medical text-violet-600 text-xl"></i>
                    </div>
                    <div>
                        <p class="font-bold text-gray-800">Add Diagnosis</p>
                        <p class="text-gray-400 text-xs">Submit a patient diagnosis</p>
                    </div>
                    <i class="fas fa-chevron-right text-gray-300 ml-auto group-hover:text-violet-400 transition"></i>
                </a>
            </div>

            <!-- Patients table -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
                    <h2 class="font-bold text-gray-800 flex items-center gap-2">
                        <i class="fas fa-bed-pulse text-blue-500"></i> My Patients
                    </h2>
                    <a href="${pageContext.request.contextPath}/nurse/patients"
                       class="text-blue-600 hover:text-blue-700 text-sm font-medium">
                        View all <i class="fas fa-arrow-right ml-1"></i>
                    </a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead>
                            <tr class="bg-gray-50 text-gray-500 text-xs uppercase border-b border-gray-100">
                                <th class="px-6 py-3 text-left font-semibold">Patient</th>
                                <th class="px-6 py-3 text-left font-semibold">Email</th>
                                <th class="px-6 py-3 text-left font-semibold">Phone</th>
                                <th class="px-6 py-3 text-left font-semibold">Address</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                            <c:choose>
                                <c:when test="${empty patients}">
                                    <tr><td colspan="4" class="py-10 text-center text-gray-400 text-sm">
                                        No patients registered yet.
                                    </td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${patients}" var="p" varStatus="s">
                                        <tr class="hover:bg-gray-50 transition-colors">
                                            <td class="px-6 py-3">
                                                <div class="flex items-center gap-3">
                                                    <img src="${pageContext.request.contextPath}/${p.pImageLink}"
                                                         class="w-9 h-9 rounded-full object-cover bg-gray-100"
                                                         onerror="this.src='https://ui-avatars.com/api/?name=${p.firstName}+${p.lastName}&background=e0f2fe&color=0369a1&size=36'"/>
                                                    <span class="font-medium text-gray-800">${p.firstName} ${p.lastName}</span>
                                                </div>
                                            </td>
                                            <td class="px-6 py-3 text-gray-500">${p.email}</td>
                                            <td class="px-6 py-3 text-gray-500">${p.telephone}</td>
                                            <td class="px-6 py-3 text-gray-500 max-w-xs truncate">${p.address}</td>
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
