# Patient Management System (PMS)

A web-based hospital patient management system built with Java Servlets, JSP, and MySQL. It supports role-based access for Admins, Doctors, Nurses, and Patients.

## Features

- **Admin** — manage doctors, view system data
- **Doctor** — manage assigned nurses, view patient cases and diagnoses
- **Nurse** — register patients, record diagnoses, assign cases to doctors
- **Patient** — view personal dashboard and diagnosis results
- Role-based authentication with session management
- Patient photo upload support
- Diagnosis workflow: Referrable → Doctor review / Not Referrable → Negative result

## Tech Stack

| Layer      | Technology                        |
|------------|-----------------------------------|
| Backend    | Java 17, Jakarta Servlets, JSP    |
| Frontend   | HTML, CSS, JavaScript (JSTL)      |
| Database   | MySQL 8                           |
| Build      | Maven (WAR packaging)             |
| Server     | Apache Tomcat 10                  |

## Project Structure

```
src/
├── main/
│   ├── java/com/pms/
│   │   ├── dao/          # Data Access Objects (DB queries)
│   │   ├── filter/       # Auth filter (session guard)
│   │   ├── model/        # Plain Java models (User, Doctor, Nurse, Patient, Diagnosis)
│   │   ├── servlet/      # HTTP request handlers
│   │   └── util/         # DBConnection, FileUpload, PasswordUtil
│   ├── resources/
│   │   └── database.sql  # Full schema + default admin seed
│   └── webapp/
│       ├── WEB-INF/views/  # JSP pages (admin, doctor, nurse, patient views)
│       ├── css/
│       ├── js/
│       └── images/
pom.xml
```

## Getting Started

### Prerequisites

- Java 17+
- Apache Maven 3.8+
- Apache Tomcat 10+
- MySQL 8+

### 1. Database Setup

Open MySQL (or phpMyAdmin) and run the schema file:

```sql
source src/main/resources/database.sql
```

This creates the `PMS` database, all tables, and a default admin account.

**Default admin credentials:**
```
Username: admin
Password: admin123
```

### 2. Configure Database Connection

Edit `src/main/java/com/pms/util/DBConnection.java` and set your MySQL credentials:

```java
private static final String URL      = "jdbc:mysql://localhost:3306/PMS?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
private static final String USER     = "root";       // your MySQL username
private static final String PASSWORD = "";            // your MySQL password
```

### 3. Build

```bash
mvn clean package
```

This produces `target/PatientManagementSystem.war`.

### 4. Deploy

Copy the WAR file to your Tomcat `webapps/` directory and start Tomcat:

```bash
cp target/PatientManagementSystem.war $TOMCAT_HOME/webapps/
$TOMCAT_HOME/bin/startup.sh
```

Then open your browser at:

```
http://localhost:8080/PatientManagementSystem
```

## Database Schema

```
Users ──┬── Doctors ──── Nurses ──── Patients
        │                              │
        └──────────────────────────────┘
                                       │
                                   Diagnosis
```

- `Users` is the master auth table; each role has a linked profile table.
- `Diagnosis` links a Patient, a Nurse (who recorded it), and optionally a Doctor (if referrable).

## Feedback & Contributions

Feedback and pull requests are welcome! To contribute:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m "Add your feature"`
4. Push to your fork: `git push origin feature/your-feature`
5. Open a Pull Request and describe what you changed and why

Please open an **Issue** if you find a bug or have a suggestion for improvement.

## Known Limitations / Areas for Improvement

- Passwords are hashed with MD5 — consider upgrading to bcrypt
- No email notifications yet
- No REST API (pure Servlet/JSP MVC only)
- No unit/integration test coverage yet

## Author

**Evariste Nkurunziza**  
University of Rwanda  
nkurunziza_224003322@stud.ur.ac.rw
