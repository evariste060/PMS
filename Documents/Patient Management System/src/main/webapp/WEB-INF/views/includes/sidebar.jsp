<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<aside class="fixed inset-y-0 left-0 w-64 bg-slate-900 flex flex-col z-20 shadow-xl">

    <!-- Logo -->
    <div class="flex items-center gap-3 px-6 py-5 border-b border-slate-700">
        <div class="w-10 h-10 bg-blue-500 rounded-xl flex items-center justify-center flex-shrink-0">
            <i class="fas fa-hospital-user text-white text-lg"></i>
        </div>
        <div>
            <p class="text-white font-bold text-sm leading-tight">MediCare PMS</p>
            <p class="text-blue-400 text-xs">${sessionScope.loggedUser.userType} Portal</p>
        </div>
    </div>

    <!-- Nav links -->
    <nav class="flex-1 px-3 py-4 space-y-1 overflow-y-auto">
        <p class="text-slate-500 text-xs font-semibold uppercase px-3 mb-2 tracking-wider">Navigation</p>

        <c:choose>

            <%-- ── Admin ── --%>
            <c:when test="${sessionScope.loggedUser.userType == 'Admin'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-gauge w-5 text-center text-slate-400"></i> Dashboard
                </a>
                <p class="text-slate-500 text-xs font-semibold uppercase px-3 pt-3 pb-1 tracking-wider">Staff</p>
                <a href="${pageContext.request.contextPath}/admin/doctors"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-user-doctor w-5 text-center text-slate-400"></i> Doctors
                </a>
                <a href="${pageContext.request.contextPath}/admin/nurses"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-user-nurse w-5 text-center text-slate-400"></i> Nurses
                </a>
                <a href="${pageContext.request.contextPath}/admin/add-doctor"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-user-plus w-5 text-center text-slate-400"></i> Add Doctor
                </a>
                <p class="text-slate-500 text-xs font-semibold uppercase px-3 pt-3 pb-1 tracking-wider">Records</p>
                <a href="${pageContext.request.contextPath}/admin/patients"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-bed-pulse w-5 text-center text-slate-400"></i> Patients
                </a>
                <a href="${pageContext.request.contextPath}/admin/diagnoses"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-notes-medical w-5 text-center text-slate-400"></i> Diagnoses
                </a>
            </c:when>

            <%-- ── Doctor ── --%>
            <c:when test="${sessionScope.loggedUser.userType == 'Doctor'}">
                <a href="${pageContext.request.contextPath}/doctor/dashboard"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-gauge w-5 text-center text-slate-400"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/doctor/nurses"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-user-nurse w-5 text-center text-slate-400"></i> My Nurses
                </a>
                <a href="${pageContext.request.contextPath}/doctor/add-nurse"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-user-plus w-5 text-center text-slate-400"></i> Add Nurse
                </a>
                <a href="${pageContext.request.contextPath}/doctor/cases"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-stethoscope w-5 text-center text-slate-400"></i> Patient Cases
                </a>
            </c:when>

            <%-- ── Nurse ── --%>
            <c:when test="${sessionScope.loggedUser.userType == 'Nurse'}">
                <a href="${pageContext.request.contextPath}/nurse/dashboard"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-gauge w-5 text-center text-slate-400"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/nurse/patients"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-bed-pulse w-5 text-center text-slate-400"></i> My Patients
                </a>
                <a href="${pageContext.request.contextPath}/nurse/add-patient"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-user-plus w-5 text-center text-slate-400"></i> Register Patient
                </a>
                <a href="${pageContext.request.contextPath}/nurse/add-diagnosis"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-notes-medical w-5 text-center text-slate-400"></i> Add Diagnosis
                </a>
            </c:when>

            <%-- ── Patient ── --%>
            <c:when test="${sessionScope.loggedUser.userType == 'Patient'}">
                <a href="${pageContext.request.contextPath}/patient/dashboard"
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-700 hover:text-white transition-colors text-sm font-medium">
                    <i class="fas fa-file-medical w-5 text-center text-slate-400"></i> My Results
                </a>
            </c:when>

        </c:choose>
    </nav>

    <!-- User info + logout -->
    <div class="px-4 py-4 border-t border-slate-700">
        <div class="flex items-center gap-3 mb-3">
            <div class="w-9 h-9 rounded-full bg-blue-600 flex items-center justify-center flex-shrink-0">
                <i class="fas fa-user text-white text-sm"></i>
            </div>
            <div class="overflow-hidden">
                <p class="text-white text-sm font-semibold truncate">${sessionScope.loggedUser.username}</p>
                <p class="text-slate-400 text-xs">${sessionScope.loggedUser.userType}</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/logout"
           class="flex items-center gap-2 w-full px-3 py-2 rounded-lg text-slate-400 hover:text-red-400 hover:bg-red-900/20 text-sm transition-colors">
            <i class="fas fa-right-from-bracket"></i> Sign Out
        </a>
    </div>
</aside>
