<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>MediCare PMS &mdash; Patient Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        .hero-gradient { background: linear-gradient(135deg, #1d4ed8 0%, #0891b2 60%, #06b6d4 100%); }
        .card-hover { transition: transform 0.2s ease, box-shadow 0.2s ease; }
        .card-hover:hover { transform: translateY(-4px); box-shadow: 0 20px 40px rgba(0,0,0,0.10); }
        .fade-in { animation: fadeIn 0.8s ease both; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body class="bg-gray-50 text-gray-800 font-sans">

    <!-- ── Navigation ── -->
    <nav class="bg-white shadow-sm sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-blue-600 rounded-xl flex items-center justify-center">
                    <i class="fas fa-hospital-user text-white text-lg"></i>
                </div>
                <span class="text-xl font-extrabold text-blue-700">MediCare <span class="text-gray-700">PMS</span></span>
            </div>
            <a href="<%= request.getContextPath() %>/login"
               class="bg-blue-600 hover:bg-blue-700 text-white text-sm font-semibold px-5 py-2.5 rounded-xl transition flex items-center gap-2 shadow-md shadow-blue-200">
                <i class="fas fa-right-to-bracket"></i> Sign In
            </a>
        </div>
    </nav>

    <!-- ── Hero ── -->
    <section class="hero-gradient text-white py-24 px-6 relative overflow-hidden">
        <div class="absolute -top-24 -left-24 w-96 h-96 bg-white/5 rounded-full pointer-events-none"></div>
        <div class="absolute -bottom-20 -right-20 w-72 h-72 bg-white/5 rounded-full pointer-events-none"></div>

        <div class="relative max-w-4xl mx-auto text-center fade-in">
            <div class="w-24 h-24 bg-white/20 rounded-3xl flex items-center justify-center mx-auto mb-6 backdrop-blur">
                <i class="fas fa-hospital-user text-white text-5xl"></i>
            </div>
            <h1 class="text-5xl font-extrabold mb-4 leading-tight">MediCare Patient Management System</h1>
            <p class="text-blue-100 text-xl mb-10 max-w-2xl mx-auto">
                A unified digital platform designed to streamline hospital operations &mdash; from patient registration
                and medical records to diagnoses and staff coordination.
            </p>
            <div class="flex flex-col sm:flex-row gap-4 justify-center">
                <a href="<%= request.getContextPath() %>/login"
                   class="bg-white text-blue-700 hover:bg-blue-50 font-bold px-8 py-4 rounded-2xl text-lg transition shadow-xl flex items-center justify-center gap-3">
                    <i class="fas fa-right-to-bracket"></i> Get Started &mdash; Sign In
                </a>
                <a href="#features"
                   class="border-2 border-white/60 text-white hover:bg-white/10 font-semibold px-8 py-4 rounded-2xl text-lg transition flex items-center justify-center gap-3">
                    <i class="fas fa-circle-info"></i> Learn More
                </a>
            </div>
        </div>
    </section>

    <!-- ── Stats bar ── -->
    <section class="bg-white border-b border-gray-100 py-8 px-6">
        <div class="max-w-5xl mx-auto grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
            <div>
                <p class="text-3xl font-extrabold text-blue-600">4</p>
                <p class="text-gray-500 text-sm mt-1">User Roles</p>
            </div>
            <div>
                <p class="text-3xl font-extrabold text-blue-600">100%</p>
                <p class="text-gray-500 text-sm mt-1">Digital Records</p>
            </div>
            <div>
                <p class="text-3xl font-extrabold text-blue-600">24/7</p>
                <p class="text-gray-500 text-sm mt-1">System Access</p>
            </div>
            <div>
                <p class="text-3xl font-extrabold text-blue-600">Secure</p>
                <p class="text-gray-500 text-sm mt-1">Role-based Access</p>
            </div>
        </div>
    </section>

    <!-- ── What the system does ── -->
    <section id="features" class="py-20 px-6">
        <div class="max-w-6xl mx-auto">
            <div class="text-center mb-14">
                <span class="text-blue-600 font-semibold text-sm uppercase tracking-widest">Features</span>
                <h2 class="text-4xl font-extrabold mt-2 mb-4">Everything your hospital needs</h2>
                <p class="text-gray-500 max-w-xl mx-auto">MediCare PMS digitizes every key workflow in your facility so staff can focus on care, not paperwork.</p>
            </div>

            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">

                <div class="bg-white rounded-2xl p-7 shadow-sm border border-gray-100 card-hover">
                    <div class="w-12 h-12 bg-blue-50 rounded-xl flex items-center justify-center mb-5">
                        <i class="fas fa-user-plus text-blue-600 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-bold mb-2">Patient Registration</h3>
                    <p class="text-gray-500 text-sm leading-relaxed">Register new patients quickly with complete demographic and contact information stored securely in one place.</p>
                </div>

                <div class="bg-white rounded-2xl p-7 shadow-sm border border-gray-100 card-hover">
                    <div class="w-12 h-12 bg-cyan-50 rounded-xl flex items-center justify-center mb-5">
                        <i class="fas fa-notes-medical text-cyan-600 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-bold mb-2">Medical Records &amp; Diagnoses</h3>
                    <p class="text-gray-500 text-sm leading-relaxed">Nurses and doctors can record, update, and review patient diagnoses and medical history in real time.</p>
                </div>

                <div class="bg-white rounded-2xl p-7 shadow-sm border border-gray-100 card-hover">
                    <div class="w-12 h-12 bg-green-50 rounded-xl flex items-center justify-center mb-5">
                        <i class="fas fa-user-doctor text-green-600 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-bold mb-2">Doctor Management</h3>
                    <p class="text-gray-500 text-sm leading-relaxed">Admins can add and manage doctors, assign responsibilities, and track active cases handled by each physician.</p>
                </div>

                <div class="bg-white rounded-2xl p-7 shadow-sm border border-gray-100 card-hover">
                    <div class="w-12 h-12 bg-purple-50 rounded-xl flex items-center justify-center mb-5">
                        <i class="fas fa-user-nurse text-purple-600 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-bold mb-2">Nurse Coordination</h3>
                    <p class="text-gray-500 text-sm leading-relaxed">Doctors can register nurses under their supervision. Nurses handle patient intake and day-to-day care documentation.</p>
                </div>

                <div class="bg-white rounded-2xl p-7 shadow-sm border border-gray-100 card-hover">
                    <div class="w-12 h-12 bg-yellow-50 rounded-xl flex items-center justify-center mb-5">
                        <i class="fas fa-shield-halved text-yellow-600 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-bold mb-2">Role-based Security</h3>
                    <p class="text-gray-500 text-sm leading-relaxed">Every user sees only what their role permits. Admins, doctors, nurses and patients each have dedicated, protected dashboards.</p>
                </div>

                <div class="bg-white rounded-2xl p-7 shadow-sm border border-gray-100 card-hover">
                    <div class="w-12 h-12 bg-red-50 rounded-xl flex items-center justify-center mb-5">
                        <i class="fas fa-chart-line text-red-500 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-bold mb-2">Dashboard &amp; Overviews</h3>
                    <p class="text-gray-500 text-sm leading-relaxed">Role-specific dashboards surface the most important information at a glance so decisions are fast and informed.</p>
                </div>

            </div>
        </div>
    </section>

    <!-- ── Who the system helps ── -->
    <section class="bg-gradient-to-br from-blue-50 to-cyan-50 py-20 px-6">
        <div class="max-w-6xl mx-auto">
            <div class="text-center mb-14">
                <span class="text-blue-600 font-semibold text-sm uppercase tracking-widest">Who it helps</span>
                <h2 class="text-4xl font-extrabold mt-2 mb-4">Built for every role in your hospital</h2>
                <p class="text-gray-500 max-w-xl mx-auto">MediCare PMS is designed so each stakeholder gets exactly the tools they need.</p>
            </div>

            <div class="grid sm:grid-cols-2 lg:grid-cols-4 gap-6">

                <div class="bg-white rounded-2xl p-8 text-center shadow-sm border border-blue-100 card-hover">
                    <div class="w-16 h-16 bg-blue-600 rounded-2xl flex items-center justify-center mx-auto mb-5">
                        <i class="fas fa-user-shield text-white text-2xl"></i>
                    </div>
                    <h3 class="text-lg font-bold mb-2 text-blue-700">Administrators</h3>
                    <p class="text-gray-500 text-sm leading-relaxed">Full oversight of the system &mdash; manage doctors, monitor activity, and configure the platform.</p>
                </div>

                <div class="bg-white rounded-2xl p-8 text-center shadow-sm border border-green-100 card-hover">
                    <div class="w-16 h-16 bg-green-600 rounded-2xl flex items-center justify-center mx-auto mb-5">
                        <i class="fas fa-user-doctor text-white text-2xl"></i>
                    </div>
                    <h3 class="text-lg font-bold mb-2 text-green-700">Doctors</h3>
                    <p class="text-gray-500 text-sm leading-relaxed">Manage assigned nurses and cases, review patient records, and enter clinical findings efficiently.</p>
                </div>

                <div class="bg-white rounded-2xl p-8 text-center shadow-sm border border-purple-100 card-hover">
                    <div class="w-16 h-16 bg-purple-600 rounded-2xl flex items-center justify-center mx-auto mb-5">
                        <i class="fas fa-user-nurse text-white text-2xl"></i>
                    </div>
                    <h3 class="text-lg font-bold mb-2 text-purple-700">Nurses</h3>
                    <p class="text-gray-500 text-sm leading-relaxed">Register patients, record diagnoses, and keep patient care logs updated throughout each shift.</p>
                </div>

                <div class="bg-white rounded-2xl p-8 text-center shadow-sm border border-cyan-100 card-hover">
                    <div class="w-16 h-16 bg-cyan-600 rounded-2xl flex items-center justify-center mx-auto mb-5">
                        <i class="fas fa-bed-pulse text-white text-2xl"></i>
                    </div>
                    <h3 class="text-lg font-bold mb-2 text-cyan-700">Patients</h3>
                    <p class="text-gray-500 text-sm leading-relaxed">View personal health records and diagnosis history through a secure, read-only patient portal.</p>
                </div>

            </div>
        </div>
    </section>

    <!-- ── Call to action ── -->
    <section class="hero-gradient text-white py-20 px-6 text-center">
        <div class="max-w-2xl mx-auto">
            <h2 class="text-4xl font-extrabold mb-4">Ready to get started?</h2>
            <p class="text-blue-100 text-lg mb-10">Sign in with your credentials to access your personalised dashboard.</p>
            <a href="<%= request.getContextPath() %>/login"
               class="inline-flex items-center gap-3 bg-white text-blue-700 hover:bg-blue-50 font-bold px-10 py-4 rounded-2xl text-lg transition shadow-2xl">
                <i class="fas fa-right-to-bracket"></i> Sign In Now
            </a>
        </div>
    </section>

    <!-- ── Footer ── -->
    <footer class="bg-gray-900 text-gray-400 py-8 px-6 text-center text-sm">
        <div class="flex items-center justify-center gap-2 mb-2">
            <div class="w-7 h-7 bg-blue-600 rounded-lg flex items-center justify-center">
                <i class="fas fa-hospital-user text-white text-xs"></i>
            </div>
            <span class="text-white font-bold">MediCare PMS</span>
        </div>
        <p>&copy; 2026 MediCare Patient Management System. All rights reserved.</p>
    </footer>

</body>
</html>
