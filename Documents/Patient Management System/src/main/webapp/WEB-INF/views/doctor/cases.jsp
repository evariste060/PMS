<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("loggedUser") == null ||
        !"Doctor".equals(((com.pms.model.User)session.getAttribute("loggedUser")).getUserType())) {
        response.sendRedirect(request.getContextPath() + "/login"); return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>PMS &mdash; Patient Cases</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100 min-h-screen">
<div class="flex min-h-screen">

    <%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

    <main class="flex-1 ml-64">
        <header class="bg-white shadow-sm px-8 py-4 sticky top-0 z-10">
            <h1 class="text-xl font-bold text-gray-800">Patient Cases</h1>
            <p class="text-gray-400 text-xs mt-0.5">All cases in your hospital. Update results for referrable cases.</p>
        </header>

        <div class="p-8">

            <c:if test="${not empty param.success}">
                <div class="mb-6 bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-xl flex items-center gap-3 text-sm">
                    <i class="fas fa-circle-check text-green-500"></i> ${param.success}
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl flex items-center gap-3 text-sm">
                    <i class="fas fa-circle-exclamation text-red-500"></i> ${param.error}
                </div>
            </c:if>

            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="px-6 py-4 border-b border-gray-100">
                    <h2 class="font-bold text-gray-800 flex items-center gap-2">
                        <i class="fas fa-stethoscope text-blue-500"></i> All Cases
                    </h2>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead>
                            <tr class="bg-gray-50 text-gray-500 text-xs uppercase border-b border-gray-100">
                                <th class="px-4 py-3 text-left font-semibold">Patient</th>
                                <th class="px-4 py-3 text-left font-semibold">Nurse</th>
                                <th class="px-4 py-3 text-left font-semibold">Status</th>
                                <th class="px-4 py-3 text-left font-semibold">Result</th>
                                <th class="px-4 py-3 text-left font-semibold">Date</th>
                                <th class="px-4 py-3 text-left font-semibold">Action</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                            <c:choose>
                                <c:when test="${empty diagnoses}">
                                    <tr><td colspan="6" class="py-12 text-center text-gray-400">
                                        <i class="fas fa-clipboard text-4xl mb-3 block opacity-30"></i>
                                        No cases recorded yet.
                                    </td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${diagnoses}" var="dx">
                                        <tr class="hover:bg-gray-50 transition-colors">

                                            <!-- Patient -->
                                            <td class="px-4 py-4">
                                                <div class="flex items-center gap-3">
                                                    <img src="${pageContext.request.contextPath}/${dx.patientImage}"
                                                         class="w-9 h-9 rounded-full object-cover bg-gray-100"
                                                         onerror="this.src='https://ui-avatars.com/api/?name=${dx.patientName}&background=dbeafe&color=1d4ed8&size=36'"/>
                                                    <span class="font-medium text-gray-800">${dx.patientName}</span>
                                                </div>
                                            </td>

                                            <!-- Nurse -->
                                            <td class="px-4 py-4 text-gray-600">${dx.nurseName}</td>

                                            <!-- Status badge -->
                                            <td class="px-4 py-4">
                                                <c:choose>
                                                    <c:when test="${dx.diagnosisStatus == 'Referrable'}">
                                                        <span class="bg-orange-100 text-orange-700 text-xs font-semibold px-2.5 py-1 rounded-full">Referrable</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="bg-gray-100 text-gray-600 text-xs font-semibold px-2.5 py-1 rounded-full">Not Referrable</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <!-- Result -->
                                            <td class="px-4 py-4">
                                                <c:choose>
                                                    <c:when test="${dx.result == 'Pending'}">
                                                        <span class="bg-amber-100 text-amber-700 text-xs font-semibold px-2.5 py-1 rounded-full">
                                                            <i class="fas fa-clock mr-1"></i>Pending
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${dx.result == 'Negative'}">
                                                        <span class="bg-gray-100 text-gray-600 text-xs font-semibold px-2.5 py-1 rounded-full">
                                                            <i class="fas fa-minus-circle mr-1"></i>Negative
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="bg-green-100 text-green-700 text-xs font-semibold px-2.5 py-1 rounded-full">
                                                            <i class="fas fa-check-circle mr-1"></i>Confirmed
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <!-- Date -->
                                            <td class="px-4 py-4 text-gray-400 text-xs">${dx.createdAt}</td>

                                            <!-- Update result (only for Referrable + Pending) -->
                                            <td class="px-4 py-4">
                                                <c:if test="${dx.diagnosisStatus == 'Referrable' && dx.result == 'Pending'}">
                                                    <form action="${pageContext.request.contextPath}/diagnosis/update" method="post"
                                                          class="flex items-center gap-2">
                                                        <input type="hidden" name="diagnosisID" value="${dx.diagnosisID}"/>
                                                        <input type="text" name="result" required
                                                               placeholder="Enter diagnosis result…"
                                                               class="border border-gray-300 rounded-lg px-3 py-1.5 text-xs focus:outline-none focus:ring-2 focus:ring-blue-400 w-44"/>
                                                        <button type="submit"
                                                                class="bg-blue-600 hover:bg-blue-700 text-white text-xs font-medium px-3 py-1.5 rounded-lg transition">
                                                            <i class="fas fa-paper-plane"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${dx.diagnosisStatus != 'Referrable' || dx.result != 'Pending'}">
                                                    <span class="text-gray-300 text-xs italic">—</span>
                                                </c:if>
                                            </td>

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
