--1. Apply Aggregate Functions on Numeric Columns1. Apply Aggregate Functions on Numeric Columns

-- Get total number of patients
SELECT COUNT(*) AS TotalPatients FROM Patient;

-- Get average charge of outdoor patients
SELECT AVG(Charge) AS AverageCharge FROM Outdoor;

-- Get maximum and minimum charges from outdoor patients
SELECT MAX(Charge) AS HighestCharge, MIN(Charge) AS LowestCharge FROM Outdoor;

-- Get total charge collected from outdoor patients
SELECT SUM(Charge) AS TotalCharge FROM Outdoor;

--2. Use GROUP BY to Categorize
-- Count number of patients in each hospital
SELECT HosID, COUNT(*) AS TotalPatients
FROM Patient
GROUP BY HosID;

-- Count number of doctors per hospital
SELECT HosID, COUNT(*) AS TotalDoctors
FROM Doctor
GROUP BY HosID;

-- Total charge collected per patient (Outdoor only)
SELECT PatID, SUM(Charge) AS PatientTotalCharge
FROM Outdoor
GROUP BY PatID;

--3. Filter Groups using HAVING

-- Hospitals having more than 1 patient
SELECT HosID, COUNT(*) AS TotalPatients
FROM Patient
GROUP BY HosID
HAVING COUNT(*) > 1;

-- Patients whose total outdoor charge is more than 400
SELECT PatID, SUM(Charge) AS TotalCharge
FROM Outdoor
GROUP BY PatID
HAVING SUM(Charge) > 400;
