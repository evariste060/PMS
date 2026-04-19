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
    <title>PMS &mdash; Add Diagnosis</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100 min-h-screen">
<div class="flex min-h-screen">

    <%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

    <main class="flex-1 ml-64">
        <header class="bg-white shadow-sm px-8 py-4 flex items-center gap-3 sticky top-0 z-10">
            <a href="${pageContext.request.contextPath}/nurse/dashboard" class="text-gray-400 hover:text-gray-600 transition">
                <i class="fas fa-arrow-left"></i>
            </a>
            <div>
                <h1 class="text-xl font-bold text-gray-800">Add Diagnosis</h1>
                <p class="text-gray-400 text-xs mt-0.5">Submit a diagnosis for one of your patients</p>
            </div>
        </header>

        <div class="p-8 max-w-2xl">

            <c:if test="${not empty requestScope.error}">
                <div class="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl flex items-center gap-3 text-sm">
                    <i class="fas fa-circle-exclamation text-red-500"></i> ${requestScope.error}
                </div>
            </c:if>

            <!-- Info banner -->
            <div class="bg-violet-50 border border-violet-200 rounded-xl p-4 mb-6 text-sm text-violet-800 flex items-start gap-3">
                <i class="fas fa-circle-info text-violet-500 mt-0.5 flex-shrink-0"></i>
                <div>
                    <strong>Diagnosis Rules:</strong><br/>
                    &bull; <strong>Referrable</strong> &rarr; result will be set to <em>Pending</em> until the doctor writes it.<br/>
                    &bull; <strong>Not Referrable</strong> &rarr; result is set to <em>Negative</em> immediately.
                </div>
            </div>

            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8">
                <form action="${pageContext.request.contextPath}/nurse/add-diagnosis" method="post" class="space-y-6">

                    <!-- Patient select -->
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">
                            Select Patient <span class="text-red-500">*</span>
                        </label>
                        <c:choose>
                            <c:when test="${empty patients}">
                                <div class="bg-amber-50 border border-amber-200 text-amber-800 px-4 py-3 rounded-xl text-sm">
                                    <i class="fas fa-triangle-exclamation mr-2"></i>
                                    You have no patients registered yet.
                                    <a href="${pageContext.request.contextPath}/nurse/add-patient" class="underline font-semibold">Register one first.</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <select name="patientID" required
                                        class="w-full px-4 py-2.5 border border-gray-300 rounded-xl bg-white focus:outline-none focus:ring-2 focus:ring-violet-500 text-sm text-gray-800">
                                    <option value="" disabled selected>— Choose patient —</option>
                                    <c:forEach items="${patients}" var="p">
                                        <option value="${p.patientID}"
                                            <c:if test="${param.patientID == p.patientID}">selected</c:if>>
                                            ${p.firstName} ${p.lastName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Status selection -->
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-3">
                            Diagnosis Status <span class="text-red-500">*</span>
                        </label>
                        <div class="grid grid-cols-2 gap-4">
                            <!-- Referrable -->
                            <label class="relative flex flex-col items-center gap-3 border-2 border-gray-200 rounded-2xl p-5 cursor-pointer hover:border-orange-400 hover:bg-orange-50 transition has-[:checked]:border-orange-500 has-[:checked]:bg-orange-50">
                                <input type="radio" name="diagnosisStatus" value="Referrable" required class="sr-only"/>
                                <div class="w-12 h-12 bg-orange-100 rounded-xl flex items-center justify-center">
                                    <i class="fas fa-triangle-exclamation text-orange-500 text-xl"></i>
                                </div>
                                <div class="text-center">
                                    <p class="font-bold text-gray-800 text-sm">Referrable</p>
                                    <p class="text-gray-400 text-xs mt-0.5">Needs doctor review</p>
                                </div>
                            </label>
                            <!-- Not Referrable -->
                            <label class="relative flex flex-col items-center gap-3 border-2 border-gray-200 rounded-2xl p-5 cursor-pointer hover:border-green-400 hover:bg-green-50 transition has-[:checked]:border-green-500 has-[:checked]:bg-green-50">
                                <input type="radio" name="diagnosisStatus" value="Not Referrable" required class="sr-only"/>
                                <div class="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center">
                                    <i class="fas fa-circle-check text-green-500 text-xl"></i>
                                </div>
                                <div class="text-center">
                                    <p class="font-bold text-gray-800 text-sm">Not Referrable</p>
                                    <p class="text-gray-400 text-xs mt-0.5">Result: Negative</p>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="flex gap-3 pt-2">
                        <c:if test="${not empty patients}">
                            <button type="submit"
                                    class="bg-violet-600 hover:bg-violet-700 text-white font-semibold px-6 py-2.5 rounded-xl transition flex items-center gap-2 text-sm">
                                <i class="fas fa-notes-medical"></i> Submit Diagnosis
                            </button>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/nurse/dashboard"
                           class="bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold px-6 py-2.5 rounded-xl transition text-sm">
                            Cancel
                        </a>
                    </div>

                </form>
            </div>
        </div>
    </main>
</div>
</body>
</html>
