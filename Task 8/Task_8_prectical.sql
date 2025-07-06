-- Example 1: Procedure to show patients from a specific hospital
DELIMITER //
CREATE PROCEDURE GetPatientsByHospital(IN input_hosid INT)
BEGIN
  SELECT Name FROM Patient WHERE HosID = input_hosid;
END;
//
DELIMITER ;

CALL GetPatientsByHospital(2);

--Example 2: Procedure with IF condition
DELIMITER //
CREATE PROCEDURE CheckHospitalDoctors(IN input_hosid INT)
BEGIN
  IF EXISTS (SELECT * FROM Doctor WHERE HosID = input_hosid) THEN
     SELECT 'Doctors Found' AS Result;
  ELSE
     SELECT 'No Doctors in this Hospital' AS Result;
  END IF;
END;
//
DELIMITER ;

-- 2. CREATE FUNCTION

--Example 3: Function to get total outdoor charges of a patient
DELIMITER //
CREATE FUNCTION GetTotalCharge(pid INT)
RETURNS DECIMAL(10,2)
BEGIN
  DECLARE total DECIMAL(10,2);
  SELECT SUM(Charge) INTO total FROM Outdoor WHERE PatID = pid;
  RETURN IFNULL(total, 0);
END;
//
DELIMITER ;

SELECT GetTotalCharge(101);

-- Example 4: Function to check if a patient has medical reports
DELIMITER //
CREATE FUNCTION HasMedicalReport(pid INT)
RETURNS VARCHAR(10)
BEGIN
  IF EXISTS (SELECT * FROM Medical_Record WHERE PatID = pid) THEN
    RETURN 'Yes';
  ELSE
    RETURN 'No';
  END IF;
END;
//
DELIMITER ;

-- Example 5: Procedure to list doctors treating a specific patient
DELIMITER //
CREATE PROCEDURE GetDoctorsByPatient(IN pid INT)
BEGIN
  SELECT D.Dr_Name
  FROM Doctor D
  JOIN Doctor_Patient DP ON D.DrID = DP.DrID
  WHERE DP.PatID = pid;
END;
//
DELIMITER ;

