-- View: Patient Details with Hospital Name
--Combines Patient and Hospital using JOIN.
CREATE VIEW View_PatientDetails AS
SELECT P.PatID, P.Name AS PatientName, H.Name AS HospitalName
FROM Patient P
JOIN Hospital H ON P.HosID = H.HosID;


--2. View: Doctors and Their Hospital
--Simplifies doctor-hospital mapping for users.
CREATE VIEW View_DoctorWithHospital AS
SELECT D.DrID, D.Dr_Name, H.Name AS HospitalName
FROM Doctor D
JOIN Hospital H ON D.HosID = H.HosID;

--3. View: Outdoor Patient Billing Summary
--Shows patient name, charge, and hospital — hides internal IDs (security).
CREATE VIEW View_OutdoorBilling AS
SELECT P.Name AS PatientName, O.Charge, H.Name AS HospitalName
FROM Outdoor O
JOIN Patient P ON O.PatID = P.PatID
JOIN Hospital H ON P.HosID = H.HosID;

--4. View: Doctor-Patient Relationship
--Shows which doctor treats which patient — for reporting, hides IDs.
CREATE VIEW View_DoctorPatient AS
SELECT D.Dr_Name AS Doctor, P.Name AS Patient
FROM Doctor D
JOIN Doctor_Patient DP ON D.DrID = DP.DrID
JOIN Patient P ON DP.PatID = P.PatID;

--5. View: Hospital Patient Count
--Uses aggregation in view — abstracted for analytics.
CREATE VIEW View_HospitalPatientCount AS
SELECT HosID, COUNT(*) AS TotalPatients
FROM Patient
GROUP BY HosID;

--6 View: Indoor Patients with Room Details
--Join Patient and Indoor — hide internal IDs.
CREATE VIEW View_IndoorPatients AS
SELECT P.Name AS PatientName, I.RoomNo
FROM Indoor I
JOIN Patient P ON I.PatID = P.PatID;

--7 View: Doctors and Number of Patients They Treat
--Aggregation + JOIN + GROUP BY

CREATE VIEW View_DoctorPatientCount AS
SELECT D.Dr_Name, COUNT(DP.PatID) AS TotalPatients
FROM Doctor D
JOIN Doctor_Patient DP ON D.DrID = DP.DrID
GROUP BY D.Dr_Name;

--8 View: Patients Without Medical Records
--Uses subquery with NOT EXISTS to hide medical history absence
CREATE VIEW View_PatientsNoReports AS
SELECT P.PatID, P.Name
FROM Patient P
WHERE NOT EXISTS (
    SELECT 1 FROM Medical_Record M WHERE M.PatID = P.PatID
);

--9 View: Outdoor Charges per Hospital
--Aggregated view for billing by hospital
CREATE VIEW View_HospitalOutdoorCharges AS
SELECT H.Name AS HospitalName, SUM(O.Charge) AS TotalOutdoorCharge
FROM Outdoor O
JOIN Patient P ON O.PatID = P.PatID
JOIN Hospital H ON P.HosID = H.HosID
GROUP BY H.Name;

--10 View: Doctor + Hospital + Patient in One View
--Multi-table join — useful for reporting, hide IDs
CREATE VIEW View_DoctorPatientHospital AS
SELECT D.Dr_Name AS Doctor, P.Name AS Patient, H.Name AS Hospital
FROM Doctor D
JOIN Doctor_Patient DP ON D.DrID = DP.DrID
JOIN Patient P ON DP.PatID = P.PatID
JOIN Hospital H ON P.HosID = H.HosID;
