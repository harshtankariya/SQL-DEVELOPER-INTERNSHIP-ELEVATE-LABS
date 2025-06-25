-- Insert into Hospital
INSERT INTO Hospital (HosID, Name) VALUES
(1, 'City Hospital'),
(2, 'Sunshine Hospital');

-- Insert into Doctor
INSERT INTO Doctor (DrID, Dr_Name, HosID) VALUES
(101, 'Dr. Meera Shah', 1),
(102, 'Dr. Kunal Patel', 1),
(103, 'Dr. Arjun Singh', 2);

-- Insert into Patient
INSERT INTO Patient (PatID, Name, HosID) VALUES
(201, 'Ravi Joshi', 1),
(202, 'Sneha Desai', 1),
(203, 'Amit Sharma', 2),
(204, 'Neha Verma', 2);

-- Insert into Medical_Record
INSERT INTO Medical_Record (MRID, Report_Name, PatID) VALUES
(301, 'Blood Test', 201),
(302, 'X-Ray', 202),
(303, 'MRI Scan', 203),
(304, 'COVID-19 Test', 204);

-- Insert into Indoor (Indoor patients)
INSERT INTO Indoor (IPDID, RoomNo, PatID) VALUES
(401, '101A', 201),
(402, '102B', 203);

-- Insert into Outdoor (Outdoor patients)
INSERT INTO Outdoor (OPDID, Charge, PatID) VALUES
(501, 500.00, 202),
(502, 300.00, 204);

-- Insert into Doctor_Patient (Many-to-Many Relationship)
INSERT INTO Doctor_Patient (DrID, PatID) VALUES
(101, 201),  -- Dr. Meera treats Ravi
(101, 202),  -- Dr. Meera treats Sneha
(102, 202),  -- Dr. Kunal treats Sneha
(103, 203),  -- Dr. Arjun treats Amit
(103, 204);  -- Dr. Arjun treats Neha

---   Insert Data with NULL or Default Values ---- 
-- Doctor without phone/email (uses DEFAULT values)
INSERT INTO Doctor (DrID, Dr_Name, HosID)
VALUES (104, 'Dr. Kavita Rao', 1);

-- Patient without age/phone (uses NULL)
INSERT INTO Patient (PatID, Name, HosID)
VALUES (205, 'Bhavin Trivedi', 2);

-- Medical record without report name (uses DEFAULT)
INSERT INTO Medical_Record (MRID, PatID)
VALUES (305, 205);

-- Indoor without RoomNo (uses NULL)
INSERT INTO Indoor (IPDID, PatID)
VALUES (403, 205);

-- Outdoor without Charge (uses DEFAULT = 100.00)
INSERT INTO Outdoor (OPDID, PatID)
VALUES (503, 204);

--- Use UPDATE and DELETE with WHERE conditions ---

-- Update a doctor's email where the name is 'Dr. Kavita Rao'
UPDATE Doctor
SET Email = 'kavita.rao@hospital.com'
WHERE Dr_Name = 'Dr. Kavita Rao';

-- Update patient's phone number where name is 'Bhavin Trivedi'
UPDATE Patient
SET Phone = '9998887770'
WHERE Name = 'Bhavin Trivedi';

-- Update charge for Outdoor patient where PatID = 204
UPDATE Outdoor
SET Charge = 450.00
WHERE PatID = 204;

-- Update Report Name where Report_Name is default
UPDATE Medical_Record
SET Report_Name = 'Full Body Checkup'
WHERE Report_Name = 'Not Available';


-- Delete a doctor who has no email (NULL)
DELETE FROM Doctor
WHERE Email IS NULL;

-- Delete a patient whose name is 'Sneha Desai'
DELETE FROM Patient
WHERE Name = 'Sneha Desai';

-- Delete medical record for patient ID 202
DELETE FROM Medical_Record
WHERE PatID = 202;

-- Delete outdoor patient with charge = 300.00
DELETE FROM Outdoor
WHERE Charge = 300.00;
