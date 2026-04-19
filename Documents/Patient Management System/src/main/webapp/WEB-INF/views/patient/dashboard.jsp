<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("loggedUser") == null ||
        !"Patient".equals(((com.pms.model.User)session.getAttribute("loggedUser")).getUserType())) {
        response.sendRedirect(request.getContextPath() + "/login"); return;
    }
    com.pms.model.Patient patient = (com.pms.model.Patient) session.getAttribute("loggedPatient");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>PMS &mdash; My Results</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100 min-h-screen">
<div class="flex min-h-screen">

    <%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

    <main class="flex-1 ml-64">
        <header class="bg-white shadow-sm px-8 py-4 sticky top-0 z-10">
            <h1 class="text-xl font-bold text-gray-800">My Health Results</h1>
            <p class="text-gray-400 text-xs mt-0.5">View your diagnosis history and results</p>
        </header>

        <div class="p-8">

            <!-- Patient hero card -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-8 flex items-center gap-6">
                <img src="${pageContext.request.contextPath}/<%= patient != null ? patient.getPImageLink() : "images/default.png" %>"
                     class="w-24 h-24 rounded-2xl object-cover border-4 border-blue-100 shadow"
                     onerror="this.src='https://ui-avatars.com/api/?name=<%= patient != null ? patient.getFirstName() : "P" %>+<%= patient != null ? patient.getLastName() : "" %>&background=dbeafe&color=1d4ed8&size=96'"/>
                <div>
                    <h2 class="text-2xl font-bold text-gray-800"><%= patient != null ? patient.getFullName() : "" %></h2>
                    <p class="text-gray-500 text-sm mt-1"><i class="fas fa-envelope text-blue-400 mr-2"></i><%= patient != null ? patient.getEmail() : "" %></p>
                    <p class="text-gray-500 text-sm mt-0.5"><i class="fas fa-phone text-blue-400 mr-2"></i><%= patient != null ? patient.getTelephone() : "" %></p>
                    <p class="text-gray-500 text-sm mt-0.5"><i class="fas fa-location-dot text-blue-400 mr-2"></i><%= patient != null ? patient.getAddress() : "" %></p>
                </div>
            </div>

            <!-- Diagnoses -->
            <h2 class="text-lg font-bold text-gray-800 mb-4">Diagnosis Records</h2>

            <c:choose>
                <c:when test="${empty diagnoses}">
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 py-16 text-center text-gray-400">
                        <i class="fas fa-file-medical text-5xl mb-4 block opacity-30"></i>
                        No diagnosis records found.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="space-y-4">
                        <c:forEach items="${diagnoses}" var="dx">
                            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                                <div class="flex items-start justify-between gap-4">
                                    <div class="flex-1">
                                        <!-- Status badge -->
                                        <div class="flex items-center gap-3 mb-3">
                                            <c:choose>
                                                <c:when test="${dx.diagnosisStatus == 'Referrable'}">
                                                    <span class="bg-orange-100 text-orange-700 text-xs font-semibold px-3 py-1 rounded-full">
                                                        <i class="fas fa-triangle-exclamation mr-1"></i>Referrable
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="bg-gray-100 text-gray-600 text-xs font-semibold px-3 py-1 rounded-full">
                                                        <i class="fas fa-minus-circle mr-1"></i>Not Referrable
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="text-gray-300 text-xs">${dx.createdAt}</span>
                                        </div>

                                        <!-- Nurse info -->
                                        <p class="text-gray-500 text-sm mb-1">
                                            <i class="fas fa-user-nurse text-teal-400 w-4"></i>
                                            Diagnosed by: <span class="font-medium text-gray-700">${dx.nurseName}</span>
                                        </p>
                                        <c:if test="${not empty dx.doctorName && dx.doctorName != ' '}">
                                            <p class="text-gray-500 text-sm">
                                                <i class="fas fa-user-doctor text-blue-400 w-4"></i>
                                                Reviewing doctor: <span class="font-medium text-gray-700">Dr. ${dx.doctorName}</span>
                                            </p>
                                        </c:if>
                                    </div>

                                    <!-- Result box -->
                                    <div class="flex-shrink-0 text-right">
                                        <c:choose>
                                            <c:when test="${dx.result == 'Pending'}">
                                                <div class="bg-amber-50 border border-amber-200 rounded-xl px-5 py-4 text-center">
                                                    <i class="fas fa-clock text-amber-500 text-2xl mb-1 block"></i>
                                                    <p class="text-amber-700 font-bold text-sm">Pending</p>
                                                    <p class="text-amber-500 text-xs">Awaiting doctor review</p>
                                                </div>
                                            </c:when>
                                            <c:when test="${dx.result == 'Negative'}">
                                                <div class="bg-gray-50 border border-gray-200 rounded-xl px-5 py-4 text-center">
                                                    <i class="fas fa-circle-xmark text-gray-400 text-2xl mb-1 block"></i>
                                                    <p class="text-gray-700 font-bold text-sm">Negative</p>
                                                    <p class="text-gray-400 text-xs">No referral needed</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-green-50 border border-green-200 rounded-xl px-5 py-4 text-center max-w-xs">
                                                    <i class="fas fa-circle-check text-green-500 text-2xl mb-1 block"></i>
                                                    <p class="text-green-700 font-bold text-sm">Confirmed</p>
                                                    <p class="text-gray-600 text-xs mt-1 text-left">${dx.result}</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>
</body>
</html>
