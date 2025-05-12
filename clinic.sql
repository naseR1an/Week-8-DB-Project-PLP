CREATE DATABASE ClinicDB;
USE ClinicDB;

--  Specialties Table 
CREATE TABLE Specialties (
    SpecialtyID INT PRIMARY KEY AUTO_INCREMENT,
    SpecialtyName VARCHAR(255) NOT NULL UNIQUE
);

-- Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(255) NOT NULL,
    DOB DATE NOT NULL,
    ContactNumber VARCHAR(15) UNIQUE NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL
);

-- Doctors Table 
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(255) NOT NULL,
    SpecialtyID INT,
    ContactNumber VARCHAR(15) UNIQUE NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    FOREIGN KEY (SpecialtyID) REFERENCES Specialties(SpecialtyID)
);

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT NOT NULL UNIQUE,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME NOT NULL,
    PaymentMethod ENUM('Cash', 'Credit Card', 'Insurance') NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Create Prescriptions Table
CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT NOT NULL,
    Medication VARCHAR(255) NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Specialities offered in the clinic
INSERT INTO Specialties (SpecialtyName) VALUES
    ('General Practitioner'),
    ('Cardiologist'),
    ('Dermatologist'),
    ('Orthopedic Surgeon'),
    ('Pediatrician');

-- Patient details once admitted
INSERT INTO Patients (FullName, DOB, ContactNumber, Email) VALUES
    ('Maria Awour', '1990-05-15', '0712345678', 'maria@gmail.com'),
    ('Dedan Mukiri', '1985-08-22', '0723456789', 'dedan@gmail.com'),
    ('Cathy Nafula', '2000-01-30', '0734567890', 'cathy@gmail.com'),
    ('Brandon Leshan', '1995-11-10', '0745678901', 'leshan@gmail.com'),
    ('Eve Naisoyan', '2004-07-05', '0756789012', 'eve@gmail.com');

-- Doctors offering services at our clinic
INSERT INTO Doctors (FullName, SpecialtyID, ContactNumber, Email) VALUES
    ('Dr. Helen Naserian', 1, '0767890123', 'daktari@gmail.com'),
    ('Dr. Jorum Njogu', 2, '0778901234', 'jorum@gmail.com'),
    ('Dr. Vincent Aleki', 3, '0789012345', 'vincent@gmail.com'),
    ('Dr. Njuguna Lee', 4, '0790123456', 'lee@gmail.com'),
    ('Dr. Sophia Njeri', 5, '0701234567', 'sophia@gmail.com');

 -- All appointments for May-2025
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status) VALUES
    (1, 1, '2025-05-12 10:00:00', 'Scheduled'),
    (2, 2, '2025-05-13 11:30:00', 'Completed'),
    (3, 3, '2025-05-14 14:00:00', 'Scheduled'),
    (4, 4, '2025-05-15 16:00:00', 'Cancelled'),
    (5, 5, '2025-05-16 09:00:00', 'Scheduled');

 -- Payment transactions for May-2025
INSERT INTO Payments (AppointmentID, Amount, PaymentDate, PaymentMethod) VALUES
    (1, 150.00, '2025-05-12 10:30:00', 'Credit Card'),
    (2, 200.00, '2025-05-13 11:45:00', 'Cash'),
    (3, 100.00, '2025-05-14 14:30:00', 'Insurance'),
    (4, 175.00, '2025-05-15 16:15:00', 'Credit Card'),
    (5, 125.00, '2025-05-16 09:30:00', 'Cash');

-- Prescriptions administered
INSERT INTO Prescriptions (AppointmentID, Medication, Dosage) VALUES
    (1, 'Ibuprofen', '200mg Twice Daily'),
    (2, 'Paracetamol', '500mg Once Daily'),
    (3, 'Amoxicillin', '250mg Three Times Daily'),
    (4, 'Vitamin D', '1000 IU Once Daily'),
    (5, 'Cough Syrup', '10ml Twice Daily');          
