<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("loggedUser") == null ||
        !"Doctor".equals(((com.pms.model.User)session.getAttribute("loggedUser")).getUserType())) {
        response.sendRedirect(request.getContextPath() + "/login"); return;
    }
    com.pms.model.Doctor doc = (com.pms.model.Doctor) session.getAttribute("loggedDoctor");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>PMS &mdash; Doctor Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100 min-h-screen">
<div class="flex min-h-screen">

    <%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

    <main class="flex-1 ml-64">
        <header class="bg-white shadow-sm px-8 py-4 flex items-center justify-between sticky top-0 z-10">
            <div>
                <h1 class="text-xl font-bold text-gray-800">Doctor Dashboard</h1>
                <p class="text-gray-400 text-xs mt-0.5">
                    <i class="fas fa-hospital text-blue-400 mr-1"></i>
                    <%= doc != null ? doc.getHospitalName() : "" %>
                </p>
            </div>
        </header>

        <div class="p-8">

            <!-- Hero greeting -->
            <div class="bg-gradient-to-r from-blue-600 to-cyan-500 rounded-2xl p-6 mb-8 text-white flex items-center justify-between">
                <div>
                    <p class="text-blue-100 text-sm mb-1">Welcome back,</p>
                    <h2 class="text-2xl font-bold">Dr. <%= doc != null ? doc.getFullName() : "" %></h2>
                    <p class="text-blue-200 text-sm mt-1"><i class="fas fa-map-marker-alt mr-1"></i><%= doc != null ? doc.getAddress() : "" %></p>
                </div>
                <div class="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center">
                    <i class="fas fa-user-doctor text-white text-3xl"></i>
                </div>
            </div>

            <!-- Stats -->
            <div class="grid grid-cols-2 lg:grid-cols-4 gap-5 mb-8">
                <div class="bg-white rounded-2xl shadow-sm p-5 border border-gray-100">
                    <div class="w-10 h-10 bg-teal-100 rounded-xl flex items-center justify-center mb-3">
                        <i class="fas fa-user-nurse text-teal-600"></i>
                    </div>
                    <p class="text-2xl font-extrabold text-gray-800">${nurseCount}</p>
                    <p class="text-gray-400 text-xs mt-0.5">My Nurses</p>
                </div>
                <div class="bg-white rounded-2xl shadow-sm p-5 border border-gray-100">
                    <div class="w-10 h-10 bg-blue-100 rounded-xl flex items-center justify-center mb-3">
                        <i class="fas fa-clipboard-list text-blue-600"></i>
                    </div>
                    <p class="text-2xl font-extrabold text-gray-800">${totalCases}</p>
                    <p class="text-gray-400 text-xs mt-0.5">Total Cases</p>
                </div>
                <div class="bg-white rounded-2xl shadow-sm p-5 border border-gray-100">
                    <div class="w-10 h-10 bg-amber-100 rounded-xl flex items-center justify-center mb-3">
                        <i class="fas fa-clock text-amber-600"></i>
                    </div>
                    <p class="text-2xl font-extrabold text-gray-800">${pendingCount}</p>
                    <p class="text-gray-400 text-xs mt-0.5">Pending</p>
                </div>
                <div class="bg-white rounded-2xl shadow-sm p-5 border border-gray-100">
                    <div class="w-10 h-10 bg-green-100 rounded-xl flex items-center justify-center mb-3">
                        <i class="fas fa-circle-check text-green-600"></i>
                    </div>
                    <p class="text-2xl font-extrabold text-gray-800">${confirmedCount}</p>
                    <p class="text-gray-400 text-xs mt-0.5">Confirmed</p>
                </div>
            </div>

            <!-- Nurses table -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
                    <h2 class="font-bold text-gray-800 flex items-center gap-2">
                        <i class="fas fa-user-nurse text-teal-500"></i> My Nurses
                    </h2>
                    <a href="${pageContext.request.contextPath}/doctor/add-nurse"
                       class="bg-teal-600 hover:bg-teal-700 text-white text-sm font-medium px-4 py-2 rounded-xl flex items-center gap-2 transition">
                        <i class="fas fa-plus"></i> Add Nurse
                    </a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead>
                            <tr class="bg-gray-50 text-gray-500 text-xs uppercase border-b border-gray-100">
                                <th class="px-6 py-3 text-left font-semibold">#</th>
                                <th class="px-6 py-3 text-left font-semibold">Nurse</th>
                                <th class="px-6 py-3 text-left font-semibold">Health Center</th>
                                <th class="px-6 py-3 text-left font-semibold">Email</th>
                                <th class="px-6 py-3 text-left font-semibold">Phone</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                            <c:choose>
                                <c:when test="${empty nurses}">
                                    <tr><td colspan="5" class="py-10 text-center text-gray-400 text-sm">
                                        No nurses registered yet.
                                    </td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${nurses}" var="n" varStatus="s">
                                        <tr class="hover:bg-gray-50 transition-colors">
                                            <td class="px-6 py-4 text-gray-400">${s.count}</td>
                                            <td class="px-6 py-4 font-medium text-gray-800">${n.firstName} ${n.lastName}</td>
                                            <td class="px-6 py-4 text-gray-600">${n.healthCenter}</td>
                                            <td class="px-6 py-4 text-gray-500">${n.email}</td>
                                            <td class="px-6 py-4 text-gray-500">${n.telephone}</td>
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
