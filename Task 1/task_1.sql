-- Hospital Table
CREATE TABLE Hospital (
    HosID INT PRIMARY KEY,
    Name VARCHAR(100)
);

-- Doctor Table
CREATE TABLE Doctor (
    DrID INT PRIMARY KEY,
    Dr_Name VARCHAR(100),
    HosID INT,
    FOREIGN KEY (HosID) REFERENCES Hospital(HosID)
);

-- Patient Table
CREATE TABLE Patient (
    PatID INT PRIMARY KEY,
    Name VARCHAR(100),
    HosID INT,
    FOREIGN KEY (HosID) REFERENCES Hospital(HosID)
);

-- Medical Record Table
CREATE TABLE Medical_Record (
    MRID INT PRIMARY KEY,
    Report_Name VARCHAR(100),
    PatID INT,
    FOREIGN KEY (PatID) REFERENCES Patient(PatID)
);

-- Indoor Patient (subclass of Patient)
CREATE TABLE Indoor (
    IPDID INT PRIMARY KEY,
    RoomNo VARCHAR(20),
    PatID INT UNIQUE,
    FOREIGN KEY (PatID) REFERENCES Patient(PatID)
);

-- Outdoor Patient (subclass of Patient)
CREATE TABLE Outdoor (
    OPDID INT PRIMARY KEY,
    Charge DECIMAL(10,2),
    PatID INT UNIQUE,
    FOREIGN KEY (PatID) REFERENCES Patient(PatID)
);

-- Doctor-Patient Relationship (Many-to-Many)
CREATE TABLE Doctor_Patient (
    DrID INT,
    PatID INT,
    PRIMARY KEY (DrID, PatID),
    FOREIGN KEY (DrID) REFERENCES Doctor(DrID),
    FOREIGN KEY (PatID) REFERENCES Patient(PatID)
);
