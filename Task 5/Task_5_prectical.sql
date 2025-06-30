--INNER JOIN – only matching rows

-- Show patients with their hospital name
SELECT Patient.Name, Hospital.Name AS HospitalName
FROM Patient
INNER JOIN Hospital ON Patient.HosID = Hospital.HosID;

--2. LEFT JOIN – all patients, even if hospital is missing
SELECT Patient.Name, Hospital.Name AS HospitalName
FROM Patient
LEFT JOIN Hospital ON Patient.HosID = Hospital.HosID;

--3. RIGHT JOIN – all hospitals, even if no patients (MySQL/others only)
SELECT Patient.Name, Hospital.Name AS HospitalName
FROM Patient
RIGHT JOIN Hospital ON Patient.HosID = Hospital.HosID;

--4. FULL JOIN – all patients and all hospitals (even unmatched)
SELECT Patient.Name, Hospital.Name AS HospitalName
FROM Patient
FULL OUTER JOIN Hospital ON Patient.HosID = Hospital.HosID;


-- Doctor and Patient (Many-to-Many)

SELECT Doctor.Dr_Name, Patient.Name AS PatientName
FROM Doctor
INNER JOIN Doctor_Patient ON Doctor.DrID = Doctor_Patient.DrID
INNER JOIN Patient ON Doctor_Patient.PatID = Patient.PatID;

--5. Join Doctor and Hospital – to show which doctor works where
SELECT Doctor.Dr_Name, Hospital.Name AS HospitalName
FROM Doctor
INNER JOIN Hospital ON Doctor.HosID = Hospital.HosID;

--6. Join Medical Record and Patient
SELECT Medical_Record.Report_Name, Patient.Name AS PatientName
FROM Medical_Record
INNER JOIN Patient ON Medical_Record.PatID = Patient.PatID;

--7. Join Outdoor and Patient
SELECT Outdoor.OPDID, Outdoor.Charge, Patient.Name AS PatientName
FROM Outdoor
INNER JOIN Patient ON Outdoor.PatID = Patient.PatID;

--8. Join Indoor and Patient
SELECT Indoor.RoomNo, Patient.Name AS PatientName
FROM Indoor
INNER JOIN Patient ON Indoor.PatID = Patient.PatID;


--9. Join Doctor, Doctor_Patient, and Patient – Show which doctor treats which patient
SELECT Doctor.Dr_Name, Patient.Name AS PatientName
FROM Doctor
INNER JOIN Doctor_Patient ON Doctor.DrID = Doctor_Patient.DrID
INNER JOIN Patient ON Doctor_Patient.PatID = Patient.PatID;

--10. LEFT JOIN with Medical_Record – Show all patients even if they don’t have a medical report
SELECT Patient.Name AS PatientName, Medical_Record.Report_Name
FROM Patient
LEFT JOIN Medical_Record ON Patient.PatID = Medical_Record.PatID;

--11. LEFT JOIN on Doctor and Doctor_Patient – Show all doctors even if they are not assigned to patients
SELECT Doctor.Dr_Name, Patient.Name AS PatientName
FROM Doctor
LEFT JOIN Doctor_Patient ON Doctor.DrID = Doctor_Patient.DrID
LEFT JOIN Patient ON Doctor_Patient.PatID = Patient.PatID;

