---1. Use SELECT * and specific columns
-- Select all columns from Patient
SELECT * FROM Patient;

-- Select specific columns from Doctor
SELECT DrID, Dr_Name FROM Doctor;

-- Select specific columns from Medical_Record
SELECT MRID, Report_Name FROM Medical_Record;

--2. Apply WHERE, AND, OR, LIKE, BETWEEN

-- Get doctors from Hospital 1 whose name starts with 'Dr. M'
SELECT * FROM Doctor
WHERE HosID = 1 AND Dr_Name LIKE 'Dr. M%';

--WHERE with OR
-- Get patients from either Hospital 1 or 2
SELECT * FROM Patient
WHERE HosID = 1 OR HosID = 2;

--LIKE
-- Get patients whose name contains 'a'
SELECT * FROM Patient
WHERE Name LIKE '%a%';


--BETWEEN
-- Get Outdoor patients whose charge is between 300 and 500
SELECT * FROM Outdoor
WHERE Charge BETWEEN 300 AND 500;

--3. Sort with ORDER BY
-- Sort doctors by name A to Z
SELECT * FROM Doctor
ORDER BY Dr_Name ASC;

-- Sort patients by PatID in descending order
SELECT * FROM Patient
ORDER BY PatID DESC;

-- Sort Outdoor patients by Charge
SELECT * FROM Outdoor
ORDER BY Charge;
