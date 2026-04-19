<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>PMS &mdash; Error</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center p-8">
    <div class="text-center max-w-md">
        <%
            Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
            String  errorMsg   = (String)  request.getAttribute("jakarta.servlet.error.message");
            int code = (statusCode != null) ? statusCode : 500;
        %>
        <div class="w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-6
            <%= code == 404 ? "bg-blue-100" : code == 403 ? "bg-amber-100" : "bg-red-100" %>">
            <i class="text-5xl
                <%= code == 404 ? "fas fa-map text-blue-400" : code == 403 ? "fas fa-lock text-amber-400" : "fas fa-triangle-exclamation text-red-400" %>"></i>
        </div>
        <h1 class="text-7xl font-extrabold text-gray-200 mb-2"><%= code %></h1>
        <h2 class="text-2xl font-bold text-gray-700 mb-3">
            <%= code == 404 ? "Page Not Found" : code == 403 ? "Access Denied" : "Server Error" %>
        </h2>
        <p class="text-gray-400 mb-8 text-sm">
            <%= code == 404 ? "The page you're looking for doesn't exist or has been moved."
              : code == 403 ? "You don't have permission to access this resource."
              : "Something went wrong on our end. Please try again." %>
        </p>
        <div class="flex justify-center gap-3">
            <a href="javascript:history.back()"
               class="bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold px-5 py-2.5 rounded-xl text-sm transition flex items-center gap-2">
                <i class="fas fa-arrow-left"></i> Go Back
            </a>
            <a href="${pageContext.request.contextPath}/login"
               class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-5 py-2.5 rounded-xl text-sm transition flex items-center gap-2">
                <i class="fas fa-house"></i> Home
            </a>
        </div>
    </div>
</body>
</html>
