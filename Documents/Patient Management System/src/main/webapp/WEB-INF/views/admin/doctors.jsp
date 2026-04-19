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
    <title>PMS &mdash; All Doctors</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100 min-h-screen">
<div class="flex min-h-screen">

    <%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

    <main class="flex-1 ml-64">
        <header class="bg-white shadow-sm px-8 py-4 flex items-center justify-between sticky top-0 z-10">
            <div>
                <h1 class="text-xl font-bold text-gray-800">Doctors</h1>
                <p class="text-gray-400 text-xs mt-0.5">All registered doctors</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/add-doctor"
               class="bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium px-4 py-2 rounded-xl flex items-center gap-2 transition">
                <i class="fas fa-plus"></i> Add Doctor
            </a>
        </header>

        <div class="p-8">

            <c:if test="${not empty param.success}">
                <div class="mb-6 bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-xl flex items-center gap-3 text-sm">
                    <i class="fas fa-circle-check text-green-500"></i> ${param.success}
                </div>
            </c:if>

            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead>
                            <tr class="bg-gray-50 text-gray-500 text-xs uppercase border-b border-gray-100">
                                <th class="px-6 py-3 text-left font-semibold">#</th>
                                <th class="px-6 py-3 text-left font-semibold">Name</th>
                                <th class="px-6 py-3 text-left font-semibold">Hospital</th>
                                <th class="px-6 py-3 text-left font-semibold">Email</th>
                                <th class="px-6 py-3 text-left font-semibold">Phone</th>
                                <th class="px-6 py-3 text-left font-semibold">Address</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                            <c:choose>
                                <c:when test="${empty doctors}">
                                    <tr><td colspan="6" class="py-12 text-center text-gray-400">
                                        <i class="fas fa-user-doctor text-4xl mb-3 block opacity-30"></i>
                                        No doctors registered yet. <a href="${pageContext.request.contextPath}/admin/add-doctor" class="text-blue-600 underline">Add one now.</a>
                                    </td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${doctors}" var="d" varStatus="s">
                                        <tr class="hover:bg-gray-50 transition-colors">
                                            <td class="px-6 py-4 text-gray-400">${s.count}</td>
                                            <td class="px-6 py-4">
                                                <div class="flex items-center gap-3">
                                                    <div class="w-9 h-9 rounded-full bg-gradient-to-br from-blue-400 to-blue-600 flex items-center justify-center text-white font-bold text-sm">
                                                        ${d.firstName.charAt(0)}${d.lastName.charAt(0)}
                                                    </div>
                                                    <span class="font-semibold text-gray-800">Dr. ${d.firstName} ${d.lastName}</span>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4">
                                                <span class="bg-blue-50 text-blue-700 px-2 py-1 rounded-lg text-xs font-medium">${d.hospitalName}</span>
                                            </td>
                                            <td class="px-6 py-4 text-gray-500">${d.email}</td>
                                            <td class="px-6 py-4 text-gray-500">${d.telephone}</td>
                                            <td class="px-6 py-4 text-gray-500 max-w-xs truncate">${d.address}</td>
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
