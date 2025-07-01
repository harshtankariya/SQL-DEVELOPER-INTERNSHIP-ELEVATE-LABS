--1. Scalar Subquery
-- Show patients whose HosID matches the hospital with the highest ID
SELECT Name
FROM Patient
WHERE HosID = (
    SELECT MAX(HosID) FROM Hospital
);

--2. Correlated Subquery
-- Show patients who have a medical report (matched by PatID)
SELECT Name
FROM Patient P
WHERE EXISTS (
    SELECT 1 FROM Medical_Record M
    WHERE M.PatID = P.PatID
);

-- Show outdoor patients whose charge is higher than average charge of all outdoor patients
SELECT PatID, Charge
FROM Outdoor O
WHERE Charge > (
    SELECT AVG(Charge) FROM Outdoor
);

-- 3. Subquery using IN
-- Show doctors working in hospitals that have patients
SELECT Dr_Name
FROM Doctor
WHERE HosID IN (
    SELECT DISTINCT HosID FROM Patient
);

--4. Subquery using EXISTS
-- Show hospitals that have at least one doctor
SELECT Name
FROM Hospital H
WHERE EXISTS (
    SELECT 1 FROM Doctor D WHERE D.HosID = H.HosID
);

--5. Subquery using = (Scalar)
-- Show name of hospital with ID = (smallest HosID)
SELECT Name
FROM Hospital
WHERE HosID = (
    SELECT MIN(HosID) FROM Hospital
);

--Patients who have doctors assigned (via Doctor_Patient)
SELECT Name
FROM Patient
WHERE PatID IN (
    SELECT PatID FROM Doctor_Patient
);
-- Doctors who are not treating any patients
SELECT Dr_Name
FROM Doctor D
WHERE NOT EXISTS (
    SELECT 1 FROM Doctor_Patient DP
    WHERE DP.DrID = D.DrID
);

--Show patients who have more than one report
SELECT Name
FROM Patient P
WHERE (
    SELECT COUNT(*) FROM Medical_Record M
    WHERE M.PatID = P.PatID
) > 1;

--Hospitals that have more than 2 doctors
SELECT Name
FROM Hospital H
WHERE (
    SELECT COUNT(*) FROM Doctor D
    WHERE D.HosID = H.HosID
) > 2;

--Outdoor patients whose charge equals the highest charge
SELECT PatID, Charge
FROM Outdoor
WHERE Charge = (
    SELECT MAX(Charge) FROM Outdoor
);
