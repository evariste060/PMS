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

| Layer      | Technology                              |
|------------|-----------------------------------------|
| Backend    | Java 17, Jakarta Servlets, JSP          |
| Frontend   | HTML, Tailwind CSS, JavaScript (JSTL)   |
| Database   | MySQL 8 (via XAMPP)                     |
| Build      | Maven (WAR packaging)                   |
| Server     | Apache Tomcat 10                        |

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

---

## Setup Guide (Eclipse + XAMPP)

Follow these steps exactly to get the project running on your machine.

### What You Need to Install First

| Tool | Download Link |
|------|--------------|
| Eclipse IDE for Enterprise Java (2023+) | https://www.eclipse.org/downloads/ |
| XAMPP (includes Apache + MySQL) | https://www.apachefriends.org/ |
| Java JDK 17 | https://www.oracle.com/java/technologies/downloads/#java17 |
| Apache Tomcat 10 | https://tomcat.apache.org/download-10.cgi |

---

### Step 1 — Clone the Repository

Open a terminal (or Git Bash) and run:

```bash
git clone https://github.com/evariste060/PMS.git
```

This creates a folder called `PMS` on your machine with all the project files.

---

### Step 2 — Set Up the Database with XAMPP

1. Open **XAMPP Control Panel** and click **Start** next to **Apache** and **MySQL**

2. Open your browser and go to:
   ```
   http://localhost/phpmyadmin
   ```

3. Click **New** on the left sidebar to create a new database

4. Type `PMS` as the database name, choose `utf8mb4_unicode_ci` as collation, then click **Create**

5. Click on the `PMS` database you just created, then click the **Import** tab at the top

6. Click **Choose File** and navigate to:
   ```
   PMS/src/main/resources/database.sql
   ```

7. Click **Import** at the bottom of the page

8. You should see a success message. The database now has all tables and a default admin account:
   ```
   Username: admin
   Password: admin123
   ```

---

### Step 3 — Import the Project into Eclipse

1. Open **Eclipse**

2. Go to **File → Import**

3. Select **Maven → Existing Maven Projects** and click **Next**

4. Click **Browse** and select the `PMS` folder you cloned in Step 1

5. Make sure `pom.xml` is checked, then click **Finish**

6. Wait for Eclipse to download all dependencies (bottom-right progress bar). This may take a few minutes the first time.

---

### Step 4 — Add Tomcat Server to Eclipse

> Skip this step if you already have Tomcat configured in Eclipse.

1. Go to **Window → Preferences → Server → Runtime Environments**

2. Click **Add**, select **Apache Tomcat v10.0**, click **Next**

3. Click **Browse** and point to your Tomcat installation folder, then click **Finish**

---

### Step 5 — Configure the Database Connection

1. In Eclipse, open the file:
   ```
   src/main/java/com/pms/util/DBConnection.java
   ```

2. Check the credentials match your XAMPP MySQL setup:
   ```java
   private static final String USER     = "root";   // XAMPP default username
   private static final String PASSWORD = "";        // leave empty if you set no password
   ```
   > If you set a MySQL password in XAMPP, enter it in the `PASSWORD` field.

---

### Step 6 — Run the Project

1. In Eclipse, right-click the project in the **Project Explorer**

2. Select **Run As → Run on Server**

3. Choose your **Tomcat 10** server and click **Finish**

4. Eclipse will open a browser tab. If it does not, open your browser and go to:
   ```
   http://localhost:8080/PMS
   ```

5. Log in with the admin account:
   ```
   Username: admin
   Password: admin123
   ```

---

### Troubleshooting

| Problem | Fix |
|---------|-----|
| `ClassNotFoundException: com.mysql.cj.jdbc.Driver` | Make sure XAMPP MySQL is running |
| `Access denied for user 'root'` | Check your password in `DBConnection.java` |
| `Unknown database 'PMS'` | Repeat Step 2 — database was not created |
| Port 8080 already in use | Stop any other server using port 8080, or change Tomcat port |
| Dependencies not downloading | Right-click project → Maven → Update Project |

---

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

---

## Known Limitations / Areas for Improvement

- Passwords are hashed with MD5 — consider upgrading to bcrypt
- No email notifications yet
- No REST API (pure Servlet/JSP MVC only)
- No unit/integration test coverage yet

---

## Team Members

| Name                  | Role                | Reg Number  |
|-----------------------|---------------------|-------------|
| Evariste Nkurunziza   | Team Lead / Backend | 224003322   |
| Member 2              | Frontend            | -           |
| Member 3              | Database            | -           |
| Member 4              | Backend             | -           |
| Member 5              | Frontend            | -           |

> University of Rwanda
