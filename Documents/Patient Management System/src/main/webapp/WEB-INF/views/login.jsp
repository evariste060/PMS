<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>PMS &mdash; Sign In</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="min-h-screen flex">

    <!-- ── Left panel: branding ── -->
    <div class="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-blue-700 via-blue-600 to-cyan-500 flex-col items-center justify-center p-14 relative overflow-hidden">
        <!-- decorative circles -->
        <div class="absolute -top-20 -left-20 w-80 h-80 bg-white/5 rounded-full"></div>
        <div class="absolute -bottom-16 -right-16 w-64 h-64 bg-white/5 rounded-full"></div>

        <div class="relative z-10 text-center">
            <div class="w-24 h-24 bg-white/20 rounded-3xl flex items-center justify-center mx-auto mb-6 backdrop-blur">
                <i class="fas fa-hospital-user text-white text-5xl"></i>
            </div>
            <h1 class="text-4xl font-extrabold text-white mb-3">MediCare PMS</h1>
            <p class="text-blue-100 text-lg mb-8">Patient Management System</p>

            <div class="grid grid-cols-2 gap-4 text-center">
                <div class="bg-white/10 rounded-2xl p-4 backdrop-blur">
                    <i class="fas fa-user-doctor text-blue-200 text-2xl mb-1"></i>
                    <p class="text-white text-sm font-medium">Doctors</p>
                </div>
                <div class="bg-white/10 rounded-2xl p-4 backdrop-blur">
                    <i class="fas fa-user-nurse text-blue-200 text-2xl mb-1"></i>
                    <p class="text-white text-sm font-medium">Nurses</p>
                </div>
                <div class="bg-white/10 rounded-2xl p-4 backdrop-blur">
                    <i class="fas fa-bed-pulse text-blue-200 text-2xl mb-1"></i>
                    <p class="text-white text-sm font-medium">Patients</p>
                </div>
                <div class="bg-white/10 rounded-2xl p-4 backdrop-blur">
                    <i class="fas fa-notes-medical text-blue-200 text-2xl mb-1"></i>
                    <p class="text-white text-sm font-medium">Diagnoses</p>
                </div>
            </div>
        </div>
    </div>

    <!-- ── Right panel: login form ── -->
    <div class="w-full lg:w-1/2 flex items-center justify-center p-8 bg-gray-50">
        <div class="w-full max-w-md">

            <!-- Mobile logo -->
            <div class="lg:hidden flex justify-center mb-8">
                <div class="w-16 h-16 bg-blue-600 rounded-2xl flex items-center justify-center">
                    <i class="fas fa-hospital-user text-white text-3xl"></i>
                </div>
            </div>

            <h2 class="text-3xl font-bold text-gray-800 mb-1">Welcome back</h2>
            <p class="text-gray-500 mb-8 text-sm">Sign in to your account to continue</p>

            <!-- Error message -->
            <c:if test="${not empty requestScope.error}">
                <div class="mb-5 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl flex items-center gap-3 text-sm">
                    <i class="fas fa-circle-exclamation flex-shrink-0"></i>
                    <span>${requestScope.error}</span>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-5">

                <!-- Username -->
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">Username</label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-gray-400">
                            <i class="fas fa-user text-sm"></i>
                        </span>
                        <input type="text" name="username" required autocomplete="username"
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-xl bg-white text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition"
                               placeholder="Enter your username"/>
                    </div>
                </div>

                <!-- Password -->
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">Password</label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-gray-400">
                            <i class="fas fa-lock text-sm"></i>
                        </span>
                        <input type="password" name="password" required autocomplete="current-password"
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-xl bg-white text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition"
                               placeholder="Enter your password"/>
                    </div>
                </div>

                <!-- Submit -->
                <button type="submit"
                        class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-xl transition flex items-center justify-center gap-2 shadow-lg shadow-blue-200">
                    <i class="fas fa-right-to-bracket"></i> Sign In
                </button>
            </form>

            <p class="mt-8 text-center text-xs text-gray-400">
                Default admin &mdash; username: <span class="font-semibold text-gray-600">admin</span>
                &nbsp;/&nbsp; password: <span class="font-semibold text-gray-600">admin123</span>
            </p>
        </div>
    </div>

</body>
</html>
