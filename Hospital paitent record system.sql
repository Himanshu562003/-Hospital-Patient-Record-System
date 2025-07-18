CREATE DATABASE hospital;
USE hospital;

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    dob DATE,
    phone VARCHAR(15),
    address TEXT
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialty VARCHAR(50),
    phone VARCHAR(15),
    experience INT
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);


CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY,
    appointment_id INT,
    treatment_details TEXT,
    cost DECIMAL(10,2),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

CREATE TABLE Billing (
    bill_id INT PRIMARY KEY,
    treatment_id INT,
    billing_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id)
);

INSERT INTO Patients VALUES (1, 'Amit Sharma', 'Male', '1990-04-15', '9876543210', 'Pune');
INSERT INTO Doctors VALUES (101, 'Dr. Mehta', 'Cardiologist', '9988776655', 12);
INSERT INTO Appointments VALUES (1001, 1, 101, '2025-07-15', 'Chest pain');
INSERT INTO Treatments VALUES (201, 1001, 'ECG and Medication', 1500.00);
INSERT INTO Billing VALUES (301, 201, '2025-07-16', 1500.00, 'Paid');


SELECT P.name AS patient_name, D.name AS doctor_name, A.appointment_date, A.reason
FROM Appointments A
JOIN Patients P ON A.patient_id = P.patient_id
JOIN Doctors D ON A.doctor_id = D.doctor_id;

SELECT P.name, SUM(T.cost) AS total_cost
FROM Patients P
JOIN Appointments A ON P.patient_id = A.patient_id
JOIN Treatments T ON A.appointment_id = T.appointment_id
GROUP BY P.name;

SELECT B.bill_id, P.name AS patient_name, B.amount
FROM Billing B
JOIN Treatments T ON B.treatment_id = T.treatment_id
JOIN Appointments A ON T.appointment_id = A.appointment_id
JOIN Patients P ON A.patient_id = P.patient_id
WHERE B.status = 'Unpaid';









































