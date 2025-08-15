
-- Create tables
CREATE TABLE ProjectSection (
    SectionID INT IDENTITY PRIMARY KEY,
    SectionName NVARCHAR(255),
    SheetName NVARCHAR(255)
);

CREATE TABLE Component (
    ComponentID INT IDENTITY PRIMARY KEY,
    SectionID INT FOREIGN KEY REFERENCES ProjectSection(SectionID),
    Position NVARCHAR(50),
    Description NVARCHAR(MAX),
    Quantity DECIMAL(10, 2),
    Unit NVARCHAR(50),
    SupplyPerUnit DECIMAL(10, 2),
    InstallationPerUnit DECIMAL(10, 2),
    TotalPerUnit DECIMAL(10, 2),
    Total DECIMAL(10, 2)
);

-- Insert project sections
INSERT INTO ProjectSection (SectionID, SectionName, SheetName) VALUES (1, N'Rekapitulacija', N'Rekapitulacija');
INSERT INTO ProjectSection (SectionID, SectionName, SheetName) VALUES (2, N'Priprava in razvod GM-25_-15', N'Priprava in razvod GM-25_-15');
INSERT INTO ProjectSection (SectionID, SectionName, SheetName) VALUES (3, N'HV29-35_PTV11_VMEH', N'HV29-35_PTV11_VMEH ');
INSERT INTO ProjectSection (SectionID, SectionName, SheetName) VALUES (4, N'Hladilna voda HV20-30', N'Hladilna voda HV20-30');
INSERT INTO ProjectSection (SectionID, SectionName, SheetName) VALUES (5, N'SKUPNO', N'SKUPNO');
INSERT INTO ProjectSection (SectionID, SectionName, SheetName) VALUES (6, N'KVALIFIKACIJE', N'KVALIFIKACIJE');
INSERT INTO ProjectSection (SectionID, SectionName, SheetName) VALUES (7, N'SPLOŠNO', N'SPLOŠNO');