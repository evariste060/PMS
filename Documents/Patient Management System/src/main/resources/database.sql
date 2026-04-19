-- =============================================================
--  Patient Management System — PMS Database Schema
--  Run this in MySQL / phpMyAdmin before starting the app
-- =============================================================

CREATE DATABASE IF NOT EXISTS PMS
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE PMS;

-- ---------------------------------------------------------------
-- Users  (master auth table)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Users (
    userID    INT          AUTO_INCREMENT PRIMARY KEY,
    username  VARCHAR(50)  NOT NULL UNIQUE,
    password  VARCHAR(64)  NOT NULL COMMENT 'MD5 hash',
    userType  ENUM('Admin','Doctor','Nurse','Patient') NOT NULL
);

-- ---------------------------------------------------------------
-- Doctors
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Doctors (
    doctorID     INT          AUTO_INCREMENT PRIMARY KEY,
    firstName    VARCHAR(50)  NOT NULL,
    lastName     VARCHAR(50)  NOT NULL,
    telephone    VARCHAR(20),
    email        VARCHAR(100),
    address      TEXT,
    hospitalName VARCHAR(100) NOT NULL,
    userID       INT          UNIQUE,
    FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE
);

-- ---------------------------------------------------------------
-- Nurses
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Nurses (
    nurseID      INT          AUTO_INCREMENT PRIMARY KEY,
    firstName    VARCHAR(50)  NOT NULL,
    lastName     VARCHAR(50)  NOT NULL,
    telephone    VARCHAR(20),
    email        VARCHAR(100),
    address      TEXT,
    healthCenter VARCHAR(100),
    doctorID     INT,
    userID       INT          UNIQUE,
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID) ON DELETE SET NULL,
    FOREIGN KEY (userID)   REFERENCES Users(userID)    ON DELETE CASCADE
);

-- ---------------------------------------------------------------
-- Patients
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Patients (
    patientID  INT          AUTO_INCREMENT PRIMARY KEY,
    firstName  VARCHAR(50)  NOT NULL,
    lastName   VARCHAR(50)  NOT NULL,
    telephone  VARCHAR(20),
    email      VARCHAR(100),
    address    TEXT,
    pImageLink VARCHAR(255) DEFAULT 'images/default.png',
    nurseID    INT,
    userID     INT          UNIQUE,
    FOREIGN KEY (nurseID) REFERENCES Nurses(nurseID) ON DELETE SET NULL,
    FOREIGN KEY (userID)  REFERENCES Users(userID)   ON DELETE CASCADE
);

-- ---------------------------------------------------------------
-- Diagnosis
-- DiagnosisStatus = 'Referrable'     → Result starts as 'Pending'
-- DiagnosisStatus = 'Not Referrable' → Result starts as 'Negative'
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Diagnosis (
    diagnosisID     INT    AUTO_INCREMENT PRIMARY KEY,
    patientID       INT    NOT NULL,
    nurseID         INT    NOT NULL,
    doctorID        INT,
    diagnosisStatus ENUM('Referrable','Not Referrable') NOT NULL,
    result          VARCHAR(1000) DEFAULT 'Pending',
    createdAt       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patientID) REFERENCES Patients(patientID) ON DELETE CASCADE,
    FOREIGN KEY (nurseID)   REFERENCES Nurses(nurseID)     ON DELETE RESTRICT,
    FOREIGN KEY (doctorID)  REFERENCES Doctors(doctorID)   ON DELETE SET NULL
);

-- ---------------------------------------------------------------
-- Default admin account  (username: admin | password: admin123)
-- ---------------------------------------------------------------
INSERT INTO Users (username, password, userType)
VALUES ('admin', MD5('admin123'), 'Admin');
