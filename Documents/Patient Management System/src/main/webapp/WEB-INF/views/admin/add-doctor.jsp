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
    <title>PMS &mdash; Add Doctor</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100 min-h-screen">
<div class="flex min-h-screen">

    <%@ include file="/WEB-INF/views/includes/sidebar.jsp" %>

    <main class="flex-1 ml-64 min-w-0">
        <header class="bg-white shadow-sm px-8 py-4 flex items-center gap-3 sticky top-0 z-10">
            <a href="${pageContext.request.contextPath}/admin/doctors" class="text-gray-400 hover:text-gray-600 transition">
                <i class="fas fa-arrow-left"></i>
            </a>
            <div>
                <h1 class="text-xl font-bold text-gray-800">Register Doctor</h1>
                <p class="text-gray-400 text-xs mt-0.5">Create a new doctor account</p>
            </div>
        </header>

        <div class="p-8 max-w-3xl">

            <c:if test="${not empty requestScope.error}">
                <div class="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl flex items-center gap-3 text-sm">
                    <i class="fas fa-circle-exclamation text-red-500"></i> ${requestScope.error}
                </div>
            </c:if>

            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8">
                <form action="${pageContext.request.contextPath}/admin/add-doctor" method="post" class="space-y-6">

                    <!-- Login credentials -->
                    <div>
                        <h3 class="text-sm font-bold text-gray-500 uppercase tracking-wider mb-4 flex items-center gap-2">
                            <i class="fas fa-key text-blue-400"></i> Login Credentials
                        </h3>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Username <span class="text-red-500">*</span></label>
                                <input type="text" name="username" required
                                       class="w-full px-4 py-2.5 border border-gray-300 rounded-xl bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                                       placeholder="e.g. dr_smith"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Password <span class="text-red-500">*</span></label>
                                <input type="password" name="password" required
                                       class="w-full px-4 py-2.5 border border-gray-300 rounded-xl bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                                       placeholder="Minimum 6 characters"/>
                            </div>
                        </div>
                    </div>

                    <hr class="border-gray-100"/>

                    <!-- Personal info -->
                    <div>
                        <h3 class="text-sm font-bold text-gray-500 uppercase tracking-wider mb-4 flex items-center gap-2">
                            <i class="fas fa-user text-blue-400"></i> Personal Information
                        </h3>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1.5">First Name <span class="text-red-500">*</span></label>
                                <input type="text" name="firstName" required
                                       class="w-full px-4 py-2.5 border border-gray-300 rounded-xl bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                                       placeholder="First name"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Last Name <span class="text-red-500">*</span></label>
                                <input type="text" name="lastName" required
                                       class="w-full px-4 py-2.5 border border-gray-300 rounded-xl bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                                       placeholder="Last name"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Telephone</label>
                                <input type="tel" name="telephone"
                                       class="w-full px-4 py-2.5 border border-gray-300 rounded-xl bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                                       placeholder="+250 7XX XXX XXX"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Email</label>
                                <input type="email" name="email"
                                       class="w-full px-4 py-2.5 border border-gray-300 rounded-xl bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                                       placeholder="doctor@hospital.com"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Hospital Name <span class="text-red-500">*</span></label>
                                <input type="text" name="hospitalName" required
                                       class="w-full px-4 py-2.5 border border-gray-300 rounded-xl bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                                       placeholder="e.g. King Faisal Hospital"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Address</label>
                                <input type="text" name="address"
                                       class="w-full px-4 py-2.5 border border-gray-300 rounded-xl bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                                       placeholder="City, Country"/>
                            </div>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="flex gap-3 pt-2">
                        <button type="submit"
                                class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2.5 rounded-xl transition flex items-center gap-2 text-sm shadow-lg shadow-blue-100">
                            <i class="fas fa-user-plus"></i> Register Doctor
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/doctors"
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
