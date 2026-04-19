<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("loggedUser") == null ||
        !"Nurse".equals(((com.pms.model.User)session.getAttribute("loggedUser")).getUserType())) {
        response.sendRedirect(request.getContextPath() + "/login"); return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>PMS &mdash; My Patients</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100 min-h-screen">
<div class="flex min-h-screen">

    <%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

    <main class="flex-1 ml-64">
        <header class="bg-white shadow-sm px-8 py-4 flex items-center justify-between sticky top-0 z-10">
            <div>
                <h1 class="text-xl font-bold text-gray-800">My Patients</h1>
                <p class="text-gray-400 text-xs mt-0.5">Patients you have registered</p>
            </div>
            <a href="${pageContext.request.contextPath}/nurse/add-patient"
               class="bg-teal-600 hover:bg-teal-700 text-white text-sm font-medium px-4 py-2 rounded-xl flex items-center gap-2 transition">
                <i class="fas fa-user-plus"></i> Register Patient
            </a>
        </header>

        <div class="p-8">

            <c:if test="${not empty param.success}">
                <div class="mb-6 bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-xl flex items-center gap-3 text-sm">
                    <i class="fas fa-circle-check text-green-500"></i> ${param.success}
                </div>
            </c:if>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:choose>
                    <c:when test="${empty patients}">
                        <div class="col-span-3 bg-white rounded-2xl shadow-sm border border-gray-100 py-16 text-center text-gray-400">
                            <i class="fas fa-bed-pulse text-5xl mb-4 block opacity-30"></i>
                            No patients registered yet.
                            <br/>
                            <a href="${pageContext.request.contextPath}/nurse/add-patient" class="text-teal-600 underline mt-2 inline-block">Register your first patient.</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${patients}" var="p">
                            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition">
                                <!-- Photo -->
                                <div class="h-40 bg-gradient-to-br from-teal-50 to-blue-50 flex items-center justify-center">
                                    <img src="${pageContext.request.contextPath}/${p.pImageLink}"
                                         class="h-32 w-32 rounded-full object-cover border-4 border-white shadow"
                                         onerror="this.src='https://ui-avatars.com/api/?name=${p.firstName}+${p.lastName}&background=ccfbf1&color=0f766e&size=128'"/>
                                </div>
                                <!-- Info -->
                                <div class="p-5 text-center">
                                    <h3 class="font-bold text-gray-800 text-base">${p.firstName} ${p.lastName}</h3>
                                    <p class="text-gray-400 text-xs mt-1">${p.email}</p>
                                    <div class="flex justify-center gap-4 mt-3 text-xs text-gray-500">
                                        <span><i class="fas fa-phone text-teal-400 mr-1"></i>${p.telephone}</span>
                                    </div>
                                    <p class="text-gray-400 text-xs mt-1 truncate px-2">${p.address}</p>
                                    <a href="${pageContext.request.contextPath}/nurse/add-diagnosis?patientID=${p.patientID}"
                                       class="mt-4 inline-flex items-center gap-1 bg-violet-600 hover:bg-violet-700 text-white text-xs font-medium px-4 py-2 rounded-lg transition">
                                        <i class="fas fa-notes-medical"></i> Add Diagnosis
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>
</body>
</html>
