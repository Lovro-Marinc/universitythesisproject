--USE Indigomat
--GO
--DROP DATABASE Indigomat2
--exec sp_who2

--select * from app.Projects
--select * from ex.ProjectSections
--select * from ex.HeaderGroups
--select * from ex.HeaderSubgroups
--select * from ex.Components


CREATE DATABASE Indigomat2;
go

SET XACT_ABORT ON;
GO
USE Indigomat2
GO
CREATE SCHEMA SETUP;
GO
CREATE SCHEMA APP;
GO
CREATE SCHEMA EX;
GO


CREATE TABLE APP.Projects(
					Id INT IDENTITY PRIMARY KEY
					,ProjectStatus INT NOT NULL DEFAULT 10
					,ProjectName NVARCHAR(255) NOT NULL
					,ProjectDescription NVARCHAR(MAX)
					,SortOrder INT 
					,CreatedOn DATETIME DEFAULT GETDATE()
					,CreatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
					,UpdatedOn DATETIME DEFAULT GETDATE()
					,UpdatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
					,[RowVersion] RowVersion
);
GO
INSERT INTO app.Projects(ProjectName)  VALUES ('870-SandboxProject');
GO

-- Create tables with hierarchy and metadata
CREATE TABLE EX.ProjectSections (
	Id INT IDENTITY PRIMARY KEY
	,ProjectId INT Foreign Key REFERENCES APP.Projects(Id)    
    ,SectionName NVARCHAR(255)
    ,SheetName NVARCHAR(255)
    ,SortOrder INT
	,CreatedOn DATETIME DEFAULT GETDATE()
	,CreatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,UpdatedOn DATETIME DEFAULT GETDATE()
	,UpdatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,[RowVersion] RowVersion
);


CREATE TABLE EX.HeaderGroups (
    Id INT IDENTITY PRIMARY KEY
    ,SectionId INT FOREIGN KEY REFERENCES EX.ProjectSections(Id)
    ,GroupCode NVARCHAR(50)
    ,Title NVARCHAR(255)
    ,CreatedOn DATETIME DEFAULT GETDATE()
	,CreatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,UpdatedOn DATETIME DEFAULT GETDATE()
	,UpdatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,[RowVersion] RowVersion
);


CREATE TABLE EX.HeaderSubgroups (
    Id INT IDENTITY PRIMARY KEY
    ,SectionId INT FOREIGN KEY REFERENCES EX.ProjectSections(Id)
	,HeaderGroupId INT FOREIGN KEY REFERENCES EX.HeaderGroups(Id)
    ,GroupCode NVARCHAR(50)
    ,Title NVARCHAR(MAX)
    ,ParentCode NVARCHAR(50)
    ,SortOrder INT
    ,CreatedOn DATETIME DEFAULT GETDATE()
	,CreatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,UpdatedOn DATETIME DEFAULT GETDATE()
	,UpdatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,[RowVersion] RowVersion
);


CREATE TABLE EX.Components (
    Id INT IDENTITY PRIMARY KEY,
    SectionId INT FOREIGN KEY REFERENCES EX.ProjectSections(Id),
	HeaderSubgroupId INT FOREIGN KEY REFERENCES EX.HeaderSubgroups(Id),
    GroupCode NVARCHAR(50),
    Position NVARCHAR(50),
    Description NVARCHAR(MAX),
    Quantity DECIMAL(10, 2),
    Unit NVARCHAR(50),
    SupplyPerUnit DECIMAL(10, 2),
    InstallationPerUnit DECIMAL(10, 2),
    TotalPerUnit DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    SortOrder INT
    ,CreatedOn DATETIME DEFAULT GETDATE()
	,CreatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,UpdatedOn DATETIME DEFAULT GETDATE()
	,UpdatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,[RowVersion] RowVersion
);

SET IDENTITY_INSERT EX.ProjectSections ON
-- Insert project sections
INSERT INTO EX.ProjectSections (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (1,1, N'Rekapitulacija', N'Rekapitulacija', 1);
INSERT INTO EX.ProjectSections (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (2,1, N'Priprava in razvod GM-25_-15', N'Priprava in razvod GM-25_-15', 2);
INSERT INTO EX.ProjectSections (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (3,1, N'HV29-35_PTV11_VMEH', N'HV29-35_PTV11_VMEH ', 3);
INSERT INTO EX.ProjectSections (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (4,1, N'Hladilna voda HV20-30', N'Hladilna voda HV20-30', 4);
INSERT INTO EX.ProjectSections (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (5,1, N'SKUPNO', N'SKUPNO', 5);
INSERT INTO EX.ProjectSections (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (6,1, N'KVALIFIKACIJE', N'KVALIFIKACIJE', 6);
INSERT INTO EX.ProjectSections (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (7,1, N'SPLOŠNO', N'SPLOŠNO', 7);
SET IDENTITY_INSERT EX.ProjectSections OFF
-- Insert section groups

INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (2,N'A1', N'OPREMA');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (2,N'A2', N'MERILNA OPREMA');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (2,N'A3', N'ARMATURE');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (2,N'A4', N'CEVOVODI');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (2,N'A5', N'OPREMA CEVOVODOV');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (3,N'C1', N'OPREMA');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (3,N'C2', N'MERILNA OPREMA');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (3,N'C3', N'ARMATURE');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (3,N'C4', N'CEVOVODI');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (3,N'C5', N'HDPE CEVOVODI');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (3,N'C6', N'OPREMA CEVOVODOV');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (4,N'D1', N'OPREMA');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (4,N'D2', N'MERILNA OPREMA');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (4,N'D3', N'ARMATURE');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (4,N'D4', N'CEVOVODI');
INSERT INTO EX.HeaderGroups (SectionId, GroupCode, Title) VALUES (4,N'D5', N'OPREMA CEVOVODOV');

-- Insert component groups
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A1.1', N'HLADILNI AGREGAT -25/-15 (samo montaža)', N'A1', 1);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A1.2', N'HIDRAVLIČNA KRETNICA - VERTIKALNI REZERVOAR 6,5 m3', N'A1', 2);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A1.3', N'RAZDELILNIK/ZBIRALNIK GM-25/-15', N'A1', 3);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A1.4', N'REZERVOAR GLIKOLA ZA DOPOLNJEVANJE GM-25/-20 in GM-5/1', N'A1', 4);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A2.1', N'MERILNIK PRETOKA', N'A2', 5);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A2.2', N'MERILNIK TLAKA', N'A2', 6);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A2.3', N'MERILNIK TEMPERATURE', N'A2', 7);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A2.4', N'BYPASS NIVOKAZ', N'A2', 8);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A2.5', N'MANOMETER', N'A2', 9);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A2.6', N'TERMOMETER', N'A2', 10);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A3.1', N'KROGELNI ZAPORNI VENTIL - VARILNI', N'A3', 11);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A3.2', N'KROGELNI ZAPORNI VENTIL - PRIROBNIČNI', N'A3', 12);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A3.3', N'ZAPORNA LOPUTA:', N'A3', 13);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A3.4', N'NEPOVRATNA LOPUTA:', N'A3', 14);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A3.5', N'NEPOVRATNI VENTIL', N'A3', 15);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A3.6', N'LOVILEC NEČISTOČ:', N'A3', 16);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A3.7', N'VARNOSTNI VENTIL:', N'A3', 17);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A3.8', N'MANOMETRSKI VENTIL', N'A3', 18);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.1', N'CEV, NERJAVNA', N'A4', 19);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.2', N'KOLENO 90°, NERJAVNO', N'A4', 20);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.3', N'KOLENO 45°, NERJAVNO', N'A4', 21);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.4', N'T-KOS, NERJAVNI', N'A4', 22);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.5', N'REDUCIRNI T-KOS, NERJAVNI', N'A4', 23);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.6', N'REDUCIRNI KOS, NERJAVNI', N'A4', 24);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.7', N'PRIROBNICA, NERJAVNA', N'A4', 25);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.8', N'PRIROBNICA, SLEPA, NERJAVNA', N'A4', 26);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.9', N'ODZRAČEVALNA POSODA', N'A4', 27);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.10', N'ZBIRNI LIJAK', N'A4', 28);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.11', N'VICTAULIC SPOJKA', N'A4', 29);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A4.12', N'TC SPOJKA, končna', N'A4', 30);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A5.1', N'DRSNA PODPORA - predizolirana
Višinsko nastavljivo pomično ležišče za drsne pritrditve cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba s predizolirano objemko cevi. Za delovno temperaturno območje -25 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip D.P.1)
Ustreza: Sikla LK-HV-150, alternativa Hilti.', N'A5', 31);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A5.2', N'DRSNA PODPORA Z BOČNIM VODENJEM- predizolirana
Višinsko nastavljivo pomično ležišče za drsne pritrditve cevi  z dodatnim elementom za bočno vodenje v aksialni smeri. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba s predizolirano objemko cevi. Za delovno temperaturno območje -25 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip B.V.1)
Ustreza: Sikla LK-HV-150 + ustrezno bočno vodilo, alternativa Hilti.', N'A5', 32);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A5.3', N'FIKSNA TOČKA
Višinsko nastavljivo ležišče, z dodatnim elementom za fiksno pritrditev cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje -25 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom. ter izolacijo celotne podpore s fleksibilno elastomerno peno, na osnovi sintetične gume, z zaprto celično strukturo.  Dispozicija in način izvedbe glede na risbe tega načrta (tip F.T.1).
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2 + ustreznen fiksirni element', N'A5', 33);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A5.4', N'OBEŠALO
Obešalo cevovodov, sestavljeno iz: predizolirane objemke cevovoda z debelino pene 19mm, plošče za pritrditev, ustrezen povezovalni element (navojna palica ali navojni adapter). Izdelano iz pocinkane pločevine. Za delovno temperaturno območje -25 do 40°C. Primerno za montažo na jekleno podporno konstrukcijo ali v AB ploščo. Vključno z vijačnim in pritrdilnim materialom. Dispozicija in način izvedbe glede na risbe tega načrta (tip O.1).
Ustreza: Sikla GPL + objemka LKS 19 ali ekvivalent Hilti', N'A5', 34);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A5.5', N'JEKLENE PODPORNE KONSTRUKCIJE PODPOR CEVOVODOV
Iz pocinkanega materiala, vključuje sistemske modularne nosilce ustreznih dimenzij glede na podpore cevovodov, pripadajoče originalne spojne elemnte, vijačni material, zaključne pokrove in fiksiranje na nosilne konstrukcije na trasi cevovodov. Velikost podporne konstrukcije definirati glede na obtežbo, skladno z vsebino tega načrta. Ocena teže.
Ustreza: Sikla SiMotec 80, Sikla SiConnect 41/41', N'A5', 35);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A5.6', N'TOPLOTNA IZOLACIJA CEVOVODOV IN ARMATUR:
Fleksibilna elastomerna pena, na osnovi sintetične gume, z zaprto celično strukturo. Samougasljiv material ki ne kaplja in ne širi plamenov. Izolacija ustrezna za industrijske aplikacije, izdelana skladno z EN 14304. Primerna za temperaturno območje od -5°C do 20°C. Požarna klasifikacija B-s3,d0 (plošče) oz. Bl-s3, d0 (cevaki) po EN13501-1. CE oznaka. Toplotna prevodnost λ 0° ≤ 0,035 W/mK, koeficient parozapornosti μ ≥ 10,000. Upoštevana je dolžina cevi, dobava in montaža na enoto mora upoštevati dodatek za izolacijo cevnih elementov in armatur.  Vključno z lepilom in pomožnim montažnim materialom. 
Ustreza: Armacell Armaflex ACE Plus - cevaki in plošče + lepilo Armaflex 520.', N'A5', 36);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (2, N'A5.7', N'TOPLOTNA IZOLACIJA OPREME
Fleksibilna elastomerna pena, na osnovi sintetične gume, z zaprto celično strukturo. Samougasljiv material ki ne kaplja in ne širi plamenov. Izolacija ustrezna za industrijske aplikacije, izdelana skladno z EN 14304. Primerna za temperaturno območje od -5°C do 20°C. Požarna klasifikacija B-s3,d0 (plošče) po EN13501-1. CE oznaka. Toplotna prevodnost λ 0° ≤ 0,035 W/mK, koeficient parozapornosti μ ≥ 10,000.  Vključno z lepilom in pomožnim montažnim materialom. 
Ustreza: Armacell Armaflex ACE Plus - cevaki in plošče + lepilo Armaflex 520.', N'A5', 37);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.1', N'HLADILNI STOLP', N'C1', 1);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.2', N'ČRPALKA, centrifugalna', N'C1', 2);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.3', N'ČRPALKA, centrifugalna', N'C1', 3);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.4', N'VERTIKALNI REZERVOAR 10 m3', N'C1', 4);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.5', N'PEŠČENI FILTER', N'C1', 5);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.6', N'SKLOP MEHČALNE NAPRAVE + SOLNIK', N'C1', 6);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.7', N'VZORČNO MESTO ZA NADZOR STOLPNE VODE', N'C1', 7);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.8', N'SISTEM ZA DOZIRANJE INHIBITORJA', N'C1', 8);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.9', N'SISTEM ZA DOZIRANJE BIOCIDA', N'C1', 9);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.10', N'LOVILNA SKLEDA - PALETA', N'C1', 10);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.11', N'RAZDELILNIK STOLPNE VODE', N'C1', 11);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C1.12', N'RAZDELILNIK/ZBIRALNIK STOLPNE VODE', N'C1', 12);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C2.1', N'VODOMER', N'C2', 13);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C2.2', N'MERILNIK TLAKA', N'C2', 14);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C2.3', N'MERILNIK TEMPERATURE', N'C2', 15);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C2.4', N'NIVOJSKO STIKALO', N'C2', 16);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C2.5', N'MERILNIK PREVODNOSTI', N'C2', 17);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C2.6', N'MANOMETER', N'C2', 18);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C2.7', N'TERMOMETER', N'C2', 19);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.1', N'ZAPORNA LOPUTA - MOTORNI POGON - ON/OFF', N'C3', 20);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.2', N'ZAPORNA LOPUTA - MOTORNI POGON - REGULACIJSKA', N'C3', 21);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.3', N'KROGELNI 3-POTNI VENTIL - MOTORNI POGON - ON/OFF', N'C3', 22);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.4', N'ELEKTROMOTORNI KROGELNI ZAPORNI VENTIL - PRIROBNIČNI', N'C3', 23);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.5', N'ELEKTROMAGNETNI ZAPORNI VENTIL', N'C3', 24);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.6', N'PNEVMATSKI POŠEVNOSEDEŽNI VENTIL', N'C3', 25);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.7', N'KROGELNI ZAPORNI VENTIL - NAVOJNI', N'C3', 26);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.8', N'KROGELNI ZAPORNI VENTIL - PRIROBNIČNI', N'C3', 27);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.9', N'KROGELNI ZAPORNI VENTIL - VARILNI', N'C3', 28);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.10', N'ZAPORNA LOPUTA - ROČNA', N'C3', 29);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.11', N'ZAPORNA LOPUTA - ROČNA', N'C3', 30);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.12', N'NEPOVRATNA LOPUTA:', N'C3', 31);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.13', N'NEPOVRATNI VENTIL', N'C3', 32);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.14', N'NEPOVRATNI VENTIL', N'C3', 33);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.15', N'DUŠILNI VENTIL', N'C3', 34);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.16', N'LOVILEC NEČISTOČ', N'C3', 35);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.17', N'VARNOSTNI VENTIL:', N'C3', 36);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.18', N'AVTOMATSKI ODZRAČEVALNI LONČEK', N'C3', 37);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.19', N'MANOMETRSKI VENTIL', N'C3', 38);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C3.20', N'KOMPENZATOR', N'C3', 39);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.1', N'CEV, NERJAVNA', N'C4', 40);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.2', N'KOLENO 90°, NERJAVNO', N'C4', 41);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.3', N'KOLENO 90°, NERJAVNO', N'C4', 42);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.4', N'KOLENO 45°, NERJAVNO', N'C4', 43);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.5', N'T-KOS, NERJAVNI', N'C4', 44);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.6', N'REDUCIRNI T-KOS, NERJAVNI', N'C4', 45);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.7', N'REDUCIRNI KOS, NERJAVNI', N'C4', 46);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.8', N'PRIROBNICA, NERJAVNA', N'C4', 47);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.9', N'PRIROBNICA, SLEPA, NERJAVNA', N'C4', 48);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.10', N'GIBKA CEV', N'C4', 49);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C4.11', N'VICTAULIC SPOJKA', N'C4', 50);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C5.1', N'CEV, PE100', N'C5', 51);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C5.2', N'PP PRIROBNICA', N'C5', 52);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C5.3', N'IZDELAVA ODCEPA', N'C5', 53);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C5.4', N'CEVNA UVODNICA', N'C5', 54);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C6.1', N'DRSNA PODPORA
Višinsko nastavljivo (90-110mm) pomično ležišče za drsne pritrditve cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje 5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip D.P.1)
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2', N'C6', 55);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C6.2', N'DRSNA PODPORA Z BOČNIM VODENJEM
Višinsko nastavljivo (90-110mm)  pomično ležišče za drsne pritrditve cevi  z dodatnim elementom za bočno vodenje v aksialni smeri. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje 5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip B.V.1)
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2 + ustrezno bočno vodilo', N'C6', 56);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C6.3', N'FIKSNA TOČKA
Višinsko nastavljivo (90-110mm) ležišče, z dodatnim elementom za fiksno pritrditev cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje 5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom. Dispozicija in način izvedbe glede na risbe tega načrta (tip F.T.1).
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2 + ustreznen fiksirni element', N'C6', 57);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C6.4', N'FIKSNA TOČKA
Fiksna točka, izdelana po meri, za fiksiranje vertikalnega cevovoda na talno AB ploščo (preboj).
2x streme + podporne konzole. Nerjavna izvedba (1.4301). Vključno z vijačnim in pritrdilnim materialom.', N'C6', 58);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C6.5', N'OBEŠALO
Obešalo cevovodov, sestavljeno iz: objemke cevovoda s profilirano gumo, plošče za pritrditev, ustrezen povezovalni element (navojna palica ali navojni adapter). Izdelano iz pocinkane pločevine. Za delovno temperaturno območje 0 do 40°C. Primerno za montažo na jekleno podporno konstrukcijo ali v AB ploščo. Vključno z vijačnim in pritrdilnim materialom. Dispozicija in način izvedbe glede na risbe tega načrta (tip O.1).
Ustreza: Sikla GPL + objemka Stabil D-3G m.E ali ekvivalent Hilti', N'C6', 59);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (3, N'C6.6', N'JEKLENE PODPORNE KONSTRUKCIJE PODPOR CEVOVODOV
Iz pocinkanega materiala, vključuje sistemske modularne nosilce ustreznih dimenzij glede na podpore cevovodov, pripadajoče originalne spojne elemnte, vijačni material, zaključne pokrove in fiksiranje na nosilne konstrukcije na trasi cevovodov. Velikost podporne konstrukcije definirati glede na obtežbo, skladno z vsebino tega načrta. Ocena teže.
Ustreza: Sikla SiMotec 100, Sikla SiMotec 80, Sikla SiConnect 41/41 ali ekvivalent Hilti', N'C6', 60);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D1.1', N'HLADILNI STOLP', N'D1', 1);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D1.2', N'ČRPALKA, centrifugalna', N'D1', 2);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D1.3', N'VZORČNO MESTO ZA NADZOR STOLPNE VODE', N'D1', 3);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D1.4', N'SISTEM ZA DOZIRANJE INHIBITORJA', N'D1', 4);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D1.5', N'SISTEM ZA DOZIRANJE BIOCIDA', N'D1', 5);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D1.6', N'LOVILNA SKLEDA - PALETA', N'D1', 6);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D1.7', N'RAZDELILNIK STOLPNE VODE', N'D1', 7);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D1.8', N'RAZDELILNIK/ZBIRALNIK STOLPNE VODE', N'D1', 8);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D1.9', N'ZBIRALNIK STOLPNE VODE', N'D1', 9);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D2.1', N'MERILNIK PRETOKA', N'D2', 10);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D2.2', N'VODOMER', N'D2', 11);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D2.3', N'PRETOČNO STIKALO', N'D2', 12);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D2.4', N'MERILNIK TLAKA', N'D2', 13);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D2.5', N'MERILNIK TEMPERATURE', N'D2', 14);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D2.6', N'MERILNIK NIVOJA', N'D2', 15);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D2.7', N'MANOMETER', N'D2', 16);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D2.8', N'TERMOMETER', N'D2', 17);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D2.9', N'NIVOJSKO STIKALO', N'D2', 18);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.1', N'ZAPORNA LOPUTA - MOTORNI POGON - ON/OFF', N'D3', 19);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.2', N'ZAPORNA LOPUTA - MOTORNI POGON - REGULACIJSKA', N'D3', 20);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.3', N'KROGELNI VENTIL - MOTORNI POGON - ON/OFF', N'D3', 21);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.4', N'ELEKTROMAGNETNI ZAPORNI VENTIL', N'D3', 22);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.5', N'KROGELNI ZAPORNI VENTIL - NAVOJNI', N'D3', 23);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.6', N'KROGELNI ZAPORNI VENTIL - PRIROBNIČNI', N'D3', 24);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.7', N'KROGELNI ZAPORNI VENTIL - VARILNI', N'D3', 25);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.8', N'ZAPORNA LOPUTA - ROČNA', N'D3', 26);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.9', N'ZAPORNA LOPUTA - ROČNA', N'D3', 27);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.10', N'ZAPORNI ZASUN - ROČNI', N'D3', 28);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.11', N'NEPOVRATNA LOPUTA:', N'D3', 29);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.12', N'DUŠILNI VENTIL - PRIROBNIČNI', N'D3', 30);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.13', N'DUŠILNI VENTIL', N'D3', 31);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.14', N'LOVILEC NEČISTOČ', N'D3', 32);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D3.15', N'VARNOSTNI VENTIL', N'D3', 34);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D4.1', N'CEV, NERJAVNA', N'D4', 35);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D4.2', N'KOLENO 90°, NERJAVNO', N'D4', 36);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D4.3', N'KOLENO 45°, NERJAVNO', N'D4', 37);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D4.4', N'T-KOS, NERJAVNI', N'D4', 38);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D4.5', N'T-KOS REDUCIRNI, NERJAVNI', N'D4', 39);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D4.6', N'REDUCIRNI KOS, NERJAVNI', N'D4', 40);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D4.7', N'PRIROBNICA, NERJAVNA', N'D4', 41);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D4.8', N'PRIROBNICA, SLEPA, NERJAVNA', N'D4', 42);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D4.9', N'CEV, NERJAVNA - za gibke cevi kemikalij', N'D4', 43);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D5.1', N'DRSNA PODPORA
Višinsko nastavljivo (90-110mm) pomično ležišče za drsne pritrditve cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje 5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip D.P.1)
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2', N'D5', 44);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D5.2', N'DRSNA PODPORA Z BOČNIM VODENJEM
Višinsko nastavljivo (90-110mm)  pomično ležišče za drsne pritrditve cevi  z dodatnim elementom za bočno vodenje v aksialni smeri. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje 5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip B.V.1)
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2 + ustrezno bočno vodilo', N'D5', 45);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D5.3', N'FIKSNA TOČKA
Višinsko nastavljivo (90-110mm) ležišče, z dodatnim elementom za fiksno pritrditev cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje -5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom. Dispozicija in način izvedbe glede na risbe tega načrta (tip F.T.1).
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2 + ustreznen fiksirni element', N'D5', 46);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D5.4', N'FIKSNA TOČKA
Fiksna točka, izdelana po meri, za fiksiranje vertikalnega cevovoda na talno AB ploščo bazena.
Izdelava podpore v kolenu cevovoda (cev + naležna pločevina). Izdelano iz nerjavnega materiala (1.4301). Vključno z vijačnim in pritrdilnim materialom in morebitno sanacijo vodotesnega nanosa.', N'D5', 47);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D5.5', N'OBEŠALO
Obešalo cevovodov, sestavljeno iz: objemke cevovoda s profilirano gumo, plošče za pritrditev, ustrezen povezovalni element (navojna palica ali navojni adapter). Izdelano iz pocinkane pločevine. Za delovno temperaturno območje 0 do 40°C. Primerno za montažo na jekleno podporno konstrukcijo ali v AB ploščo. Vključno z vijačnim in pritrdilnim materialom. Dispozicija in način izvedbe glede na risbe tega načrta (tip O.1).
Ustreza: Sikla GPL + objemka Stabil D-3G m.E ali ekvivalent Hilti', N'D5', 48);
INSERT INTO EX.HeaderSubgroups (SectionID, GroupCode, Title, ParentCode, SortOrder)
VALUES (4, N'D5.6', N'JEKLENE PODPORNE KONSTRUKCIJE PODPOR CEVOVODOV
Iz pocinkanega materiala, vključuje sistemske modularne nosilce ustreznih dimenzij glede na podpore cevovodov, pripadajoče originalne spojne elemnte, vijačni material, zaključne pokrove in fiksiranje na nosilne konstrukcije na trasi cevovodov. Velikost podporne konstrukcije definirati glede na obtežbo, skladno z vsebino tega načrta. Ocena teže.
Ustreza: Sikla SiMotec 100, Sikla SiMotec 80, Sikla SiConnect 41/41 ali ekvivalent Hilti', N'D5', 49);
GO

UPDATE EX.HeaderSubgroups SET HeaderGroupId = (SELECT Id FROM ex.HeaderGroups HG WHERE LEFT(HSG.GroupCode,2)=HG.GroupCode)
FROM EX.HeaderSubgroups HSG

SET IDENTITY_INSERT EX.Components ON
-- Insert components
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (1, 2, N'A1.1', NULL, 
N'Serijsko tovarniško izdelan vodno hlajen hladilnik tekočin za pripravo 50% etilen-glikolske mešanice. Dobava: nerazloženo na tovornjaku . Vnos v objekt z uporabo avtodvigala, transport in postavljanje na mesto vgradnje (montaža v 1N, kota + 7,6m, vnosna odprtina š3000xv4500mm). Niveliranje in fiksiranje  na mestu postavitve, vključno s pritrdilnim materialom..  Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje in SCADO v sklopu elektro popisa.', NULL, N'', NULL,
NULL, NULL, NULL, 1);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (2, 2, N'A1.1', NULL, 
N'STROJNE ZAHTEVE:
- protivibracijske podloge
- flow switch na strani hlajenega in hladilnega medija
- mehanski manometri hladiva
- servisni ventili na hladilni strani
- dvojni varnostni ventil
- izolacija na hladnih delih
ELEKTRO ZAHTEVE:
- Elektro omarica z vgrajenim krmilnikom in posluževalnim tablojem
- kartice za priklop na CNS sistem (modbus ali primerljivo)
- priključne sponke za daljinski vklop/izklop agregata, javljanje napake
- regulacija hladilnega agregata neodvisno od hladilnega sistema (regulacija moči glede na potrebe hlad. sist.)
- možnost krmiljenja črpalke kondenzatorja', NULL, N'', NULL,
NULL, NULL, NULL, 2);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (3, 2, N'A1.1', NULL, 
N'Tehnične karkteristike:
- Hlajeni medij: 50 % mešanica etilen glikol - voda
- Hladilni medij: stolpna voda
- Nazivni temperaturni režim, hlajeni medij: -25/-20 °C, pretok 62 m3/h; max dp uparjalnika: 100 kPa
- Nazivni temperaturni režim, hladilni medij: 29/35 °C, pretok 72 m3/h; max dp kondenzatorja: 50 kPa
- Priključki, uparjalnik: victaulic, 2x DN125
- Priključki, kondenzator: victaulic, 4x DN100
- Nazivna hladilna moč: 315 kW
- Regulacija hladilne moči: 15-100%
- Nazivna električna moč: 163 kW (400V, 50 Hz, 3f)
- Nazivna toplotna moč: 477 kW
- Hladivo: R448a
- Okvirni gabariti (DxŠxV): 4500 x 2300 x 2400 mm
- Okvirna teža: 9000 kg
(Poz.: HA 9000.04, HA 9000.05)
(Predvidena oprema: CULE AEGIR 150-2-5SPEC)', 2, N'kpl', NULL,
NULL, NULL, NULL, 3);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (4, 2, N'A1.2', NULL, 
N'Izdelava, dobava in montaža vertikalnega rezervoarja za 50 % etilen-glikolsko mešanico. Temperatura medija -25°C.
Transport in postavljanje na mesto vgradnje (montaža v 1N, kota + 7,6m). Niveliranje in fiksiranje rezervoarja na mestu postavitve, vključno s pritrdilnim materialom. Izdelan skladno z direktivo o tlačni opremi (PED).
Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 4);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (5, 2, N'A1.2', NULL, 
N'Tehnične karakteristike:
- Volumen: 6,6 m3
- Obratovalni tlak:  2 bar(g);
- Maksimalni tlak: 6 bar(g);
- Preizkusni tlak: 8,6 bar(g) 
- Gabariti: premer 1500mm, dolžina ravnega dela 3400mm, skupna višina cca 4300mm;
- Torisferični podnici po DIN 28011
- Material: 1.4301
- Predvidena debelina plašča 8 mm, predvidena debelina podnic 8 mm;
- 4x nosilna nogica z nivelirnimi elementi
- Dolžina priključkov: 100 mm
- Priključki, prirobnični, PN16: 
   - 4 x DN300,
   - 2 x DN50,
- Priključki, navojni: 
   - 1 x 1/2"
   - 1 x 1"
- Revizijska odprtina DN500 (prirobnica+slepa prirobnica)
- Napisna ploščica pritrjena na rezervoar;
Ocena teže: 1600 kg
(Poz: T 9000.01)
(Ustreza: Izdelan po merski skici tega načrta)', 1, N'kpl', NULL,
NULL, NULL, NULL, 5);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (6, 2, N'A1.3', NULL, 
N'Izdelava, dobava in montaža zbiralnika/razdelilnika za 50 % etilen-glikolsko mešanico. Obratovalna emperatura medija -25°C. Transport in postavljanje na mesto vgradnje (montaža v 1N, kota + 7,6m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz cevi ter cevnih kap. Protikorozijsko zaščiten z barvanjem 2x osnovni + 2x končni premaz, z barvo ustrezno za obratovalne pogoje.  Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 6);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (7, 2, N'A1.3', NULL, 
N'Tehnične karakteristike:
- DN400 - Ø406,4mm, skupna dolžina cca 2300 mm
- 2x cevna kapa DN400
- Prirobnični priključki, EN1092-1, tip 11, PN16: 
    2x DN150 (Ø168,3mm),
    1x DN250 (Ø273mm),
    1x DN300 (Ø323,9mm);
- Navojni priključki: 2x 1/2" NN
- Obratovalni tlak:  2 bar(g);
- Maksimalni tlak: 6 bar(g);
- Preizkusni tlak: 8,6 bar(g) 
- Material: 1.4301
- 2x podporna nogica (sedlo)
(Poz: T 9000.02)
(Ustreza: Izdelan po merski skici tega načrta)', 1, N'kpl', NULL,
NULL, NULL, NULL, 7);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (8, 2, N'A1.3', NULL, 
N'Tehnične karakteristike:
- DN400 - Ø406,4mm, skupna dolžina cca 3000 mm
- 2x cevna kapa DN400
- Prirobnični priključki, EN1092-1, tip 11, PN16: 
    2x DN150 (Ø168,3mm)
    1x DN250 (Ø273mm),
    1x DN300 (Ø323,9mm);
- Navojni priključki:
   1x  1/2" NN
   1x  1/2" ZN
- Obratovalni tlak:  2 bar(g);
- Maksimalni tlak: 6 bar(g);
- Preizkusni tlak: 8,6 bar(g) 
- Material: 1.4301
- 2x podporna nogica (sedlo)
(Poz: T 9000.03)
(Ustreza: Izdelan po merski skici tega načrta)', 1, N'kpl', NULL,
NULL, NULL, NULL, 8);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (9, 2, N'A1.3', NULL, 
N'Tehnične karakteristike:
- DN400 - Ø406,4mm, skupna dolžina cca 4500 mm
- 2x cevna kapa DN400
- 1x 2D koleno DN400
- Prirobnični priključki, EN1092-1, tip 11, PN16:     
    1x DN150 (Ø168,3mm),
    3x DN200 (Ø219,1mm)
    1x DN300 (Ø323,9mm);
- Navojni priključki:
    1x 1/2" ZN
    2x manometrska U cev 1/2" NN
- Obratovalni tlak:  2 bar(g);
- Maksimalni tlak: 6 bar(g);
- Preizkusni tlak: 8,6 bar(g) 
- Material: 1.4301
- 3x podporna nogica (sedlo)
(Poz: T 9001.03)
(Ustreza: Izdelan po merski skici tega načrta)', 1, N'kpl', NULL,
NULL, NULL, NULL, 9);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (10, 2, N'A1.4', NULL, 
N'Izdelava, dobava in montaža pravokotnega rezervoarja za etilen-glikolsko mešanico. Vertikalna pregrada po sredinini - dva prekata, en prekat za 50% EG mešanico, drugi prekat za 30% EG mešanico. Temperatura medija 20°C. Odprt na atmosfero (ni tlačna posoda).
Transport in postavljanje na mesto vgradnje (montaža v 1N, kota + 7,6m). Niveliranje in fiksiranje rezervoarja na mestu postavitve, vključno s pritrdilnim materialom.
Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten, ojačitev in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 10);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (11, 2, N'A1.4', NULL, 
N'Tehnične karakteristike:
- Dimenzije (DxŠxV): 2700 x 800 x 2000 mm
- Volumen: 2 x 2 m3
- Obratovalni tlak:  atmosferski
- Maksimalni tlak: atmosferski 
- Material: nerjavno jeklo, 1.4301 (ocena debeline pločevine: 3mm)
- Prirobnični priključki, EN1092-1, tip 11, PN16:     
   - 2 x DN50,
   - 4 x DN40,
   - 2 x DN25,
   - 4 x DN15
- 2x revizijska odprtina 500x500 s pokrovom
- Ustrezne ojačitve
- Jeklena podkonstrukcija (U-profili, skupna dolžina cca 9500 mm)
- Napisna ploščica pritrjena na rezervoar;
Ocena teže: 500 kg
(Poz: T 9012.01 + T 9002.01)
(Ustreza: Izdelan po merski skici tega načrta)', 1, N'kpl', NULL,
NULL, NULL, NULL, 11);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (12, 2, N'A2.1', NULL, 
N'Elektromagnetni merilnik pretoka, primeren za 50% etilen-glikolsko mešanico. 
Prirobnični procesni priključek, obratovalna temperatura medija -25°C, tlak do 8 bar(g). Priključki iz nerjavnega jekla, PTFE obloga. Vključno s pomožnim, montažnim in tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 12);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (13, 2, N'A2.1', NULL, 
N'Tehnične karakteristike:
- Merilno območje: 5 do 100  m3/h, nazivni pretok 70 m3/h
- Priključek: prirobnični, EN 1092-1, DN125, PN16
- Napajanje: 24 V DC
- Izhod: 4 - 20 mA
(Poz: FI 9001.730)
(Ustreza: E+H Promag P 300)', 1, N'kos', NULL,
NULL, NULL, NULL, 13);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (14, 2, N'A2.2', NULL, 
N'Merilnik tlaka, primeren za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Vključno z nerjavno priključno U/O cevko, z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Merilno območje: 0 do 10 bar(g)
- Piezouporovni merilni princip
- Priključek: navojni, G 1/2"
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
(Poz: PI 9000.711, PI 9000.712, PIC 9001.710, PICA 9001.711)
(Ustreza: E+H PMP21)', 4, N'kpl', NULL,
NULL, NULL, NULL, 14);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (15, 2, N'A2.3', NULL, 
N'Merilnik temperature, uporovni, 1x Pt100, s priključno glavo na zaščitnem vratu, primeren za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Z integriranim pretvornikom. Vključno z ustrezno nerjavno zaščitno tulko. Dolžina ustrezna za montažo v cev DN100...DN400. Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Merilno območje: -30 do +60 °C
- 1 x Pt100, 3 žilna vezava
- Priključek: navojni, G 1/2"
- Potopna dolžina 100 mm, dolžina zaščitnega vratu 80 mm
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
(Poz: TI 9000.701, TI 9000.702, TIC 9000.703, TIC 9000.704, TI 9001.700, TI 9001.701, TI 9001.702)
(Ustreza: E+H TM121)', 7, N'kos', NULL,
NULL, NULL, NULL, 15);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (16, 2, N'A2.4', NULL, 
N'Bypass nivokaz, z magnetnim plovcem, in magnetostriktnivnim senzorjem nivoja; PP valjčki za vizualni prikaz in dvema končnima stikaloma. Za montažo na rezervoar glikolske mešanice za dopolnjevanje, gostota medija 1060 kg/m3, delovna temperatura 0 do +40°C, max. tlak 1 bar(g), procesni prirobnični priključek DN15, PN16 (EN 1092), nerjavna izvedba, tlačna stopnja PN16. Dolžino pred kontrolirati glede na razmak med priključkoma na rezervoarju T 9002.01  (predvidoma 1750mm). Napajanje magnetostriktivnega senzorja: 24V DC, izhod 4-20 mA. Vključno s pomožnim, montažnim, elektro in tesnilnim materialom ter s funkcionalno montažo.
(Poz: LI 9002.720 + LSLA 9002.721 + LSHA 9002.722 + LI 9002.723)
(Ustreza: Kobold NBK-M2F15PT10 + 2x NBK-RM)', 1, N'kpl', NULL,
NULL, NULL, NULL, 16);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (17, 2, N'A2.5', NULL, 
N'Lokalni manometer za prikaz tlaka 50% etilen-glikolske mešanice. Temperatura medija -25 do 40°C. 
Vključno z nerjavno priključno U cevko, z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm
- Polnilo: silikonsko olje', NULL, N'', NULL,
NULL, NULL, NULL, 17);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (18, 2, N'A2.5', NULL, 
N'Merilno območje 0 - 4 bar(g)
Radialni priključek
(Poz: PI 9000.910, PI 9000.911, PI 9000.912, PI 9000.913, PI 9000.914, PI 9000.915, PI 9000.916, PI 9001.910, PI 9001.912, PI 9002.910)
(Ustreza: INOL IM 821 DN100)', 10, N'kpl', NULL,
NULL, NULL, NULL, 18);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (19, 2, N'A2.5', NULL, 
N'Merilno območje 0 - 10 bar(g)
(Poz: PI 9001.911)
(Ustreza: INOL IM 821 DN100)', 1, N'kpl', NULL,
NULL, NULL, NULL, 19);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (20, 2, N'A2.6', NULL, 
N'Lokalni direktni termometer za prikaz temperature 50% etilen-glikolske mešanice. Industrijski termometer, ki deluje na principu spremembe volumna polnila v tipalu, ki se preko membranske kapsule in mehanizma prenaša na kazalec. Tlak medija do 8 bar(g). Vključno z ustrezno nerjavno zašitno tulko.  Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm', NULL, N'', NULL,
NULL, NULL, NULL, 20);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (21, 2, N'A2.6', NULL, 
N'Merilno območje -40 / +40°C
Aksialni priključek
(Poz: TI 9000.901, TI 9000.902, TI 9000.903, TI 9000.904, TI 9000.905, TI 9000.906, TI 9001.900, TI 9001.902, TI 9011.901)
(Ustreza: INOL TI-291 DN100 + tulka)', 9, N'kpl', NULL,
NULL, NULL, NULL, 21);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (22, 2, N'A3.1', NULL, 
N'Trodelni krogelni ventil, z razbremenitvijo tlaka v vmesnem prostoru ventila (luknjica ali razbremenilno tesnilo), industrijska izvedba, za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: trodelni krogelni ventil, z razbremenilno luknjico
- Priključek: varilni
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 22);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (23, 2, N'A3.1', NULL, 
N'DN40
(Poz:V 9002.030, V 9002.031)
(Ustreza: END Armaturen ZE31 - z luknjico)', 2, N'kos', NULL,
NULL, NULL, NULL, 23);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (24, 2, N'A3.1', NULL, 
N'DN40 s ključavnico
(Poz: V 9000.004, V 9002.032)
(Ustreza: END Armaturen ZE31 - z luknjico + ključavnica)', 2, N'kos', NULL,
NULL, NULL, NULL, 24);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (25, 2, N'A3.2', NULL, 
N'Dvodelni krogelni ventil, z razbremenitvijo tlaka v vmesnem prostoru ventila (luknjica ali razbremenilno tesnilo) v odprtem in zaprtem položaju, industrijska izvedba, za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: dvodelni krogelni ventil, z razbremenilno luknjico
- Priključek: prirobnični, po EN 1092
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 25);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (26, 2, N'A3.2', NULL, 
N'DN15
(Poz: V 9002.012, V 9002.013)
(Ustreza: END Armaturen MP31 - z luknjico)', 2, N'kos', NULL,
NULL, NULL, NULL, 26);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (27, 2, N'A3.2', NULL, 
N'DN25
(Poz: V 9002.001, V 9002.004, V 9002.005, V 9002.008, V 9002.010, V 9002.020, V 9002.023)
(Ustreza: END Armaturen MP31 - z luknjico)', 7, N'kos', NULL,
NULL, NULL, NULL, 27);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (28, 2, N'A3.3', NULL, 
N'Zaporna loputa, medprirobnična wafer izvedba, primerna za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Loputa mora zagotavljati razred tesnenja A po EN 12266-1. Vključno s spojnim, vijačnim, tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: dvojni offset
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: Ročni polžni pogon
- Material: Jeklena litina, disk nerjavno jeklo
- Tesnila: R-PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 28);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (29, 2, N'A3.3', NULL, 
N'DN 150
(Poz: BV 9000.001, BV 9000.002, BV 9000.110, BV 9000.116, BV 9000.140, BV 9000.146, BV 9001.010, BV 9001.013, BV 9001.014, BV 9001.017, BV 9001.030, BV 9001.110, BV 9001.121)
(Ustreza: ABO 2E5 5590B-GB DN150 PN16 z ročnim polžnim pogonom)', 13, N'kos', NULL,
NULL, NULL, NULL, 29);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (30, 2, N'A3.3', NULL, 
N'DN 300
(Poz: BV 9000.101, BV 9001.001, BV 9001.003, BV 9001.101, BV 9001.102)
(Ustreza: ABO 2E5 5590B-GB DN300 PN16 z ročnim polžnim pogonom)', 5, N'kos', NULL,
NULL, NULL, NULL, 30);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (31, 2, N'A3.4', NULL, 
N'Nepovratna loputa, za vertikalno vgradnjo brez vzmeti, primerna za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: medprirobnični, EN1092-1, PN16 
- Material: ohišje 1.0460, disk 1.4581
- Tesnilo: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 31);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (32, 2, N'A3.4', NULL, 
N'DN 125
(Poz: CV 9000.113, CV 9000.143, CV 9001.012, CV 9001.016)
(Ustreza: Gestra CB26)', 4, N'kos', NULL,
NULL, NULL, NULL, 32);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (33, 2, N'A3.5', NULL, 
N'Nepovratni ventil - kompaktna disk izvedba, z vzmetjo, primerna za 50% etilen-glikolsko mešanico. Temperatura medija 5 do 40 °C, tlak do 8 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: medprirobnični, EN1092-1, PN16 
- Material: 1.4317, disk 1.4571
- Mehko tesnenje, tesnilo EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 33);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (34, 2, N'A3.5', NULL, 
N'DN 25
(Poz: CV 9002.003, CV 9002.007, CV 9002.009)
(Ustreza: Gestra RK86)', 3, N'kos', NULL,
NULL, NULL, NULL, 34);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (35, 2, N'A3.6', NULL, 
N'Lovilnik nesnage, primeren za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 4 bar(g). Vključno s spojnim, vijačnim, tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični, EN1092-1, PN16 
- Material: 1.0619+N
- Sito: standardno, nerjavno (1.4301)', NULL, N'', NULL,
NULL, NULL, NULL, 35);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (36, 2, N'A3.6', NULL, 
N'DN 15
(Poz: SF 9002.021, SF 9002.024)
(Ustreza: ARI Armaturen, tip 34.050)', 2, N'kos', NULL,
NULL, NULL, NULL, 36);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (37, 2, N'A3.6', NULL, 
N'DN 150
Z izpustnim (čistilnim) vijakom na čistilnem pokrovu. 
(Poz: SF 9000.111, SF 9000.141)
(Ustreza: ARI Armaturen, tip 34.050)', 2, N'kos', NULL,
NULL, NULL, NULL, 37);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (38, 2, N'A3.6', NULL, 
N'DN 300
Z izpustnim (čistilnim) vijakom na čistilnem pokrovu. 
(Poz: SF 9001.002)
(Ustreza: ARI Armaturen, tip 34.050)', 1, N'kos', NULL,
NULL, NULL, NULL, 38);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (39, 2, N'A3.7', NULL, 
N'Varnostni ventil, razbremenilna funkcija, ustrezen za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. Priložen certifikat testa.', NULL, N'', NULL,
NULL, NULL, NULL, 39);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (40, 2, N'A3.7', NULL, 
N'Tehnične karakteristike:
- Priključek: navojni
- Material: nerjavno jeklo
- Tlak odpiranja: 6 bar(g)
- Zaprta izvedba mehanizma
- Vzmetni, prednastavljen.', NULL, N'', NULL,
NULL, NULL, NULL, 40);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (41, 2, N'A3.7', NULL, 
N'DN 15 / DN 15
(Poz: SV 9000.121, SV 9000.151)
(Ustreza: ARI TCP - Fig. 57.961 )', 2, N'kos', NULL,
NULL, NULL, NULL, 41);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (42, 2, N'A3.7', NULL, 
N'DN 25 / DN 25
(Poz: SV 9000.007)
(Ustreza: ARI TCP - Fig. 57.961 )', 1, N'kos', NULL,
NULL, NULL, NULL, 42);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (43, 2, N'A3.8', NULL, 
N'Manometrski iglični ventil, navojni priključek: G 1/2". Material: nerjavni (1.4301 ali boljše).
Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.', NULL, N'', NULL,
NULL, NULL, NULL, 43);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (44, 2, N'A3.8', NULL, 
N'Z odprtino za razbremenitev (DIN 16270).  
(Poz: V 9000.008, V 9000.115, V 9000.119, V 9000.132, V 9000.145, V 9000.149, V 9000.162, V 9001.005, V 9001.035, V 9001.104, V 9002.004)
(Ustreza: INOL manom. ventil (inox) DIN16270)', 11, N'kos', NULL,
NULL, NULL, NULL, 44);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (45, 2, N'A3.8', NULL, 
N'Z odprtino za razbremenitev in testnim priključkom (DIN 16271)
(Poz: V 9000.114, V 9000.144, V 9001.036, V 9001.105)
(Ustreza: INOL manom. ventil (inox) DIN16271)', 4, N'kos', NULL,
NULL, NULL, NULL, 45);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (46, 2, N'A4.1', NULL, 
N'Cev, varjena, nerjavna - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10217-7,  certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 46);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (47, 2, N'A4.1', NULL, 
N'DN 15 (Ø21,3 x 1,6 mm)', 70, N'm', NULL,
NULL, NULL, NULL, 47);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (48, 2, N'A4.1', NULL, 
N'DN 25 (Ø33,7 x 1,6 mm)', 5, N'm', NULL,
NULL, NULL, NULL, 48);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (49, 2, N'A4.1', NULL, 
N'DN 32 (Ø42,4 x 1,6 mm)', 1, N'm', NULL,
NULL, NULL, NULL, 49);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (50, 2, N'A4.1', NULL, 
N'DN 40 (Ø48,3 x 1,6 mm)', 25, N'm', NULL,
NULL, NULL, NULL, 50);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (51, 2, N'A4.1', NULL, 
N'DN 50 (Ø60,3 x 1,6 mm)', 20, N'm', NULL,
NULL, NULL, NULL, 51);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (52, 2, N'A4.1', NULL, 
N'DN 80 (Ø88,9 x 2 mm)', 1, N'm', NULL,
NULL, NULL, NULL, 52);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (53, 2, N'A4.1', NULL, 
N'DN 100 (Ø114,3 x 2 mm)', 5, N'm', NULL,
NULL, NULL, NULL, 53);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (54, 2, N'A4.1', NULL, 
N'DN 125 (Ø139,7 x 2 mm)', 5, N'm', NULL,
NULL, NULL, NULL, 54);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (55, 2, N'A4.1', NULL, 
N'DN 150 (Ø168,3 x 2 mm)', 70, N'm', NULL,
NULL, NULL, NULL, 55);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (56, 2, N'A4.1', NULL, 
N'DN 300 (Ø323,9 x 3 mm)', 13, N'm', NULL,
NULL, NULL, NULL, 56);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (57, 2, N'A4.2', NULL, 
N'Koleno, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 57);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (58, 2, N'A4.2', NULL, 
N'DN 15 (Ø21,3 x 1,6 mm)', 25, N'kos', NULL,
NULL, NULL, NULL, 58);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (59, 2, N'A4.2', NULL, 
N'DN 25 (Ø33,7 x 1,6 mm)', 5, N'kos', NULL,
NULL, NULL, NULL, 59);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (60, 2, N'A4.2', NULL, 
N'DN 40 (Ø48,3 x 1,6 mm)', 30, N'kos', NULL,
NULL, NULL, NULL, 60);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (61, 2, N'A4.2', NULL, 
N'DN 50 (Ø60,3 x 1,6 mm)', 8, N'kos', NULL,
NULL, NULL, NULL, 61);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (62, 2, N'A4.2', NULL, 
N'DN 150 (Ø168,3 x 2 mm)', 25, N'kos', NULL,
NULL, NULL, NULL, 62);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (63, 2, N'A4.2', NULL, 
N'DN 300 (Ø323,9 x 3 mm)', 7, N'kos', NULL,
NULL, NULL, NULL, 63);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (64, 2, N'A4.3', NULL, 
N'Koleno 45°, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 64);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (65, 2, N'A4.3', NULL, 
N'DN 150 (Ø168,3 x 2 mm)', 5, N'kos', NULL,
NULL, NULL, NULL, 65);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (66, 2, N'A4.3', NULL, 
N'DN 300 (Ø323,9 x 3 mm)', 4, N'kos', NULL,
NULL, NULL, NULL, 66);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (67, 2, N'A4.4', NULL, 
N'T-kos, nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 67);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (68, 2, N'A4.4', NULL, 
N'DN 25 (Ø33,7 x 1,6 mm)', 2, N'kos', NULL,
NULL, NULL, NULL, 68);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (69, 2, N'A4.4', NULL, 
N'DN 40 (Ø48,3 x 1,6 mm)', 1, N'kos', NULL,
NULL, NULL, NULL, 69);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (70, 2, N'A4.4', NULL, 
N'DN 50 (Ø60,3 x 1,6 mm)', 1, N'kos', NULL,
NULL, NULL, NULL, 70);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (71, 2, N'A4.5', NULL, 
N'Reducirni ''T-kos, nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 71);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (72, 2, N'A4.5', NULL, 
N'DN 40/25', 1, N'kos', NULL,
NULL, NULL, NULL, 72);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (73, 2, N'A4.6', NULL, 
N'Reducirni kos. nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 73);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (74, 2, N'A4.6', NULL, 
N'DN 40/25', 1, N'kos', NULL,
NULL, NULL, NULL, 74);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (75, 2, N'A4.6', NULL, 
N'DN 125/100', 2, N'kos', NULL,
NULL, NULL, NULL, 75);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (76, 2, N'A4.6', NULL, 
N'DN 150/100', 4, N'kos', NULL,
NULL, NULL, NULL, 76);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (77, 2, N'A4.6', NULL, 
N'DN 150/125', 10, N'kos', NULL,
NULL, NULL, NULL, 77);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (78, 2, N'A4.7', NULL, 
N'Varilna prirobnica z grlom.
- dimenzije po EN 1092-1, tip 11, B1;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim, vijačnim in varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot fiting)', NULL, N'', NULL,
NULL, NULL, NULL, 78);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (79, 2, N'A4.7', NULL, 
N'DN 15, PN16', 6, N'kos', NULL,
NULL, NULL, NULL, 79);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (80, 2, N'A4.7', NULL, 
N'DN 25, PN16', 19, N'kos', NULL,
NULL, NULL, NULL, 80);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (81, 2, N'A4.7', NULL, 
N'DN 40, PN16', 2, N'kos', NULL,
NULL, NULL, NULL, 81);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (82, 2, N'A4.7', NULL, 
N'DN 50, PN16', 1, N'kos', NULL,
NULL, NULL, NULL, 82);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (83, 2, N'A4.7', NULL, 
N'DN 100, PN16', 10, N'kos', NULL,
NULL, NULL, NULL, 83);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (84, 2, N'A4.7', NULL, 
N'DN 125, PN16', 8, N'kos', NULL,
NULL, NULL, NULL, 84);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (85, 2, N'A4.7', NULL, 
N'DN 150, PN16', 30, N'kos', NULL,
NULL, NULL, NULL, 85);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (86, 2, N'A4.7', NULL, 
N'DN 300, PN16', 8, N'kos', NULL,
NULL, NULL, NULL, 86);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (87, 2, N'A4.8', NULL, 
N'Slepa prirobnica.
- dimenzije po EN 1092-1, tip 05;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim in  vijačnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 87);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (88, 2, N'A4.8', NULL, 
N'DN 200, PN16', 10, N'kos', NULL,
NULL, NULL, NULL, 88);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (89, 2, N'A4.8', NULL, 
N'DN 250, PN16', 2, N'kos', NULL,
NULL, NULL, NULL, 89);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (90, 2, N'A4.9', NULL, 
N'Odzračevalni lonec, izdelan iz cevi DN 100, material 1.4301.  Dolžina cca 250mm, z zaključnima kapama po EN 10253-4.
Varilni priključek spodaj DN 32, varilni priključek zgoraj DN 15. Vgradnja na cevovode DN100 do DN350, vključno z izdelavo odcepa na cevovodu in varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cevovod).', 7, N'kos', NULL,
NULL, NULL, NULL, 90);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (91, 2, N'A4.10', NULL, 
N'Izdelava, dobava in montaža nerjavnega zbirnega lijaka odzračevanj. Primeren za glikol in vodo. Dimenzije (d x š x v) cca : 500x150x250, iztok DN50 (varilni priključek). S konzolo za pritrditev na AB steno. Vključno s pomožnim, montažnim in pritrdilnim materialom.', 2, N'kos', NULL,
NULL, NULL, NULL, 91);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (92, 2, N'A4.11', NULL, 
N'Victaulic spojka, vključno z varilnim adapterjem, ustreznim za povezovanje na nerjavni cevovod. Tesnilo ustrezno za obratovalne temperature -25°C, tlak do 8 bar(g). Dimenzijo kontrolirati glede na priključke na uparjalniku dobavljenega hladilnega agregata.', NULL, N'', NULL,
NULL, NULL, NULL, 92);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (93, 2, N'A4.11', NULL, 
N'DN 125 (Ø139,7 x 2 mm)', 4, N'kos', NULL,
NULL, NULL, NULL, 93);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (94, 2, N'A4.12', NULL, 
N'Varilna ferula+tesnilo+slepa prirobnica + objemka. Material 1.4301 ali boljši. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 94);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (95, 2, N'A4.12', NULL, 
N'DN 40-Ø48,3x2, A=64 mm', 1, N'kpl', NULL,
NULL, NULL, NULL, 95);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (96, 2, N'A5.1', NULL, 
N'DN 150', 4, N'kpl', NULL,
NULL, NULL, NULL, 96);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (97, 2, N'A5.2', NULL, 
N'DN 150', 12, N'kpl', NULL,
NULL, NULL, NULL, 97);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (98, 2, N'A5.2', NULL, 
N'DN 300', 2, N'kpl', NULL,
NULL, NULL, NULL, 98);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (99, 2, N'A5.3', NULL, 
N'DN 150', 4, N'kpl', NULL,
NULL, NULL, NULL, 99);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (100, 2, N'A5.4', NULL, 
N'DN 15', 40, N'kos', NULL,
NULL, NULL, NULL, 100);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (101, 2, N'A5.4', NULL, 
N'DN 25', 3, N'kos', NULL,
NULL, NULL, NULL, 101);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (102, 2, N'A5.4', NULL, 
N'DN 40', 15, N'kos', NULL,
NULL, NULL, NULL, 102);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (103, 2, N'A5.4', NULL, 
N'DN 50', 10, N'kos', NULL,
NULL, NULL, NULL, 103);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (104, 2, N'A5.6', NULL, 
N'DN 15 - cevaki, debelina = 19 mm', 70, N'm', NULL,
NULL, NULL, NULL, 104);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (105, 2, N'A5.6', NULL, 
N'DN 25 - cevaki, debelina = 19 mm', 5, N'm', NULL,
NULL, NULL, NULL, 105);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (106, 2, N'A5.6', NULL, 
N'DN 32 - cevaki, debelina = 19 mm', 1, N'm', NULL,
NULL, NULL, NULL, 106);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (107, 2, N'A5.6', NULL, 
N'DN 40 - cevaki, debelina = 25 mm', 25, N'm', NULL,
NULL, NULL, NULL, 107);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (108, 2, N'A5.6', NULL, 
N'DN 50 - cevaki, debelina = 32 mm', 20, N'm', NULL,
NULL, NULL, NULL, 108);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (109, 2, N'A5.6', NULL, 
N'DN 80 - cevaki, debelina = 32 mm', 1, N'm', NULL,
NULL, NULL, NULL, 109);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (110, 2, N'A5.6', NULL, 
N'DN 100 - cevaki, debelina = 40 mm', 5, N'm', NULL,
NULL, NULL, NULL, 110);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (111, 2, N'A5.6', NULL, 
N'DN 125 - cevaki, debelina = 40 mm', 5, N'm', NULL,
NULL, NULL, NULL, 111);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (112, 2, N'A5.6', NULL, 
N'DN 150 - plošče, debelina = 40 mm', 70, N'm', NULL,
NULL, NULL, NULL, 112);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (113, 2, N'A5.6', NULL, 
N'DN 300 - plošče, debelina = 50 mm', 13, N'm', NULL,
NULL, NULL, NULL, 113);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (114, 2, N'A5.7', NULL, 
N'Hidravlična kretnica  - plošče - dvoslojno, debelina = 64 mm (32+32 mm), ocena površine: 20 m2', 1, N'kpl', NULL,
NULL, NULL, NULL, 114);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (115, 2, N'A5.7', NULL, 
N'Razdelilnik  - plošče - dvoslojno, debelina = 50 mm (25+25 mm), ocena površine: 5 m2', 4, N'kpl', NULL,
NULL, NULL, NULL, 115);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (116, 2, N'A5.7', NULL, 
N'Razdelilnik  - plošče - dvoslojno, debelina = 50 mm (25+25 mm), ocena površine: 8 m2', 1, N'kpl', NULL,
NULL, NULL, NULL, 116);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (117, 2, N'A5.7', NULL, 
N'Črpalka  - plošče - dvoslojno, debelina = 44 mm (25+19 mm), ocena površine: 2 m2', 4, N'kpl', NULL,
NULL, NULL, NULL, 117);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (118, 3, N'C1.1', NULL, 
N'Serijsko tovarniško izdelan hladilni stolp odprte, protitočne izvedbe s sesalnim prepihavanjem zraka s pomočjo dveh aksialnih ventilatorjev. Elektromotorji ventilatorjev so enostopenjski, za delovanje v omočenem ozračju, primerni za ločen frekvenčni pretvornik.   Dobava: nerazloženo na tovornjaku. Vnos na streho objekta z uporabo avtodvigala, transport in postavljanje na mesto vgradnje (kota +20 m). Niveliranje in fiksiranje  na mestu postavitve, na pripravljeno konstrukcijo, vključno s pritrdilnim materialom.  Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje v sklopu elektro popisa.', NULL, N'', NULL,
NULL, NULL, NULL, 1);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (119, 3, N'C1.1', NULL, 
N'STROJNE ZAHTEVE:
- vibracijsko stikalo
- zaščitna mreža na ventilatorjih
- ventilatorji z nižjo stropnjo hrupa
- električni grelci v prostoru elektromotorja
- remote sump (iztok na dnu, za popolno izpraznitev ob zaustavitvi)
ELEKTRO ZAHTEVE:
- elektromotor IE3
- PTC zaščita elektromotorja
- motor ustrezen za ločen frekvenčni pretvornik', NULL, N'', NULL,
NULL, NULL, NULL, 2);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (120, 3, N'C1.1', NULL, 
N'Tehnične karakteristike:
Tehnične karakteristike se navaja pri naslednjih pogojih:
  -temperatura vlažnega termometra vstopnega zraka: 24 °C    
  -temperaturni režim hlajene vode: 35/29 °C  
 - hladilna moč : 2700 kW
- dovodni priključek: 2x DN200 (varilni priključek)
- iztok na dnu: 1x DN350 (varilni priključek)
- elektromotorja ventilatorjev: 2x15 kW; 3x400V, 50 Hz
- Okvirne dimenzije (DxŠxV): 2400 x 6450 x 4400 mm 
- Okvirna teža: 4500 kg, najtežji posamezni del 3100 kg
(Poz.: HS 9023.02, HS 9023.03)
(Predvidena oprema: EVAPCO AT28-4K21)', 2, N'kpl', NULL,
NULL, NULL, NULL, 3);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (121, 3, N'C1.2', NULL, 
N'Enostopenjska centrifugalna črpalka, blok izvedba, črpalka in motor monitrana na skupni osnovni okvir, prirobnični priključek. Ohišje in tekač iz sive litine. Primerna za vodo, temperatura medija 20°C do 40 °C, tlak do 8 bar(g). Tesnila ustrezna glede na medij in obratovalne razmere. Primerna za ločen frekvenčni regulator vrtljajev. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Vključno z nosilno konstrukcijo črpalke in komplet montažnim, pritrdilnim in tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 4);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (122, 3, N'C1.2', NULL, 
N'Tehnične karakteristike:
Priključek: DN100/80, PN16 (po EN 1092);
H= 25 m;
Q= 80 m3/h;
Pe=  11 kW; 4p, 3x400V
(Poz.: P 9021.20, P 9021.21)
(Ustreza: Grundfos NK 80-250/270', 2, N'kos', NULL,
NULL, NULL, NULL, 5);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (123, 3, N'C1.2', NULL, 
N'Tehnične karakteristike:
Priključek: DN150/125, PN16 (po EN 1092);
H= 25 m;
Q= 250 m3/h;
Pe=  30 kW; 4p, 3x400V
(Poz.: P 9022.20, P 9020.21)
(Ustreza: Grundfos NK 125-315/317', 2, N'kos', NULL,
NULL, NULL, NULL, 6);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (124, 3, N'C1.3', NULL, 
N'Enostopenjska centrifugalna črpalka, inline izvedba, prirobnični priključek. Ohišje in tekač iz sive litine. Primerna za vodo, temperatura medija 20°C do 40 °C, tlak do 8 bar(g). Tesnila ustrezna glede na medij in obratovalne razmere. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Vključno z nosilno konstrukcijo črpalke in komplet montažnim, pritrdilnim in tesnilnim materialom.  
Tehnične karakteristike:
Priključek: DN40, PN16 (po EN 1092);
H= 20 m;
Q= 10 m3/h;
Pe= 1,5 kW; 4p, 3x400V
(Poz.: P 9041.20)
(Ustreza: Grundfos TP 40-270/2)', 1, N'kos', NULL,
NULL, NULL, NULL, 7);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (125, 3, N'C1.4', NULL, 
N'Izdelava, dobava in montaža vertikalnega rezervoarja - zalogovnika stolpne vode. Temperatura medija 5 do 40°C.
Transport in postavljanje na mesto vgradnje (montaža v 2N, kota + 13,2m). Niveliranje in fiksiranje rezervoarja na mestu postavitve, vključno s pritrdilnim materialom. Izdelan skladno z direktivo o tlačni opremi (PED).
Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 8);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (126, 3, N'C1.4', NULL, 
N'Tehnične karakteristike:
- Volumen: 9 m3 (delovni); 10 m3 (geometrijski)
- Obratovalni tlak: atmosferski (nalivni)
- Gabariti: premer 2000mm, dolžina ravnega dela 2800mm, skupna višina cca 3850mm;
- Torisferični podnici po DIN 28011
- Material: Nerjavno jeklo, 1.4301
- Predvidena debelina plašča 6 mm, predvidena debelina podnic 6 mm;
- 4x nosilna nogica z nivelirnimi elementi
- Dolžina priključkov: 100 mm
- Priključki, prirobnični, PN16: 
   - 1 x DN400,
   - 2 x DN350,
   - 1 x DN250,
   - 1 x DN150,
   - 1 x DN100,
- Priključki, navojni: 
   - 2 x 3/4" NN
   - 1 x 1/2" ZN
- Revizijska odprtina DN500 (prirobnica+slepa prirobnica)
- Napisna ploščica pritrjena na rezervoar;
Ocena teže: 1700 kg
(Poz: T 9020.02, T 9020.03)
(Ustreza: Izdelan po merski skici tega načrta)', 2, N'kpl', NULL,
NULL, NULL, NULL, 9);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (127, 3, N'C1.5', NULL, 
N'Avtomatski peščeni filter za filtriranje stolpne vode v obvodu. Tlačna posoda iz armiranega poliestra, komplet z ocevjem, vsemi potrebnimi loputami, ventili, šobami in polnitvijo z ustreznim filtrskim medijem - antracit + kremenčev pesek. Krmiljenje: standardni lokalni krmilnik (interno nastavljanje časov pranja) – možnost pranja glede na časovni interval, glede na dP ali preko zunanjega signala. V ceno vključena postavitev opreme, polnjenje filtrirnega materiala, izdelava koračnega diagrama, konfiguracija parametrov in spuščanje v pogon. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje v sklopu elektro popisa.
Tehnične karakteristike:
- nominalni pretok 10 m3/h
- statični tlak: 2 bar
- max dp. pri zamašenem filtru: 1,5 bar
- tlak v sistemu do 4 bar(g)
- izpiranje z zunanjo (tehnološko) vodo, tlak 4 bar
- izhodi na CNS: prikaz stanja (obratovanje/pranje, napaka) + zunanje proženje pranja + 2x 4-20 mA (tlak)
(Poz: F 9041.01)
(Ustreza: MAK-CMC INIF H-7 ali ekvivalentno)', 1, N'kpl', NULL,
NULL, NULL, NULL, 10);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (128, 3, N'C1.6', NULL, 
N'Ionska mehčalna naprava za mehčanje vode, z avtomatsko regeneracijo z raztopino natrijevega klorida (soli). Dvojna izvedba - obratovanje brez prekinitve med regeneracijo.Tlačna posoda iz armiranega poliestra, komplet z ocevjem, vsemi potrebnimi ventili in krmilnikom. Vključno z ločenim dnevnim rezervoar slanice. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m,  vnos skozi odprtino 1,8x1,8m).). Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje v sklopu elektro popisa.', NULL, N'', NULL,
NULL, NULL, NULL, 11);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (129, 3, N'C1.6', NULL, 
N'Centralni solnik, za pripravo slanice, izdelan iz umetnega materiala PP, z vsemi potrebnimi ojačitvami in priključki za črpalko in merilnike, vključno z ustrezno črpalko za kemikalije, za črpanje slanice - izdelana iz PP. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m,  vnos skozi odprtino 1,8x1,8m).). Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje v sklopu elektro popisa.', NULL, N'', NULL,
NULL, NULL, NULL, 12);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (130, 3, N'C1.6', NULL, 
N'Tehnične karakteristike mehčalne naprave:
- nominalni pretok do 30 m3/h
- tlak vstopne vode: 4 bar(g)
- dnevni rezervoar slanice 2,5 m3', NULL, N'', NULL,
NULL, NULL, NULL, 13);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (131, 3, N'C1.6', NULL, 
N'Dodatna oprema za dnevni rezervoar slanice:
-pnevmatski zaporni ventil za slanico
-nivojska stikala
PVC material (cevi, fitingi) za povezavo slanik-dnevni rezervoar slanice (cca 20m)', NULL, N'', NULL,
NULL, NULL, NULL, 14);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (132, 3, N'C1.6', NULL, 
N'Tehnične karakteristike solnika:
- Volumen: 5 m3
- Dimenzije: premer 1600 x višina 2600 mm 
-Odprtina za vsipni kanal: 600x600
-Priključek za dovod vode DN25
-2x Priključek za obvod vode DN25
-Priključek za črpalko: DN 32
-Priključek za stisnjen zrak: DN15
-Varnostni preliv: DN50
-2x Drenažni čep 3/4"
- Centrifugalna črpalka, predvidena kapaciteta 2m3/h pri 5m:', NULL, N'', NULL,
NULL, NULL, NULL, 15);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (133, 3, N'C1.6', NULL, 
N'Dodatna oprema za centralni solnik:
Pnevmatski zaporni ventil za dovod vodovodne vode
Indikator pretoka
Ultrazvočni senzor in transmiter za merjenje nivoja sipke snovi
Radarski senzor nivoja tekočine
Mejna zaščitna stikala (3 kos)
Kolektorska cev za tekočo slanico s sapnicami
PVC material (cevi, fitingi)', NULL, N'', NULL,
NULL, NULL, NULL, 16);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (134, 3, N'C1.6', NULL, 
N'(Poz: MN 9040.01 + T 9040.03+ S 9040.02 + P 9040.20)
(Ustreza: Mehčalna naprava MAK-CMC INOM 7D + rezervar slanice + solnik - izdelan po merski skici)', 1, N'kpl', NULL,
NULL, NULL, NULL, 17);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (135, 3, N'C1.7', NULL, 
N'Naprava za avtomatski nadzor kvalitete stolpne vode in kontrolo delovanja kondicioniranja s kemičnimi dodatki in nadzor odsoljevanja stolpne vode. RS485 komunikacija (Modbus). Kompaktna verzija za stensko montažo. Vključno z ustreznimi cevnimi fitingi za priklop nerjavne cevi DN15 na PVC priključek 25 mm.
Dobavitelj opreme izvede ožičenje signalov med dozirnimi črpalkami (P 9025.21, P 2025.20) in napravo.
(Poz: VV 9025.01)
(Ustreza: Nalco 3D Trasar CW8206)', 1, N'kpl', NULL,
NULL, NULL, NULL, 18);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (136, 3, N'C1.8', NULL, 
N'Postaja za doziranje inhibitorja v stolpno hladilno vodo, sestavljena iz membranske dozirne črpalke, vgrajene na namensko dozirno posodo. Sestoječa iz:
- 60l rezervoar, nevtralne barve, 
- Sesalna garnitura z nivojskim stikalom in nepovratnim ventilom
- Membranska dozirna črpalka,
- Dozirni (tlačni) nepovratni ventil 
- Vključno s povezovalnimi gibkimi cevmi (cca 20 m) ustreznih dimenzij.
Tehnične karakteristike črpalke:
- Pretok do 7,5 l/h, max protitlak 4 bar(g)
- Krmiljenje črpalke: eksterno pulzno + ročno + analogno 4-20 mA
- Rele za alarm (delovanje črpalke, spodnji alarmni nivo)
Ustrezna za povezavo in krmiljenje preko naprave za avtomatski nadzor kvalitete stolpne vode (poz. VV 9025.01)
(Poz: P 9025.21)
(Ustreza: Grundfos DDA 7,5 + dodatki)', 1, N'kpl', NULL,
NULL, NULL, NULL, 19);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (137, 3, N'C1.9', NULL, 
N'Postaja za doziranje biocida v stolpno hladilno vodo, sestavljena iz membranske dozirne črpalke, vgrajene na namensko dozirno posodo. Sestoječa iz:
- 60l rezervoar, nevtralne barve, 
- Sesalna garnitura z nivojskim stikalom in nepovratnim ventilom
- Membranska dozirna črpalka,
- Dozirni (tlačni) nepovratni ventil 
- Vključno s povezovalnimi gibkimi cevmi (cca 20 m) ustreznih dimenzij.
Tehnične karakteristike črpalke:
- Pretok do 7,5 l/h, max protitlak 4 bar(g)
- Krmiljenje črpalke: eksterno pulzno + ročno + analogno 4-20 mA
- Rele za alarm (delovanje črpalke, spodnji alarmni nivo)
Ustrezna za povezavo in krmiljenje preko naprave za avtomatski nadzor kvalitete stolpne vode (poz. VV 9025.01)
(Poz: P 9025.20)
(Ustreza: Grundfos DDA 7,5 + dodatki)', 1, N'kpl', NULL,
NULL, NULL, NULL, 20);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (138, 3, N'C1.10', NULL, 
N'Lovilna posoda - paleta, za preprečevanje razlitij kemikalij. Volumen: 80L, dimenzije cca 132 x 66 x 14 cm. Statična obremenitev do 400 kg.
(Ustreza: Npr. SPC SC-SD2 lovilna paleta ali ekvivalent)', 1, N'kpl', NULL,
NULL, NULL, NULL, 21);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (139, 3, N'C1.11', NULL, 
N'Izdelava, dobava in montaža zbiralnika/razdelilnika za stolpno vodo. Obratovalna emperatura medija 5 do 40°C. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz nerjavnih cevi ter cevne kape. Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 22);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (140, 3, N'C1.11', NULL, 
N'Tehnične karakteristike:
- DN400 - Ø406,4mm, skupna dolžina cca 8000 mm
- 1x cevna kapa DN400
- 1x 3D koleno DN400
- Prirobnični priključki, EN1092-1, tip 11, PN16:
    1xDN400 (Ø406,4),
    6x DN200 (Ø219,1mm),
    6x DN50 (Ø60,3mm),
- Navojni priključki:
   5x 1/2" ZN
   4x 1/2" NN
- 3x podporna nogica (sedlo)
- Obratovalni tlak:  2 bar(g);
- Maksimalni tlak: 4 bar(g);
- Preizkusni tlak: 6 bar(g) 
- Material: nerjavno jeklo, 1.4301
(Poz: T 9020.01)
(Ustreza: Izdelan po merski skici tega načrta)', 1, N'kpl', NULL,
NULL, NULL, NULL, 23);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (141, 3, N'C1.12', NULL, 
N'Izdelava, dobava in montaža zbiralnika/razdelilnika za stolpno vodo. Obratovalna emperatura medija 5 do 40°C. Transport in postavljanje na mesto vgradnje (montaža v 2N, kota 13,2m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz nerjavnih cevi ter cevnih kap. Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 24);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (142, 3, N'C1.12', NULL, 
N'Tehnične karakteristike:
- DN400 - Ø406,4mm, skupna dolžina cca 3700 mm
- Prirobnični priključki, EN1092-1, tip 11, PN16:
    6x DN200 (Ø219,1mm),
    4x DN250 (Ø273mm),
- Obratovalni tlak:  2 bar(g);
- Maksimalni tlak: 4 bar(g);
- Preizkusni tlak: 6 bar(g) 
- Material: nerjavno jeklo, 1.4301
(Poz:T 9023.01)
(Ustreza: Izdelan po merski skici tega načrta)', 1, N'kpl', NULL,
NULL, NULL, NULL, 25);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (143, 3, N'C2.1', NULL, 
N'Vodomer,  primeren za stolpno  (hladilno) vodo, pulzni izhod. 
Prirobnični procesni priključek, temperatura medija od 5 do 40 °C, tlak do 8 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 26);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (144, 3, N'C2.1', NULL, 
N'Tehnične karakteristike:
- Merilno območje: 0,4 do 40  m3/h, nazivni pretok 15 m3/h
- Priključek: prirobnični, EN 1092-1, DN50, PN16
- Izhod:pulz
(Poz: FQI 9020.730, FQI 9040.730, FQI 9040.731)
(Ustreza: ITRON Woltex M + Cyble sensor V2)', 3, N'kos', NULL,
NULL, NULL, NULL, 27);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (145, 3, N'C2.1', NULL, 
N'Tehnične karakteristike:
- Merilno območje: 1 do 100  m3/h, nazivni pretok 40 m3/h
- Priključek: prirobnični, EN 1092-1, DN80, PN16
- Izhod: pulz
(Poz: FQI 9042.730, FQI 9042.731)
(Ustreza: ITRON Woltex M + Cyble sensor V2)', 2, N'kos', NULL,
NULL, NULL, NULL, 28);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (146, 3, N'C2.2', NULL, 
N'Merilnik tlaka, primeren za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Vključno z nerjavno priključno cevko in z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Piezouporovni merilni princip
- Priključek: navojni, G 1/2"
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA', NULL, N'', NULL,
NULL, NULL, NULL, 29);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (147, 3, N'C2.2', NULL, 
N'Merilno območje: 0 do 10 bar(g)
(Poz: PIC 9020.710, PI 9021.710, PI 9021.711, PI 9022.710, PI 9022.711, PIC 9042.)
(Ustreza: E+H PMP21)', 6, N'kpl', NULL,
NULL, NULL, NULL, 30);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (148, 3, N'C2.2', NULL, 
N'Merilno območje: 0 do 1 bar(g) - hidrostatična meritev nivoja (do 6m)
(Poz: LIC 9020.720)
(Ustreza: E+H PMP21)', 1, N'kpl', NULL,
NULL, NULL, NULL, 31);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (149, 3, N'C2.3', NULL, 
N'Merilnik temperature, uporovni, 1x Pt100, s priključno glavo na zaščitnem vratu, primeren za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Z integriranim pretvornikom. Vključno z ustrezno nerjavno zaščitno tulko. Dolžina ustrezna za montažo v cev DN100...DN400. Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Merilno območje: -50 do +50 °C
- 1 x Pt100, 3 žilna vezava
- Priključek: navojni, G 1/2"
- Potopna dolžina 100 mm, dolžina zaščitnega vratu 80 mm
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
(Poz: TIC 9020.700, TIC 9021.700, TIC 9021.701, TIC 9022.700, TIC 9022.701, TIC 9023.701, TIC 9023.702)
(Ustreza: E+H TM121)', 7, N'kos', NULL,
NULL, NULL, NULL, 32);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (150, 3, N'C2.4', NULL, 
N'Nivojsko mejno stikalo - vibracijske vilice, primerno za stolpno vodo. Temperatura medija do 40°C, tlak do 2 bar (g). Vključno s pomožnim, montažnim, tesnilnim in elektro materialom in s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: zunanji navoj G3/4"
- Material: Nerjavno jeklo, 1.4301 ali boljši
- Napajanje: 24 V DC
(Poz: LSLA 9020.721, LSHA 9020.722, LSLLA 9020.723)
(Ustreza: E+H Liquiphant FTL 41)', 3, N'kos', NULL,
NULL, NULL, NULL, 33);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (151, 3, N'C2.5', NULL, 
N'Merilnik prevodnosti, primeren za tehnološko vodo in deževnico. Temperatura medija 5 do 40°C, tlak do 6 bar (g). Vključno s pomožnim, montažnim, tesnilnim in elektro materialom in s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: zunanji navoj G1"
- Merilno območje: 10 - 20000 µS/cm
- Napajanje: 24 V DC
(Poz: QIC 9042.745)
(Ustreza: E+H Liquiphant CLS21E + LiquilineCM442)', 1, N'kos', NULL,
NULL, NULL, NULL, 34);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (152, 3, N'C2.6', NULL, 
N'Lokalni manometer za prikaz tlaka vode. Temperatura medija 5 do 50°C. Vključno z nerjavno priključno cevko z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm
- Polnilo: silikonsko olje', NULL, N'', NULL,
NULL, NULL, NULL, 35);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (153, 3, N'C2.6', NULL, 
N'Merilno območje 0 - 4 bar(g)
Radialni priključek
(Poz: PI 9020.910, PI 9020.911, PI 9020.912, PI 9020.913, PI 9020.914, PI 9022.911, PI 9022.912, PI 9022.914, PI 9022.915, PI 9041.910, PI 9041.911, PI 9042.910, PI 9021.911A, PI 9021.911B, PI 9021.912A, PI 9021.912B, PI 9021.914A, PI 9021.914B, PI 9021.915A, PI 9021.915B)
(Ustreza: INOL IM 821 DN100)', 20, N'kpl', NULL,
NULL, NULL, NULL, 36);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (154, 3, N'C2.6', NULL, 
N'Merilno območje 0 - 6 bar(g)
Radialni priključek
(Poz: PI 9021.910, PI 9021.913, PI 9022.910, PI 9022.911)
(Ustreza: INOL IM 821 DN100)', 4, N'kpl', NULL,
NULL, NULL, NULL, 37);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (155, 3, N'C2.7', NULL, 
N'Lokalni direktni termometer za prikaz temperature vode. Industrijski termometer, ki deluje na principu spremembe volumna polnila v tipalu, ki se preko membranske kapsule in mehanizma prenaša na kazalec. Tlak medija do 6 bar(g). Vključno z ustrezno nerjavno zašitno tulko.  Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm', NULL, N'', NULL,
NULL, NULL, NULL, 38);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (156, 3, N'C2.7', NULL, 
N'Merilno območje 0 / +60°C
Aksialni priključek
(Poz: TI 9020.900, TI 9022.900, TI 9022.901, TI 9022.902, TI 9022.903, TI 9021.900A, TI 9021.900B, TI 9021.901A, TI 9021.901B, TI 9021.902A, TI 9021.902B, TI 9021.903A, TI 9021.903B)
(Ustreza: INOL TI291 DN100 + tulka)', 13, N'kpl', NULL,
NULL, NULL, NULL, 39);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (157, 3, N'C3.1', NULL, 
N'Zaporna loputa, medprirobnična LUG izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Loputa mora zagotavljati razred tesnenja A po EN 12266-1. Vključno s spojnim, vijačnim, tesnilnim ter elektro materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: Elektromotorni pogon z ON/OFF regulacijo in ustreznim navorom
- Material ohišja: nodularna litina
- Tesnila: EPDM
- Napajanje: 24 VDC
- 2x stikalo končnih leg
- Ohišje zaščita IP67', NULL, N'', NULL,
NULL, NULL, NULL, 40);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (158, 3, N'C3.1', NULL, 
N'DN 250
(Poz:  MBV 9023.001, MBV 9023.003, MBV 9023.005, MBV 9023.007)
(Ustreza: Belimo  D6250WL + PRCA-S2-T-250 ali ekvivalent ARI Armaturen ali IMP Armature)', 4, N'kos', NULL,
NULL, NULL, NULL, 41);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (159, 3, N'C3.2', NULL, 
N'Zaporna loputa, medprirobnična wafer izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Loputa mora zagotavljati razred tesnenja A po EN 12266-1. Vključno s spojnim, vijačnim, tesnilnim ter elektro materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: Elektromotorni pogon z zvezno regulacijo in ustreznim navorom
- Material: nodularna litina
- Tesnila: EPDM
- Napajanje: 24 VDC
- Krmilni signal 4-20 mA
- 2x stikalo končnih leg
- Ohišje zaščita IP67', NULL, N'', NULL,
NULL, NULL, NULL, 42);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (160, 3, N'C3.2', NULL, 
N'DN 200
(Poz: MBV 9023.009) 
(Ustreza: Belimo  D6250W + PRCA-BAC-S2-T-250 ali ekvivalent ARI Armaturen ali IMP Armature)', 1, N'kos', NULL,
NULL, NULL, NULL, 43);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (161, 3, N'C3.3', NULL, 
N'Tripotni krogelni ventil z elektromotornim pogonom, L konfiguracija, prirobnična izvedba.primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim, tesnilnim in elektro materialom ter funkcionalno montažo.', NULL, N'', NULL,
NULL, NULL, NULL, 44);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (162, 3, N'C3.3', NULL, 
N'Tehnične karakteristike:
- Priključek: prirobnični, EN1092, PN16
- Material: nerjavno jeklo
- Napajanje: 24 VDC
- 2 končno stikalo
- možnost ročnega pogona', NULL, N'', NULL,
NULL, NULL, NULL, 45);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (163, 3, N'C3.3', NULL, 
N'DN50
(Poz: MV 9041.001, MV 9041.011)
(Ustreza: END Armaturen MD31 + pogon NE092100 ali enakovredno', 2, N'kos', NULL,
NULL, NULL, NULL, 46);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (164, 3, N'C3.4', NULL, 
N'Dvodelni krogelni ventil, industrijska izvedba, primeren za stolpno vodo. Temperatura medija 0 do 40 °C, tlak do 6 bar(g). Elektromotorni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: dvodelni krogelni ventil,
- Priključek: prirobnični, po EN 1092
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
- Napajanje: 24 VDC
- 2 končno stikalo
- optični indikator položaja
- možnost ročnega pogona', NULL, N'', NULL,
NULL, NULL, NULL, 47);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (165, 3, N'C3.4', NULL, 
N'DN80
(Poz: MV 9042.003, MV 9042.014, MV 9042.022, MV 9042.023)
(Ustreza: END Armaturen MP31 + pogon NE092100)', 4, N'kos', NULL,
NULL, NULL, NULL, 48);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (166, 3, N'C3.5', NULL, 
N'Prehodni zaporni ventil z elektromagnetnim pogonom, 2/2 membranski servo, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g).  Vključno s pomožnim, montažnim, tesnilnim in elektro materialom ter funkcionalno montažo.', NULL, N'', NULL,
NULL, NULL, NULL, 49);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (167, 3, N'C3.5', NULL, 
N'Tehnične karakteristike:
- Priključek: navojni
- Material: medenina + EPDM
- Min. tlak: 0,5 bar(g)
- Kvs = 37 m3/h
- Zaščita IP65
- Napajanje: 24V DC
- NC (v primeru izpada el. enegije se ventil zapre)', NULL, N'', NULL,
NULL, NULL, NULL, 50);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (168, 3, N'C3.5', NULL, 
N'DN50
(Poz: EV 9020.051)
(Ustreza: Jakša M286 G2 ali enakovredno', 1, N'kos', NULL,
NULL, NULL, NULL, 51);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (169, 3, N'C3.6', NULL, 
N'Poševnosedežni ventil s pnevmatskim pogonom, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g).  Vključno s pomožnim, montažnim, tesnilnim in elektro materialom ter funkcionalno montažo.', NULL, N'', NULL,
NULL, NULL, NULL, 52);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (170, 3, N'C3.6', NULL, 
N'Tehnične karakteristike:
- Priključek: navojni
- Material: nerjavni,+ PTFE sedež
- Krmilni medij: zrak 6 bar(g)
- Zapiranje proti toku
- NC (v primeru izpada kom. zraka se ventil zapre)', NULL, N'', NULL,
NULL, NULL, NULL, 53);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (171, 3, N'C3.6', NULL, 
N'DN50
(Poz: PV 9040.004, PV 9040.008)
(Ustreza:  End Armaturen DGD2D3 ali enakovredno', 2, N'kos', NULL,
NULL, NULL, NULL, 54);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (172, 3, N'C3.7', NULL, 
N'Trodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: trodelni krogelni ventil
- Priključek: navojni
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 55);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (173, 3, N'C3.7', NULL, 
N'DN15
(Poz: V 9020.003, V 9020.008, V 9020.013, V 9020.018, V 9020.060, V 9021.006, V 9021.026, V 9022.006, V 9022.026, V 9023.002, V 9023.004, V 9025.001, V 9025.002, V 9025.011, V 9041.006)
(Ustreza: END Armaturen ZE31 ali enakovredno)', 15, N'kos', NULL,
NULL, NULL, NULL, 56);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (174, 3, N'C3.7', NULL, 
N'DN15 s ključavnico
(Poz: V 9021.014A, V 9021.014B, V 9021.034A, V 9021.034B, V 9022.014, V 9022.034)
(Ustreza: END Armaturen ZE31 + ključavnica ali enakovredno)', 6, N'kos', NULL,
NULL, NULL, NULL, 57);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (175, 3, N'C3.7', NULL, 
N'DN20
(Poz: V 9021.008, V 9021.028)
(Ustreza: END Armaturen ZE31 ali enakovredno)', 2, N'kos', NULL,
NULL, NULL, NULL, 58);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (176, 3, N'C3.7', NULL, 
N'DN25
(Poz: V 9021.003, V 9021.023, V 9022.003, V 9022.023)
(Ustreza: END Armaturen ZE ali enakovredno)', 4, N'kos', NULL,
NULL, NULL, NULL, 59);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (177, 3, N'C3.7', NULL, 
N'DN32
(Poz: V 9021.011A, V 9021.011B, V 9021.016A, V 9021.016A, V 9021.016B, V 9021.031A , V 9021.031B, V 9021.036B, V 9022.011, V 9022.016, V 9022.031, V 9022.036)
(Ustreza: END Armaturen ZE31+ključavnica ali enakovredno)', 12, N'kos', NULL,
NULL, NULL, NULL, 60);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (178, 3, N'C3.8', NULL, 
N'Dvodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: dvodelni krogelni ventil
- Priključek: prirobnični, po EN 1092
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 61);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (179, 3, N'C3.8', NULL, 
N'DN50
(Poz: V 9020.040, V 9020.041, V 9020.042, V 9020.043, V 9020.050 )
(Ustreza: END Armaturen MP31 ali enakovredno)', 5, N'kos', NULL,
NULL, NULL, NULL, 62);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (180, 3, N'C3.8', NULL, 
N'DN80
(Poz: V 9040.001, V 9042.001, V 9042.004, V 9042.011, V 9042.015, V 9042.021)
(Ustreza: END Armaturen MP ali enakovredno)', 6, N'kos', NULL,
NULL, NULL, NULL, 63);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (181, 3, N'C3.9', NULL, 
N'Trodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 0 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: trodelni krogelni ventil
- Priključek: varilni
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 64);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (182, 3, N'C3.9', NULL, 
N'DN25
(Poz: V 9042.024)
(Ustreza: END Armaturen ZE31)', 1, N'kos', NULL,
NULL, NULL, NULL, 65);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (183, 3, N'C3.9', NULL, 
N'DN50
(Poz: V 9020.053, V 9040.002, V 9040.006, V 9040.010, V 9040.011, V 9041.004, V 9041.008, V 9041.010, V 9042.020)
(Ustreza: END Armaturen ZE31)', 9, N'kos', NULL,
NULL, NULL, NULL, 66);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (184, 3, N'C3.10', NULL, 
N'Zaporna loputa, medprirobnična WAFER izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s spojnim, vijačnim in tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: ročni pogon z ročico do vključno DN100,
               ročni polžni pogon nad DN100
- Material ohišja: nodularna litina
- Tesnila: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 67);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (185, 3, N'C3.10', NULL, 
N'DN80
(Poz: BV 9021.010A, BV 9021.010B, BV 9021.017A, BV 9021.017B, BV 9021.030A, BV 9021.030B, BV 9021.037A, BV 9021.037B) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)', 8, N'kos', NULL,
NULL, NULL, NULL, 68);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (186, 3, N'C3.10', NULL, 
N'DN125
(Poz: BV 9021.002, BV 9021.022) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)', 2, N'kos', NULL,
NULL, NULL, NULL, 69);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (187, 3, N'C3.10', NULL, 
N'DN200
(Poz: BV 9020.001, BV 9020.006, BV 9020.011, BV 9020.016, BV 9022.002, BV 9022.010, BV 9022.017, BV 9022.022, BV 9022.030, BV 9022.037) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)', 10, N'kos', NULL,
NULL, NULL, NULL, 70);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (188, 3, N'C3.11', NULL, 
N'Zaporna loputa, medprirobnična LUG izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s spojnim, vijačnim in tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: ročni pogon z ročico do vključno DN100,
               ročni polžni pogon nad DN100
- Material ohišja: nodularna litina
- Tesnila: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 71);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (189, 3, N'C3.11', NULL, 
N'DN200
(Poz: BV 9020.021, BV 9020.026, BV 9021.058, BV 9022.058) 
(Ustreza: IMP Armature tip Art. 126- ali enakovredno ARI Armaturen tip Gesa)', 4, N'kos', NULL,
NULL, NULL, NULL, 72);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (190, 3, N'C3.12', NULL, 
N'Nepovratna loputa, za vertikalno vgradnjo brez vzmeti, primerna za vodo. Temperatura medija 0 do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: medprirobnični, EN1092-1, PN16 
- Material: ohišje 1.0460, disk 1.4581
- Tesnilo: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 73);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (191, 3, N'C3.12', NULL, 
N'DN 125
(Poz: CV 9021.001, CV 9021.021)
(Ustreza: Gestra CB26 ali enakovredno)', 2, N'kos', NULL,
NULL, NULL, NULL, 74);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (192, 3, N'C3.12', NULL, 
N'DN 125
(Poz: CV 9022.001, CV 9022.021)
(Ustreza: Gestra CB26 ali enakovredno)', 2, N'kos', NULL,
NULL, NULL, NULL, 75);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (193, 3, N'C3.13', NULL, 
N'Nepovratni ventil - kompaktna disk izvedba, z vzmetjo, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: medprirobnični, EN1092-1, PN16 
- Material: Nerjeveče jeklo - 1.4301 ali boljše
- Mehko tesnenje, tesnilo EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 76);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (194, 3, N'C3.13', NULL, 
N'DN 50
(Poz: CV 9040.003, CV 9040.007, CV 9040.011)
(Ustreza: Gestra RK86 ali End Armaturen ZR ali ekvivalent)', 3, N'kos', NULL,
NULL, NULL, NULL, 77);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (195, 3, N'C3.13', NULL, 
N'DN 80
(Poz: CV 9040.001, CV 9042.002, CV 9042.012)
(Ustreza: Gestra RK86 ali End Armaturen ZR ali ekvivalent)', 3, N'kos', NULL,
NULL, NULL, NULL, 78);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (196, 3, N'C3.14', NULL, 
N'Nepovratni ventil - kompaktna disk izvedba, z vzmetjo, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: navojni
- Material: Nerjeveče jeklo - 1.4301 ali boljše
- Mehko tesnenje, tesnilo PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 79);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (197, 3, N'C3.14', NULL, 
N'DN 15
(Poz: CV 9021.007, CV 9021.027, CV 9022.007, CV 9022.027)
(Ustreza: End Armaturen EB31 ali ekvivalent)', 4, N'kos', NULL,
NULL, NULL, NULL, 80);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (198, 3, N'C3.15', NULL, 
N'Dušilni ventil za hidravlično uravnoteženje, primeren za stolpno vodo. Poševnosedežna izvedba, z regulacijskim stožcem. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: navojni
- Mehko tesnenje, tesnilo PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 81);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (199, 3, N'C3.15', NULL, 
N'DN 15
(Poz: RV 9025.010)
(Ustreza: AE311062/L-RK  ali ekvivalent)', 1, N'kos', NULL,
NULL, NULL, NULL, 82);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (200, 3, N'C3.15', NULL, 
N'DN 50
(Poz: RV 9020.052, RV 9040.005, RV 9040.009)
(Ustreza: AE311067/L-RK  ali ekvivalent)', 3, N'kos', NULL,
NULL, NULL, NULL, 83);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (201, 3, N'C3.16', NULL, 
N'Lovilnik nesnage, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g). Skupaj z izpustnim čepom in izpustnim ventilom 1/2". Vključno s spojnim, vijačnim, tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični, EN1092-1, PN16 
- Material: siva litina (EN-GJL-250)
- Sito: standardno, nerjavno (1.4301)', NULL, N'', NULL,
NULL, NULL, NULL, 84);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (202, 3, N'C3.16', NULL, 
N'DN 50
(Poz: SF 9041.005)
(Ustreza: IMP Armature Art. 020)', 1, N'kos', NULL,
NULL, NULL, NULL, 85);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (203, 3, N'C3.16', NULL, 
N'DN 200
(Poz: SF 9020.002, SF 9020.007, SF 9020.012, SF 9020.017)
(Ustreza: IMP Armature Art. 020)', 4, N'kos', NULL,
NULL, NULL, NULL, 86);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (204, 3, N'C3.17', NULL, 
N'Varnostni ventil, razbremenilna funkcija, ustrezen za stolpno vodo. Temperatura medija  do 40 °C. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. Priložen certifikat testa.', NULL, N'', NULL,
NULL, NULL, NULL, 87);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (205, 3, N'C3.17', NULL, 
N'Tehnične karakteristike:
- Priključek: navojni
- Material: nerjavno jeklo
- Tlak odpiranja: 8 bar(g)
- Zaprta izvedba mehanizma
- Vzmetni, prednastavljen.', NULL, N'', NULL,
NULL, NULL, NULL, 88);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (206, 3, N'C3.17', NULL, 
N'DN 15 / DN 15
(Poz: SV 9021.015A, SV 9021.015B, SV 9021.035A, SV 9021.035B, SV 9022.015, SV 9022.035)
(Ustreza: End Armaturen SV320023/L )', 6, N'kos', NULL,
NULL, NULL, NULL, 89);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (207, 3, N'C3.18', NULL, 
N'Avtomatski odzračevalni lonček s plovcem, industrijska izvedba, primeren za hladilno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek vstop: notranji navoj, G 3/4" 
- Priključek izstop: zunanji navoj, G 1/2" 
- Material: nerjaveče jeklo
(Poz: AO 9021.009, AO 9021.029)
(Ustreza: Mankenberg EB 1.32 ali enakovredno)', 2, N'kos', NULL,
NULL, NULL, NULL, 90);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (208, 3, N'C3.19', NULL, 
N'Manometrski iglični ventil, navojni priključek: G 1/2". Material: nerjavni (1.4301 ali boljše).
Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.', NULL, N'', NULL,
NULL, NULL, NULL, 91);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (209, 3, N'C3.19', NULL, 
N'Z odprtino za razbremenitev (DIN 16270).  
(Poz: V 9020.004, V 9020.009, V 9020.014, V 9020.019, V 9020.045, V 9021.005, V 9021.012A, V 9021.012B, V 9021.013A, V 9021.013B, V 9021.025, V 9021.032A, V 9021.032B, V 9021.033A, V 9021.033B, V 9022.005, V 9022.012, V 9022.013, V 9022.025, V 9022.032, V 9022.033, V 9041.007, V 9041.009, V 9042.013, V 9042.016)
(Ustreza: INOL manom. ventil (inox) DIN16270)', 25, N'kos', NULL,
NULL, NULL, NULL, 92);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (210, 3, N'C3.19', NULL, 
N'Z odprtino za razbremenitev in testnim priključkom (DIN 16271)
(Poz: V 9020.044, V 9021.004, V 9021.024, V 9022.004, V 9022.024)
(Ustreza: INOL manom. ventil (inox) DIN16271)', 5, N'kos', NULL,
NULL, NULL, NULL, 93);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (211, 3, N'C3.20', NULL, 
N'Prirobnični gumi kompenzator, primeren za hladilno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični, po EN 1092
- Material prirobnic: pocinkano ali ponikljano jeklo
- Material meha: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 94);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (212, 3, N'C3.20', NULL, 
N'DN 100
(Poz: K 9020.005, K 9020.010)
(Ustreza: Giaflex EGK ali End Armaturen KP54 ali enakovredno)', 2, N'kos', NULL,
NULL, NULL, NULL, 95);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (213, 3, N'C3.20', NULL, 
N'DN 150
(Poz: K 9020.015, K 9020.020)
(Ustreza: Giaflex EGK ali End Armaturen KP54 ali enakovredno)', 2, N'kos', NULL,
NULL, NULL, NULL, 96);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (214, 3, N'C4.1', NULL, 
N'Cev, varjena, nerjavna - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10217-7,  certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 97);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (215, 3, N'C4.1', NULL, 
N'DN 15 (Ø21,3 x 1,6 mm)', 50, N'm', NULL,
NULL, NULL, NULL, 98);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (216, 3, N'C4.1', NULL, 
N'DN 25 (Ø33,7 x 1,6 mm)', 20, N'm', NULL,
NULL, NULL, NULL, 99);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (217, 3, N'C4.1', NULL, 
N'DN 32 (Ø42,4 x 1,6 mm)', 2, N'm', NULL,
NULL, NULL, NULL, 100);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (218, 3, N'C4.1', NULL, 
N'DN 50 (Ø60,3 x 1,6 mm)', 180, N'm', NULL,
NULL, NULL, NULL, 101);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (219, 3, N'C4.1', NULL, 
N'DN 80 (Ø88,9 x 2 mm)', 60, N'm', NULL,
NULL, NULL, NULL, 102);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (220, 3, N'C4.1', NULL, 
N'DN 100 (Ø114,3 x 2 mm)', 75, N'm', NULL,
NULL, NULL, NULL, 103);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (221, 3, N'C4.1', NULL, 
N'DN 125 (Ø139,7 x 2 mm)', 70, N'm', NULL,
NULL, NULL, NULL, 104);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (222, 3, N'C4.1', NULL, 
N'DN 200 (Ø219,1 x 2,6 mm)', 65, N'm', NULL,
NULL, NULL, NULL, 105);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (223, 3, N'C4.1', NULL, 
N'DN 250 (Ø273,0 x 2,6 mm)', 35, N'm', NULL,
NULL, NULL, NULL, 106);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (224, 3, N'C4.1', NULL, 
N'DN 350 (Ø355,6 x 3 mm)', 10, N'm', NULL,
NULL, NULL, NULL, 107);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (225, 3, N'C4.1', NULL, 
N'DN 400 (Ø406,4 x 3 mm)', 17, N'm', NULL,
NULL, NULL, NULL, 108);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (226, 3, N'C4.2', NULL, 
N'Koleno, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 109);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (227, 3, N'C4.2', NULL, 
N'DN 15 (Ø21,3 x 1,6 mm)', 40, N'kos', NULL,
NULL, NULL, NULL, 110);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (228, 3, N'C4.2', NULL, 
N'DN 25 (Ø33,7 x 1,6 mm)', 10, N'kos', NULL,
NULL, NULL, NULL, 111);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (229, 3, N'C4.2', NULL, 
N'DN 50 (Ø60,3 x 1,6 mm)', 100, N'kos', NULL,
NULL, NULL, NULL, 112);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (230, 3, N'C4.2', NULL, 
N'DN 80 (Ø88,9 x 2 mm)', 52, N'kos', NULL,
NULL, NULL, NULL, 113);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (231, 3, N'C4.2', NULL, 
N'DN 100 (Ø114,3 x 2 mm)', 20, N'kos', NULL,
NULL, NULL, NULL, 114);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (232, 3, N'C4.2', NULL, 
N'DN 125 (Ø139,7 x 2 mm)', 18, N'kos', NULL,
NULL, NULL, NULL, 115);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (233, 3, N'C4.2', NULL, 
N'DN 200 (Ø219,1 x 2,6 mm)', 32, N'kos', NULL,
NULL, NULL, NULL, 116);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (234, 3, N'C4.2', NULL, 
N'DN 250 (Ø273,0 x 2,6 mm)', 15, N'kos', NULL,
NULL, NULL, NULL, 117);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (235, 3, N'C4.3', NULL, 
N'Koleno, tip 2D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 118);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (236, 3, N'C4.3', NULL, 
N'DN 350 (Ø355,6 x 3 mm)', 6, N'kos', NULL,
NULL, NULL, NULL, 119);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (237, 3, N'C4.3', NULL, 
N'DN 400 (Ø406,4 x 3 mm)', 1, N'kos', NULL,
NULL, NULL, NULL, 120);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (238, 3, N'C4.4', NULL, 
N'Koleno, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 121);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (239, 3, N'C4.4', NULL, 
N'DN 100 (Ø114,3 x 2 mm)', 2, N'kos', NULL,
NULL, NULL, NULL, 122);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (240, 3, N'C4.4', NULL, 
N'DN 200 (Ø219,1 x 2,6 mm)', 3, N'kos', NULL,
NULL, NULL, NULL, 123);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (241, 3, N'C4.4', NULL, 
N'DN 250 (Ø273,0 x 2,6 mm)', 13, N'kos', NULL,
NULL, NULL, NULL, 124);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (242, 3, N'C4.4', NULL, 
N'DN 400 (Ø406,4 x 3 mm)', 1, N'kos', NULL,
NULL, NULL, NULL, 125);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (243, 3, N'C4.5', NULL, 
N'T-kos, nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 126);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (244, 3, N'C4.5', NULL, 
N'DN 15 (Ø21,3 x 1,6 mm)', 4, N'kos', NULL,
NULL, NULL, NULL, 127);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (245, 3, N'C4.5', NULL, 
N'DN 50 (Ø60,3 x 1,6 mm)', 3, N'kos', NULL,
NULL, NULL, NULL, 128);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (246, 3, N'C4.5', NULL, 
N'DN 80 (Ø88,9 x 2 mm)', 4, N'kos', NULL,
NULL, NULL, NULL, 129);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (247, 3, N'C4.5', NULL, 
N'DN 100 (Ø114,3 x 2 mm)', 1, N'kos', NULL,
NULL, NULL, NULL, 130);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (248, 3, N'C4.5', NULL, 
N'DN 125 (Ø139,7 x 2 mm)', 4, N'kos', NULL,
NULL, NULL, NULL, 131);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (249, 3, N'C4.5', NULL, 
N'DN 250 (Ø273,0 x 2,6 mm)', 2, N'kos', NULL,
NULL, NULL, NULL, 132);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (250, 3, N'C4.5', NULL, 
N'DN 400 (Ø406,4 x 3 mm)', 2, N'kos', NULL,
NULL, NULL, NULL, 133);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (251, 3, N'C4.6', NULL, 
N'Reducirni T-kos, nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 134);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (252, 3, N'C4.6', NULL, 
N'DN 80/50,', 2, N'kos', NULL,
NULL, NULL, NULL, 135);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (253, 3, N'C4.6', NULL, 
N'DN 100/50,', 8, N'kos', NULL,
NULL, NULL, NULL, 136);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (254, 3, N'C4.6', NULL, 
N'DN 200/125', 1, N'kos', NULL,
NULL, NULL, NULL, 137);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (255, 3, N'C4.6', NULL, 
N'DN 250/150', 4, N'kos', NULL,
NULL, NULL, NULL, 138);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (256, 3, N'C4.7', NULL, 
N'Reducirni kos. nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 139);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (257, 3, N'C4.7', NULL, 
N'DN 20/15', 2, N'kos', NULL,
NULL, NULL, NULL, 140);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (258, 3, N'C4.7', NULL, 
N'DN 50/40', 2, N'kos', NULL,
NULL, NULL, NULL, 141);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (259, 3, N'C4.7', NULL, 
N'DN 80/50', 2, N'kos', NULL,
NULL, NULL, NULL, 142);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (260, 3, N'C4.7', NULL, 
N'DN 125/80', 10, N'kos', NULL,
NULL, NULL, NULL, 143);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (261, 3, N'C4.7', NULL, 
N'DN 200/100', 2, N'kos', NULL,
NULL, NULL, NULL, 144);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (262, 3, N'C4.7', NULL, 
N'DN 200/125', 3, N'kos', NULL,
NULL, NULL, NULL, 145);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (263, 3, N'C4.7', NULL, 
N'DN 200/150', 4, N'kos', NULL,
NULL, NULL, NULL, 146);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (264, 3, N'C4.7', NULL, 
N'DN 250/200', 4, N'kos', NULL,
NULL, NULL, NULL, 147);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (265, 3, N'C4.8', NULL, 
N'Varilna prirobnica z grlom.
- dimenzije po EN 1092-1, tip 11, B1;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim, vijačnim in varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot fiting)', NULL, N'', NULL,
NULL, NULL, NULL, 148);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (266, 3, N'C4.8', NULL, 
N'DN 40, PN16', 2, N'kos', NULL,
NULL, NULL, NULL, 149);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (267, 3, N'C4.8', NULL, 
N'DN 50, PN16', 30, N'kos', NULL,
NULL, NULL, NULL, 150);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (268, 3, N'C4.8', NULL, 
N'DN 80, PN16', 20, N'kos', NULL,
NULL, NULL, NULL, 151);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (269, 3, N'C4.8', NULL, 
N'DN 100, PN16', 5, N'kos', NULL,
NULL, NULL, NULL, 152);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (270, 3, N'C4.8', NULL, 
N'DN 125, PN16', 10, N'kos', NULL,
NULL, NULL, NULL, 153);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (271, 3, N'C4.8', NULL, 
N'DN 150, PN16', 4, N'kos', NULL,
NULL, NULL, NULL, 154);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (272, 3, N'C4.8', NULL, 
N'DN 200, PN16', 35, N'kos', NULL,
NULL, NULL, NULL, 155);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (273, 3, N'C4.8', NULL, 
N'DN 250, PN16', 3, N'kos', NULL,
NULL, NULL, NULL, 156);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (274, 3, N'C4.8', NULL, 
N'DN 350, PN16', 6, N'kos', NULL,
NULL, NULL, NULL, 157);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (275, 3, N'C4.8', NULL, 
N'DN 400, PN16', 4, N'kos', NULL,
NULL, NULL, NULL, 158);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (276, 3, N'C4.9', NULL, 
N'Slepa prirobnica
- dimenzije po EN 1092-1, tip 05;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim in  vijačnim materialom', NULL, N'', NULL,
NULL, NULL, NULL, 159);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (277, 3, N'C4.9', NULL, 
N'DN 200, PN16', 4, N'kos', NULL,
NULL, NULL, NULL, 160);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (278, 3, N'C4.9', NULL, 
N'DN 250, PN16', 5, N'kos', NULL,
NULL, NULL, NULL, 161);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (279, 3, N'C4.9', NULL, 
N'DN 400, PN16', 1, N'kos', NULL,
NULL, NULL, NULL, 162);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (280, 3, N'C4.10', NULL, 
N'Gibka cev, primerna za vodo, obratovalna temperatura 5 do 30 °C, tlak do 6 bar(g). Prirobnični priključki po EN 1092-1.
Dolžino in priključke preveriti in prilagoditi glede na dobavljeno mehčalno napravo.', NULL, N'', NULL,
NULL, NULL, NULL, 163);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (281, 3, N'C4.10', NULL, 
N'DN80, dolžina cca 1500 mm', 2, N'kos', NULL,
NULL, NULL, NULL, 164);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (282, 3, N'C4.11', NULL, 
N'Victaulic spojka, vključno z varilnim adapterjem, ustreznim za povezovanje na nerjavni cevovod. Tesnilo ustrezno za obratovalne temperature 20 do 40 °C, tlak do 8 bar(g). Dimenzijo kontrolirati glede na priključke na uparjalniku dobavljenega hladilnega agregata.', NULL, N'', NULL,
NULL, NULL, NULL, 165);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (283, 3, N'C4.11', NULL, 
N'DN 80 (Ø88,9 x 2 mm)', 4, N'kos', NULL,
NULL, NULL, NULL, 166);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (284, 3, N'C4.11', NULL, 
N'DN 250 (Ø273,0 x 2,6 mm)', 8, N'kos', NULL,
NULL, NULL, NULL, 167);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (285, 3, N'C5.1', NULL, 
N'Polietilenska cev, material PE100, SDR11, primerna za tehnološko vodo in deževnico.', NULL, N'', NULL,
NULL, NULL, NULL, 168);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (286, 3, N'C5.1', NULL, 
N'Ø50mm SDR11', 20, N'm', NULL,
NULL, NULL, NULL, 169);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (287, 3, N'C5.1', NULL, 
N'Ø90mm SDR11', 20, N'm', NULL,
NULL, NULL, NULL, 170);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (288, 3, N'C5.2', NULL, 
N'Prirobnica, dimenzije po EN1092, material PP - za spajanje s polietilensko cevjo.', NULL, N'', NULL,
NULL, NULL, NULL, 171);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (289, 3, N'C5.2', NULL, 
N'Ø90mm SDR11, DN80, PN10/16', 2, N'kos', NULL,
NULL, NULL, NULL, 172);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (290, 3, N'C5.3', NULL, 
N'Izdelava odcepa na obstoječem PE cevovodu tehnološke vode (PTV11) (v kineti), z uporabo navrtalnega sedla', NULL, N'', NULL,
NULL, NULL, NULL, 173);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (291, 3, N'C5.3', NULL, 
N'odcep - Ø90mm SDR11', 1, N'kos', NULL,
NULL, NULL, NULL, 174);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (292, 3, N'C5.4', NULL, 
N'Cevna uvodnica, za prehod PE100 cevi skozi AB steno v kleti. Vključno s sanacijo hidroizolacije.
Debelina stene: 300 mm', NULL, N'', NULL,
NULL, NULL, NULL, 175);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (293, 3, N'C5.4', NULL, 
N'Ø90mm SDR11', 2, N'kos', NULL,
NULL, NULL, NULL, 176);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (294, 3, N'C6.1', NULL, 
N'DN 125', 4, N'kpl', NULL,
NULL, NULL, NULL, 177);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (295, 3, N'C6.1', NULL, 
N'DN 200', 4, N'kpl', NULL,
NULL, NULL, NULL, 178);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (296, 3, N'C6.1', NULL, 
N'DN 250', 4, N'kpl', NULL,
NULL, NULL, NULL, 179);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (297, 3, N'C6.2', NULL, 
N'DN 125', 4, N'kpl', NULL,
NULL, NULL, NULL, 180);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (298, 3, N'C6.2', NULL, 
N'DN 200', 4, N'kpl', NULL,
NULL, NULL, NULL, 181);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (299, 3, N'C6.2', NULL, 
N'DN 250', 4, N'kpl', NULL,
NULL, NULL, NULL, 182);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (300, 3, N'C6.3', NULL, 
N'DN 125', 2, N'kpl', NULL,
NULL, NULL, NULL, 183);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (301, 3, N'C6.3', NULL, 
N'DN 200', 4, N'kpl', NULL,
NULL, NULL, NULL, 184);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (302, 3, N'C6.3', NULL, 
N'DN 250', 2, N'kpl', NULL,
NULL, NULL, NULL, 185);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (303, 3, N'C6.4', NULL, 
N'DN 400', 1, N'kpl', NULL,
NULL, NULL, NULL, 186);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (304, 3, N'C6.5', NULL, 
N'DN 15', 30, N'kpl', NULL,
NULL, NULL, NULL, 187);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (305, 3, N'C6.5', NULL, 
N'DN 25', 10, N'kpl', NULL,
NULL, NULL, NULL, 188);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (306, 3, N'C6.5', NULL, 
N'DN 50', 90, N'kpl', NULL,
NULL, NULL, NULL, 189);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (307, 3, N'C6.5', NULL, 
N'DN 80', 30, N'kpl', NULL,
NULL, NULL, NULL, 190);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (308, 3, N'C6.5', NULL, 
N'DN 100', 30, N'kpl', NULL,
NULL, NULL, NULL, 191);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (309, 3, N'C6.5', NULL, 
N'DN 125', 25, N'kpl', NULL,
NULL, NULL, NULL, 192);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (310, 3, N'C6.5', NULL, 
N'DN 200', 30, N'kpl', NULL,
NULL, NULL, NULL, 193);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (311, 3, N'C6.5', NULL, 
N'DN 250', 20, N'kpl', NULL,
NULL, NULL, NULL, 194);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (312, 3, N'C6.5', NULL, 
N'DN 400', 2, N'kpl', NULL,
NULL, NULL, NULL, 195);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (313, 4, N'D1.1', NULL, 
N'Serijsko tovarniško izdelan hladilni stolp odprte, protitočne izvedbe s sesalnim prepihavanjem zraka s pomočjo dveh aksialnih ventilatorjev. Elektromotorji ventilatorjev so enostopenjski, za delovanje v omočenem ozračju, primerni za ločen frekvenčni pretvornik.   Dobava: nerazloženo na tovornjaku. Vnos na streho objekta z uporabo avtodvigala, transport in postavljanje na mesto vgradnje (kota +20 m). Niveliranje in fiksiranje  na mestu postavitve, na pripravljeno konstrukcijo, vključno s pritrdilnim materialom.  Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje v sklopu elektro popisa.', NULL, N'', NULL,
NULL, NULL, NULL, 1);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (314, 4, N'D1.1', NULL, 
N'STROJNE ZAHTEVE:
- vibracijsko stikalo
- zaščitna mreža na ventilatorjih
- ventilatorji z nižjo stropnjo hrupa
- električni grelci v prostoru elektromotorja
- remote sump (iztok na dnu, za popolno izpraznitev ob zaustavitvi)
ELEKTRO ZAHTEVE:
- elektromotor IE3
- PTC zaščita elektromotorja
- motor ustrezen za ločen frekvenčni pretvornik', NULL, N'', NULL,
NULL, NULL, NULL, 2);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (315, 4, N'D1.1', NULL, 
N'Tehnične karakteristike:
Tehnične karakteristike se navaja pri naslednjih pogojih:
  -temperatura vlažnega termometra vstopnega zraka: 16 °C    
  -temperaturni režim hlajene vode: 20/30 °C  
 - hladilna moč : 4,3 MW  
- Okvirne dimenzije (DxŠxV): 3650 x 7400 x 5050 mm 
- Okvirna teža: 8200 kg, najtežji posamezni del 3000 kg, obratovalna teža 10550 kg
(Poz.: HS 9030.05)
(Predvidena oprema: EVAPCO AT212-4N24)', 1, N'kpl', NULL,
NULL, NULL, NULL, 3);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (316, 4, N'D1.2', NULL, 
N'Enostopenjska centrifugalna črpalka, blok izvedba, črpalka in motor monitrana na skupni osnovni okvir, prirobnični priključek. Ohišje in tekač iz sive litine. Primerna za vodo, temperatura medija 20°C do 40 °C, tlak do 6 bar(g). Tesnila ustrezna glede na medij in obratovalne razmere. Primerna za ločen frekvenčni regulator vrtljajev. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Vključno z nosilno konstrukcijo črpalke in komplet montažnim, pritrdilnim in tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 4);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (317, 4, N'D1.2', NULL, 
N'Tehnične karakteristike:
Priključek: DN100/80, PN16 (po EN 1092);
H= 52 m;
Q= 240 m3/h;
Pe=  55 kW; 4p, 3x400V
(Poz.: P 9030.20, P 9030.21, P 9030.22)
(Ustreza: Grundfos NK 125-400/392', 3, N'kos', NULL,
NULL, NULL, NULL, 5);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (318, 4, N'D1.3', NULL, 
N'Naprava za avtomatski nadzor kvalitete stolpne vode in kontrolo delovanja kondicioniranja s kemičnimi dodatki in nadzor odsoljevanja stolpne vode. RS485 komunikacija (Modbus). Kompaktna verzija za stensko montažo. Vključno z ustreznimi cevnimi fitingi za priklop nerjavne cevi DN15 na PVC priključek 25 mm.
Dobavitelj opreme izvede ožičenje signalov med dozirnimi črpalkami (P 9032.21, P 2032.20) in napravo.
(Poz: VV 9032.01)
(Ustreza: Nalco 3D Trasar CW8206)', 1, N'kpl', NULL,
NULL, NULL, NULL, 6);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (319, 4, N'D1.4', NULL, 
N'Postaja za doziranje inhibitorja v stolpno hladilno vodo, sestavljena iz membranske dozirne črpalke, vgrajene na namensko dozirno posodo. Sestoječa iz:
- 60l rezervoar, nevtralne barve, 
- Sesalna garnitura z nivojskim stikalom in nepovratnim ventilom
- Membranska dozirna črpalka,
- Dozirni (tlačni) nepovratni ventil 
- Vključno s povezovalnimi gibkimi cevmi (cca 20 m) ustreznih dimenzij.
Tehnične karakteristike črpalke:
- Pretok do 7,5 l/h, max protitlak 4 bar(g)
- Krmiljenje črpalke: eksterno pulzno + ročno + analogno 4-20 mA
- Rele za alarm (delovanje črpalke, spodnji alarmni nivo)
Ustrezna za povezavo in krmiljenje preko naprave za avtomatski nadzor kvalitete stolpne vode (poz. VV 9025.01)
(Poz: P 9032.21)
(Ustreza: Grundfos DDA 7,5 + dodatki)', 1, N'kpl', NULL,
NULL, NULL, NULL, 7);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (320, 4, N'D1.5', NULL, 
N'Postaja za doziranje biocida v stolpno hladilno vodo, sestavljena iz membranske dozirne črpalke, vgrajene na namensko dozirno posodo. Sestoječa iz:
- 60l rezervoar, nevtralne barve, 
- Sesalna garnitura z nivojskim stikalom in nepovratnim ventilom
- Membranska dozirna črpalka,
- Dozirni (tlačni) nepovratni ventil 
- Vključno s povezovalnimi gibkimi cevmi (cca 20 m) ustreznih dimenzij.
Tehnične karakteristike črpalke:
- Pretok do 7,5 l/h, max protitlak 4 bar(g)
- Krmiljenje črpalke: eksterno pulzno + ročno + analogno 4-20 mA
- Rele za alarm (delovanje črpalke, spodnji alarmni nivo)
Ustrezna za povezavo in krmiljenje preko naprave za avtomatski nadzor kvalitete stolpne vode (poz. VV 9025.01)
(Poz: P 9032.20)
(Ustreza: Grundfos DDA 7,5 + dodatki)', 1, N'kpl', NULL,
NULL, NULL, NULL, 8);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (321, 4, N'D1.6', NULL, 
N'Lovilna posoda - paleta, za preprečevanje razlitij kemikalij. Volumen: 80L, dimenzije cca 132 x 66 x 14 cm. Statična obremenitev do 400 kg.
(Ustreza: Npr. SPC SC-SD2 lovilna paleta ali ekvivalent)', 1, N'kpl', NULL,
NULL, NULL, NULL, 9);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (322, 4, N'D1.7', NULL, 
N'Izdelava, dobava in montaža zbiralnika/razdelilnika za stolpno vodo. Obratovalna emperatura medija 5 do 40°C. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz nerjavnih cevi ter cevne kape. Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 10);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (323, 4, N'D1.7', NULL, 
N'Tehnične karakteristike:
- DN400 - Ø406,4mm, skupna dolžina cca 5600 mm
- 1x cevna kapa DN400
- Prirobnični priključki, EN1092-1, tip 11, PN16:
    1xDN400 (Ø406,4),
    5x DN200 (Ø219,1mm),
    4x DN50 (Ø60,3mm),
- Navojni priključki:
   3x 1/2" ZN
   2x 1/2" NN
   1x 1" ZN
- Obratovalni tlak:  0,5 bar(g);
- Maksimalni tlak: 1 bar(g);
- Preizkusni tlak: 1,5 bar(g) 
- Material: nerjavno jeklo, 1.4301
(Poz: T 9030.02)
(Ustreza: Izdelan po merski skici tega načrta)', 1, N'kpl', NULL,
NULL, NULL, NULL, 11);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (324, 4, N'D1.8', NULL, 
N'Izdelava, dobava in montaža zbiralnika/razdelilnika za stolpno vodo. Obratovalna emperatura medija 5 do 40°C. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz nerjavnih cevi ter 2x cevih kap. Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 12);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (325, 4, N'D1.8', NULL, 
N'Tehnične karakteristike:
- DN400 - Ø406,4mm, skupna dolžina cca 5400 mm
- 2x cevna kapa DN400
- Prirobnični priključki, EN1092-1, tip 11, PN16:
    1x DN250 (Ø273mm),
    7x DN200 (Ø219,1mm),
    4x DN50 (Ø60,3mm),
- Navojni priključki:
   2x manometska cev 1/2" NN
   2x 1/2" ZN
   1x 1" ZN
- Obratovalni tlak:  0,5 bar(g);
- Maksimalni tlak: 1 bar(g);
- Preizkusni tlak: 1,5 bar(g) 
- Material: nerjavno jeklo, 1.4301
(Poz: T 9030.03)
(Ustreza: Izdelan po merski skici tega načrta)', 1, N'kpl', NULL,
NULL, NULL, NULL, 13);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (326, 4, N'D1.9', NULL, 
N'Izdelava, dobava in montaža zbiralnika/razdelilnika za stolpno vodo. Obratovalna emperatura medija 5 do 40°C. Vnos na streho objekta  in postavljanje na mesto vgradnje (kota +20 m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz nerjavnih cevi ter 2x cevih kap. Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 14);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (327, 4, N'D1.9', NULL, 
N'Tehnične karakteristike:
- DN400 - Ø406,4mm, skupna dolžina cca 5400 mm
- 2x cevna kapa DN400
- Prirobnični priključki, EN1092-1, tip 11, PN16:
    3x DN250 (Ø273mm),
    3x DN200 (Ø219,1mm),
    1x DN150 (Ø168,3mm),
    1x DN80 (Ø88,9mm),
- Navojni priključki:
   2x manometska cev 1/2" NN
   2x 1/2" ZN
   1x 1" ZN
- 2x podporna nogica (sedlo)
- Obratovalni tlak:  2 bar(g);
- Maksimalni tlak: 6 bar(g);
- Preizkusni tlak: 8,8 bar(g) 
- Material: nerjavno jeklo, 1.4301
(Poz: T 9030.04)
(Ustreza: Izdelan po merski skici tega načrta)', 1, N'kpl', NULL,
NULL, NULL, NULL, 15);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (328, 4, N'D2.1', NULL, 
N'Elektromagnetni merilnik pretoka, primeren za vodo. 
Prirobnični procesni priključek, temperatura medija od 5 do 40 °C, tlak do 8 bar(g). Priključki iz ogljikovega jekla, PFA obloga. Vključno s pomožnim, montažnim in tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 16);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (329, 4, N'D2.1', NULL, 
N'Tehnične karakteristike:
- Merilno območje: 10 do 150  m3/h, nazivni pretok 120 m3/h
- Priključek: prirobnični, EN 1092-1, DN125, PN16
- Napajanje: 24 V DC
- Izhod: 4 - 20 mA
(Poz: FI 9030.732)
(Ustreza: E+H Promag P 300)', 1, N'kos', NULL,
NULL, NULL, NULL, 17);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (330, 4, N'D2.1', NULL, 
N'Tehnične karakteristike:
- Merilno območje: 20 do 300  m3/h, nazivni pretok 260 m3/h
- Priključek: prirobnični, EN 1092-1, DN200, PN16
- Napajanje: 24 V DC
- Izhod: 4 - 20 mA
(Poz: FI 9030.732)
(Ustreza: E+H Promag P 300)', 1, N'kos', NULL,
NULL, NULL, NULL, 18);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (331, 4, N'D2.2', NULL, 
N'Vodomer,  primeren za stolpno  (hladilno) vodo, pulzni izhod. 
Prirobnični procesni priključek, temperatura medija od 5 do 40 °C, tlak do 8 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 19);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (332, 4, N'D2.2', NULL, 
N'Tehnične karakteristike:
- Merilno območje: 0,4 do 40  m3/h, nazivni pretok 15 m3/h
- Priključek: prirobnični, EN 1092-1, DN50, PN16
- Izhod:pulz
(Poz: FQI 9030.730)
(Ustreza: ITRON Woltex M + Cyble sensor V2)', 1, N'kos', NULL,
NULL, NULL, NULL, 20);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (333, 4, N'D2.3', NULL, 
N'Pretočno stikalo z lopatico, za varovanje kompresorja, primerno za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Primerno za vgradnjo v cev DN65. Vključno z izdelavo odcepa DN25 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo.', NULL, N'', NULL,
NULL, NULL, NULL, 21);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (334, 4, N'D2.3', NULL, 
N'Tehnične karakteristike:
- Nastavljivo območje (cca 7,5 m3/h na cevi DN65)
- Priključek: navojni, G 1"
- Material: Medenina
- Napajanje: 24 - 250 V AC
(Poz: FSAL 9031.730)
(Ustreza: Kobold FPS-2100 P)', 1, N'kos', NULL,
NULL, NULL, NULL, 22);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (335, 4, N'D2.4', NULL, 
N'Merilnik tlaka, primeren za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Vključno z nerjavno priključno cevko in z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Piezouporovni merilni princip
- Priključek: navojni, G 1/2"
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA', NULL, N'', NULL,
NULL, NULL, NULL, 23);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (336, 4, N'D2.4', NULL, 
N'Merilno območje: 0 do 10 bar(g)
(Poz: PIC 9030.710)
(Ustreza: E+H PMP21)', 1, N'kpl', NULL,
NULL, NULL, NULL, 24);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (337, 4, N'D2.5', NULL, 
N'Merilnik temperature, uporovni, 1x Pt100, s priključno glavo na zaščitnem vratu, primeren za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Z integriranim pretvornikom. Vključno z ustrezno nerjavno zaščitno tulko. Dolžina ustrezna za montažo v cev DN100...DN400. Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Merilno območje: -50 do +50 °C
- 1 x Pt100, 3 žilna vezava
- Priključek: navojni, G 1/2"
- Potopna dolžina 100 mm, dolžina zaščitnega vratu 80 mm
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
(Poz: TI 9030.700, TI 9030.701, TI 9030.702, TI 9030.703, TI 9030.704)
(Ustreza: E+H TM121)', 5, N'kpl', NULL,
NULL, NULL, NULL, 25);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (338, 4, N'D2.6', NULL, 
N'Radarski merilnik nivoja (gladina vode), primeren za vgradnjo v bazen stolpne vode. Obratovalna temperatura 5 do 40 °C. Vključno z izdelavo nosilne konstrukcije za montažo na betonsko steno ali strop bazena ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Radarski (80 GHz) merilni princip
- Priključek: navojni, G 1-1/2"
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA', NULL, N'', NULL,
NULL, NULL, NULL, 26);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (339, 4, N'D2.6', NULL, 
N'Merilno območje: 0 do 4000 mm
(Poz: LIC 9030.720)
(Ustreza: E+H Micropilot FMR60B)', 1, N'kpl', NULL,
NULL, NULL, NULL, 27);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (340, 4, N'D2.7', NULL, 
N'Lokalni manometer za prikaz tlaka vode. Temperatura medija 5 do 40°C. Vključno z nerjavno priključno cevko z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm
- Polnilo: silikonsko olje', NULL, N'', NULL,
NULL, NULL, NULL, 28);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (341, 4, N'D2.7', NULL, 
N'Merilno območje 0 - 6 bar(g)
Radialni priključek
(Poz: PI 9030.910, PI 9031.910, PI 9031.911, PI 9031.912, PI 9031.913)
(Ustreza: INOL 821 DN100)', 5, N'kpl', NULL,
NULL, NULL, NULL, 29);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (342, 4, N'D2.8', NULL, 
N'Lokalni direktni termometer za prikaz temperature vode. Industrijski termometer, ki deluje na principu spremembe volumna polnila v tipalu, ki se preko membranske kapsule in mehanizma prenaša na kazalec. Tlak medija do 6 bar(g). Vključno z ustrezno nerjavno zašitno tulko.  Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm', NULL, N'', NULL,
NULL, NULL, NULL, 30);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (343, 4, N'D2.8', NULL, 
N'Merilno območje 0 / +60°C
Aksialni priključek
(Poz: TI 9030.900, TI 9031.900, TI 9031.901, TI 9031.902, TI 9031.903)
(Ustreza: INOL TI291 DN100 + tulka)', 5, N'kpl', NULL,
NULL, NULL, NULL, 31);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (344, 4, N'D2.9', NULL, 
N'Nivojsko stikalo, tripalična sonda z navojnim priključkom 1 1/2", z integrirani, stikalom. Z nosilcem za pritrditev v steno. Vključno z izdelavo nosilca in z vsem drobnim montažnim, tesnilnim, spojnim in elektro materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek: G 1 1/2" 
- 3x sonda, material 316L
- Dolžina sond: 3500 mm
(Poz: LSLA 9030.721 + LSHA 9030.722)
(Ustreza: E+H Liquipoint FTW31 + FEW54)', 1, N'kos', NULL,
NULL, NULL, NULL, 32);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (345, 4, N'D3.1', NULL, 
N'Zaporna loputa, medprirobnična LUG izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Loputa mora zagotavljati razred tesnenja A po EN 12266-1. Vključno s spojnim, vijačnim, tesnilnim ter elektro materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: Elektromotorni pogon z ON/OFF regulacijo in ustreznim navorom
- Material ohišja: nodularna litina
- Tesnila: EPDM
- Napajanje: 24 VDC
- 2x stikalo končnih leg
- Ohišje zaščita IP67', NULL, N'', NULL,
NULL, NULL, NULL, 33);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (346, 4, N'D3.1', NULL, 
N'DN 250
(Poz:  MBV 9030.110, MBV 9030.111)
(Ustreza: Belimo  D6250WL + PRCA-S2-T-250 ali ekvivalent ARI Armaturen ali IMP Armature)', 2, N'kos', NULL,
NULL, NULL, NULL, 34);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (347, 4, N'D3.2', NULL, 
N'Zaporna loputa, medprirobnična wafer izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Loputa mora zagotavljati razred tesnenja A po EN 12266-1. Vključno s spojnim, vijačnim, tesnilnim ter elektro materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: Elektromotorni pogon z zvezno regulacijo in ustreznim navorom
- Material: nodularna litina
- Tesnila: EPDM
- Napajanje: 24 VDC
- Krmilni signal 4-20 mA
- 2x stikalo končnih leg
- Ohišje zaščita IP67', NULL, N'', NULL,
NULL, NULL, NULL, 35);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (348, 4, N'D3.2', NULL, 
N'DN 200
(Poz: MBV 9030.070) 
(Ustreza: Belimo  D6250W + PRCA-BAC-S2-T-250 ali ekvivalent ARI Armaturen ali IMP Armature)', 1, N'kos', NULL,
NULL, NULL, NULL, 36);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (349, 4, N'D3.3', NULL, 
N'Krogelni ventil z elektromotornim pogonom, prirobnična izvedba. Primeren za stolpno vodo. Temperatura medija 5 do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim, tesnilnim in elektro materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Pogon: Elektromotorni pogon z ON/OFF regulacijo in ustreznim navorom
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
- Napajanje: 24V DC
- 2x stikalo končnih leg', NULL, N'', NULL,
NULL, NULL, NULL, 37);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (350, 4, N'D3.3', NULL, 
N'DN20
- Priključek: Varilni, DN20
(Poz: MV 9031.023)
(Ustreza: END Armaturen MP31 + pogon NE032100 ali enakovredno)', 1, N'kos', NULL,
NULL, NULL, NULL, 38);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (351, 4, N'D3.3', NULL, 
N'DN65
- Priključek: prirobnični, DN65,  EN1092, PN16
(Poz: MV 9031.007)
(Ustreza: END Armaturen MP31 + pogon NE092100 ali enakovredno)', 1, N'kos', NULL,
NULL, NULL, NULL, 39);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (352, 4, N'D3.4', NULL, 
N'Prehodni zaporni ventil z elektromagnetnim pogonom, 2/2 membranski servo, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g).  Vključno s pomožnim, montažnim, tesnilnim in elektro materialom ter funkcionalno montažo.', NULL, N'', NULL,
NULL, NULL, NULL, 40);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (353, 4, N'D3.4', NULL, 
N'Tehnične karakteristike:
- Priključek: navojni
- Material: medenina + EPDM
- Min. tlak: 0,5 bar(g)
- Kvs = 37 m3/h
- Zaščita IP65
- Napajanje: 24V DC
- NC (v primeru izpada el. enegije se ventil zapre)', NULL, N'', NULL,
NULL, NULL, NULL, 41);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (354, 4, N'D3.4', NULL, 
N'DN50
(Poz: EV 9030.062)
(Ustreza: Jakša M286 G2 ali enakovredno)', 1, N'kos', NULL,
NULL, NULL, NULL, 42);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (355, 4, N'D3.5', NULL, 
N'Trodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: trodelni krogelni ventil
- Priključek: navojni
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 43);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (356, 4, N'D3.5', NULL, 
N'DN15
(Poz: V 9030.004, V 9030.010, V 9030.016, V 9030.045, V 9030.047, V 9030.048, V 9030.060, V 9030.065, V 9030.112, V 9030.113, V 9031.001, V 9031.010, V 9031.021, V 9031.123)
(Ustreza: END Armaturen ZE31 ali enakovredno)', 14, N'kos', NULL,
NULL, NULL, NULL, 44);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (357, 4, N'D3.5', NULL, 
N'DN15 s ključavnico
(Poz: V 9031.101, V 9031.121)
(Ustreza: END Armaturen ZE31 ali enakovredno)', 2, N'kos', NULL,
NULL, NULL, NULL, 45);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (358, 4, N'D3.5', NULL, 
N'DN25
(Poz: V 9030.049, V 9030.051, V 9030.054, V 9030.066)
(Ustreza: END Armaturen ZE31 ali enakovredno)', 4, N'kos', NULL,
NULL, NULL, NULL, 46);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (359, 4, N'D3.6', NULL, 
N'Dvodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: dvodelni krogelni ventil
- Priključek: prirobnični, po EN 1092
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 47);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (360, 4, N'D3.6', NULL, 
N'DN50
(Poz: V 9030.040, V 9030.041, V 9030.042, V 9030.044, V 9030.061)
(Ustreza: END Armaturen MP31 ali enakovredno)', 5, N'kos', NULL,
NULL, NULL, NULL, 48);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (361, 4, N'D3.6', NULL, 
N'DN65
(Poz: V 9031.004, V 9031.103, V 9031.104, V 9032.001)
(Ustreza: END Armaturen MP31 ali enakovredno)', 4, N'kos', NULL,
NULL, NULL, NULL, 49);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (362, 4, N'D3.7', NULL, 
N'Trodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 0 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: trodelni krogelni ventil
- Priključek: varilni
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 50);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (363, 4, N'D3.7', NULL, 
N'DN20
(Poz: V 9031.002, V 9031.020, V 9031.124)
(Ustreza: END Armaturen ZE31 ali enakovredno)', 3, N'kos', NULL,
NULL, NULL, NULL, 51);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (364, 4, N'D3.7', NULL, 
N'DN50
(Poz: V 9030.064)
(Ustreza: END Armaturen ZE31  ali enakovredno)', 1, N'kos', NULL,
NULL, NULL, NULL, 52);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (365, 4, N'D3.8', NULL, 
N'Zaporna loputa, medprirobnična WAFER izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s spojnim, vijačnim in tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: ročni pogon z ročico do vključno DN100,
               ročni polžni pogon nad DN100
- Material ohišja: nodularna litina
- Tesnila: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 53);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (366, 4, N'D3.8', NULL, 
N'DN80
(Poz: BV 9030.059, BV 9030.103) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)', 2, N'kos', NULL,
NULL, NULL, NULL, 54);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (367, 4, N'D3.8', NULL, 
N'DN150
(Poz: BV 9030.053, BV 9030.055, BV 9030.058, BV 9030.104) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)', 4, N'kos', NULL,
NULL, NULL, NULL, 55);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (368, 4, N'D3.8', NULL, 
N'DN200
(Poz: BV 9030.002, BV 9030.007, BV 9030.008, BV 9030.014, BV 9030.019, BV 9030.102, BV9030.013) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)', 7, N'kos', NULL,
NULL, NULL, NULL, 56);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (369, 4, N'D3.8', NULL, 
N'DN250
(Poz: BV 9030.050, BV 9030.052, BV 9030.101) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)', 3, N'kos', NULL,
NULL, NULL, NULL, 57);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (370, 4, N'D3.9', NULL, 
N'Zaporna loputa, medprirobnična LUG izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s spojnim, vijačnim in tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: ročni pogon z ročico do vključno DN100,
               ročni polžni pogon nad DN100
- Material ohišja: nodularna litina
- Tesnila: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 58);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (371, 4, N'D3.9', NULL, 
N'DN200
(Poz: BV 9030.025, BV 9030.020, BV 9030.057, BV 9030.031, BV 9030.026, BV 9030.056, BV 9030.106, BV 9030.105) 
(Ustreza: IMP Armature tip Art. 126- ali enakovredno ARI Armaturen tip Gesa)', 8, N'kos', NULL,
NULL, NULL, NULL, 59);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (372, 4, N'D3.10', NULL, 
N'Zaporni  zasun, prirobnični, primeren za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s spojnim, vijačnim in tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: prirobnični, EN1092-1, PN16
- Material ohišja: EN GJS-400-15
- Tesnila: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 60);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (373, 4, N'D3.10', NULL, 
N'DN400
(Poz: V 9030.001) 
(Ustreza: IMP Armature tip Art. 735 ali enakovredno)', 1, N'kos', NULL,
NULL, NULL, NULL, 61);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (374, 4, N'D3.11', NULL, 
N'Nepovratna loputa, za vertikalno vgradnjo brez vzmeti, primerna za vodo. Vgradna dolžina po EN 558-1, serija 14. Ročni pogon s kolesom. Temperatura medija 0 do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: medprirobnični, EN1092-1, PN16 
- Material: ohišje 1.0460, disk 1.4581
- Tesnilo: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 62);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (375, 4, N'D3.11', NULL, 
N'DN 200
(Poz: CV 9030.006, CV 9030.012, CV 9030.018)
(Ustreza: Gestra CB26 ali enakovredno)', 3, N'kos', NULL,
NULL, NULL, NULL, 63);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (376, 4, N'D3.12', NULL, 
N'Dušilni ventil za hidravlično uravnoteženje, primeren za stolpno vodo. Poševnosedežna izvedba. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični,  EN 1092, PN16
- Material: Siva litina (EN-GJL-250)
- Tesnila: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 64);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (377, 4, N'D3.12', NULL, 
N'DN65
(Poz: RV 9031.008)
(Ustreza: IMI TA STAF ali enakovredno)', 1, N'kos', NULL,
NULL, NULL, NULL, 65);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (378, 4, N'D3.13', NULL, 
N'Dušilni ventil za hidravlično uravnoteženje, primeren za stolpno vodo. Poševnosedežna izvedba, z regulacijskim stožcem. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: varilni
- Mehko tesnenje, tesnilo PTFE', NULL, N'', NULL,
NULL, NULL, NULL, 66);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (379, 4, N'D3.13', NULL, 
N'DN15
(Poz: RV 9030.046, RV 9031.024)
(Ustreza: END Armaturen AE311062/L-RK  ali enakovredno)', 2, N'kos', NULL,
NULL, NULL, NULL, 67);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (380, 4, N'D3.13', NULL, 
N'DN50
(Poz: RV 9030.063)
(Ustreza: END Armaturen AE311067/L-RK  ali enakovredno)', 1, N'kos', NULL,
NULL, NULL, NULL, 68);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (381, 4, N'D3.14', NULL, 
N'DN20
(Poz: SF 9031.022)
(Ustreza: IMP Armature Art. 020)', 1, N'kos', NULL,
NULL, NULL, NULL, 69);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (382, 4, N'D3.14', NULL, 
N'DN65
(Poz: SF 9031.006)
(Ustreza: IMP Armature Art. 020)', 1, N'kos', NULL,
NULL, NULL, NULL, 70);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (383, 4, N'D3.14', NULL, 
N'DN 200
Z izpustnim ventilom 1/2"
(Poz: SF 9030.003, SF 9030.009, SF 9030.015)
(Ustreza: IMP Armature Art. 020)', 3, N'kos', NULL,
NULL, NULL, NULL, 71);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (384, 4, N'D3.15', NULL, 
N'Varnostni ventil, razbremenilna funkcija, ustrezen za hladilno vodo. Temperatura medija 5 do 40 °C. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. Priložen certifikat testa.', NULL, N'', NULL,
NULL, NULL, NULL, 72);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (385, 4, N'D3.15', NULL, 
N'Tehnične karakteristike:
- Priključek: navojni
- Material: nerjavno jeklo
- Tlak odpiranja: 6 bar(g)
- Zaprta izvedba mehanizma
- Vzmetni, prednastavljen. 
DN 15 / DN 15
(Poz: SV 9031.102, SV 9031.122)
(Ustreza: End Armaturen SV320023/L)', 2, N'kos', NULL,
NULL, NULL, NULL, 73);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (386, 4, N'D3.15', NULL, 
N'MANOMETRSKI VENTIL', NULL, N'', NULL,
NULL, NULL, NULL, 74);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (387, 4, N'D3.15', NULL, 
N'Manometrski iglični ventil, navojni priključek: G 1/2". Material: nerjavni (1.4301 ali boljše).
Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.', NULL, N'', NULL,
NULL, NULL, NULL, 75);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (388, 4, N'D3.15', NULL, 
N'Z odprtino za razbremenitev (DIN 16270).  
(Poz: V 9030.068, V 9031.009, V 9031.025, V 9031.100,  V 9031.120)
(Ustreza: INOL manom. ventil (inox) DIN16270)', 5, N'kos', NULL,
NULL, NULL, NULL, 76);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (389, 4, N'D3.15', NULL, 
N'Z odprtino za razbremenitev in testnim priključkom (DIN 16271)
(Poz: V 9030.067)
(Ustreza: INOL manom. ventil (inox) DIN16271)', 1, N'kos', NULL,
NULL, NULL, NULL, 77);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (390, 4, N'D3.15', NULL, 
N'AVTOMATSKI ODZRAČEVALNI LONČEK', NULL, N'', NULL,
NULL, NULL, NULL, 78);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (391, 4, N'D3.15', NULL, 
N'Avtomatski odzračevalni lonček s plovcem, industrijska izvedba, primeren za hladilno vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek vstop: notranji navoj, G 3/4" 
- Priključek izstop: zunanji navoj, G 1/2" 
- Material: nerjaveče jeklo
(Poz: AO 9031.003)
(Ustreza: Mankenberg EB 1.32 ali enakovredno)', 1, N'kos', NULL,
NULL, NULL, NULL, 79);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (392, 4, N'D3.15', NULL, 
N'KOMPENZATOR', NULL, N'', NULL,
NULL, NULL, NULL, 80);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (393, 4, N'D3.15', NULL, 
N'Prirobnični gumi kompenzator, primeren za hladilno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični, po EN 1092
- Material prirobnic: pocinkano ali ponikljano jeklo
- Material meha: EPDM', NULL, N'', NULL,
NULL, NULL, NULL, 81);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (394, 4, N'D3.15', NULL, 
N'DN 150
(Poz: K 9030.005, K 9030.011, K 9030.017
(Ustreza: Giaflex EGK ali End Armaturen KP54 ali enakovredno)', 3, N'kos', NULL,
NULL, NULL, NULL, 82);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (395, 4, N'D4.1', NULL, 
N'Cev, varjena, nerjavna - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10217-7,  certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 83);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (396, 4, N'D4.1', NULL, 
N'DN 15 (Ø21,3 x 1,6 mm)', 25, N'm', NULL,
NULL, NULL, NULL, 84);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (397, 4, N'D4.1', NULL, 
N'DN 20 (Ø26,9 x 1,6 mm)', 15, N'm', NULL,
NULL, NULL, NULL, 85);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (398, 4, N'D4.1', NULL, 
N'DN 25 (Ø33,7 x 1,6 mm)', 6, N'm', NULL,
NULL, NULL, NULL, 86);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (399, 4, N'D4.1', NULL, 
N'DN 50 (Ø60,3 x 1,6 mm)', 50, N'm', NULL,
NULL, NULL, NULL, 87);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (400, 4, N'D4.1', NULL, 
N'DN 65 (Ø76,1 x 2 mm)', 6, N'm', NULL,
NULL, NULL, NULL, 88);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (401, 4, N'D4.1', NULL, 
N'DN 80 (Ø88,9 x 2 mm)', 70, N'm', NULL,
NULL, NULL, NULL, 89);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (402, 4, N'D4.1', NULL, 
N'DN 100 (Ø114,3 x 2 mm)', 45, N'm', NULL,
NULL, NULL, NULL, 90);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (403, 4, N'D4.1', NULL, 
N'DN 125 (Ø139,7 x 2 mm)', 3, N'm', NULL,
NULL, NULL, NULL, 91);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (404, 4, N'D4.1', NULL, 
N'DN 150 (Ø168,3 x 2 mm)', 30, N'm', NULL,
NULL, NULL, NULL, 92);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (405, 4, N'D4.1', NULL, 
N'DN 200 (Ø219,1 x 2,6 mm)', 8, N'm', NULL,
NULL, NULL, NULL, 93);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (406, 4, N'D4.1', NULL, 
N'DN 250 (Ø273,0 x 2,6 mm)', 25, N'm', NULL,
NULL, NULL, NULL, 94);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (407, 4, N'D4.1', NULL, 
N'DN 300 (Ø323,9 x 3 mm)', 2, N'm', NULL,
NULL, NULL, NULL, 95);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (408, 4, N'D4.1', NULL, 
N'DN 400 (Ø406,4 x 3,2 mm)', 50, N'm', NULL,
NULL, NULL, NULL, 96);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (409, 4, N'D4.2', NULL, 
N'Koleno, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 97);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (410, 4, N'D4.2', NULL, 
N'DN 15 (Ø21,3 x 2 mm)', 20, N'kos', NULL,
NULL, NULL, NULL, 98);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (411, 4, N'D4.2', NULL, 
N'DN 20 (Ø26,9 x 1,6 mm)', 15, N'kos', NULL,
NULL, NULL, NULL, 99);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (412, 4, N'D4.2', NULL, 
N'DN 25 (Ø33,7 x 1,6 mm)', 12, N'kos', NULL,
NULL, NULL, NULL, 100);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (413, 4, N'D4.2', NULL, 
N'DN 50 (Ø60,3 x 1,6 mm)', 28, N'kos', NULL,
NULL, NULL, NULL, 101);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (414, 4, N'D4.2', NULL, 
N'DN 65 (Ø76,1 x 2 mm)', 2, N'kos', NULL,
NULL, NULL, NULL, 102);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (415, 4, N'D4.2', NULL, 
N'DN 80 (Ø88,9 x 2 mm)', 35, N'kos', NULL,
NULL, NULL, NULL, 103);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (416, 4, N'D4.2', NULL, 
N'DN 100 (Ø114,3 x 2 mm)', 20, N'kos', NULL,
NULL, NULL, NULL, 104);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (417, 4, N'D4.2', NULL, 
N'DN 150 (Ø168,3 x 2 mm)', 6, N'kos', NULL,
NULL, NULL, NULL, 105);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (418, 4, N'D4.2', NULL, 
N'DN 200 (Ø219,1 x 2,6 mm)', 1, N'kos', NULL,
NULL, NULL, NULL, 106);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (419, 4, N'D4.2', NULL, 
N'DN 250 (Ø273,0 x 2,6 mm)', 7, N'kos', NULL,
NULL, NULL, NULL, 107);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (420, 4, N'D4.2', NULL, 
N'DN 300 (Ø323,9 x 3 mm)', 1, N'kos', NULL,
NULL, NULL, NULL, 108);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (421, 4, N'D4.2', NULL, 
N'DN 400 (Ø406,4 x 3,2 mm)', 6, N'kos', NULL,
NULL, NULL, NULL, 109);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (422, 4, N'D4.3', NULL, 
N'Koleno 45°, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 110);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (423, 4, N'D4.3', NULL, 
N'DN 100 (Ø114,3 x 2 mm)', 2, N'kos', NULL,
NULL, NULL, NULL, 111);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (424, 4, N'D4.3', NULL, 
N'DN 150 (Ø168,3 x 2 mm)', 3, N'kos', NULL,
NULL, NULL, NULL, 112);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (425, 4, N'D4.3', NULL, 
N'DN 250 (Ø273,0 x 2,6 mm)', 3, N'kos', NULL,
NULL, NULL, NULL, 113);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (426, 4, N'D4.4', NULL, 
N'T-kos, material W.Nr.1.4301, tehnični pogoji po EN10253-4. Certifikat EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 114);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (427, 4, N'D4.4', NULL, 
N'DN 50 (Ø60,3 x 1,6 mm)', 2, N'kos', NULL,
NULL, NULL, NULL, 115);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (428, 4, N'D4.4', NULL, 
N'DN 80 (Ø88,9 x 2 mm)', 1, N'kos', NULL,
NULL, NULL, NULL, 116);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (429, 4, N'D4.4', NULL, 
N'DN 250 (Ø273,0 x 2,6 mm)', 1, N'kos', NULL,
NULL, NULL, NULL, 117);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (430, 4, N'D4.5', NULL, 
N'T-kos reducirni, material W.Nr.1.4301, tehnični pogoji po EN10253-4. Certifikat EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 118);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (431, 4, N'D4.5', NULL, 
N'DN 80/65', 1, N'kos', NULL,
NULL, NULL, NULL, 119);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (432, 4, N'D4.5', NULL, 
N'DN 400/300', 1, N'kos', NULL,
NULL, NULL, NULL, 120);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (433, 4, N'D4.6', NULL, 
N'Reducirni kos. nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 121);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (434, 4, N'D4.6', NULL, 
N'DN 20/15', 4, N'kos', NULL,
NULL, NULL, NULL, 122);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (435, 4, N'D4.6', NULL, 
N'DN 32/20', 2, N'kos', NULL,
NULL, NULL, NULL, 123);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (436, 4, N'D4.6', NULL, 
N'DN 65/50', 2, N'kos', NULL,
NULL, NULL, NULL, 124);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (437, 4, N'D4.6', NULL, 
N'DN 80/65', 3, N'kos', NULL,
NULL, NULL, NULL, 125);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (438, 4, N'D4.6', NULL, 
N'DN 150/100', 2, N'kos', NULL,
NULL, NULL, NULL, 126);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (439, 4, N'D4.6', NULL, 
N'DN 150/125', 2, N'kos', NULL,
NULL, NULL, NULL, 127);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (440, 4, N'D4.6', NULL, 
N'DN 200/125', 3, N'kos', NULL,
NULL, NULL, NULL, 128);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (441, 4, N'D4.6', NULL, 
N'DN 200/150', 3, N'kos', NULL,
NULL, NULL, NULL, 129);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (442, 4, N'D4.6', NULL, 
N'DN 250/200', 4, N'kos', NULL,
NULL, NULL, NULL, 130);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (443, 4, N'D4.6', NULL, 
N'DN 400/300', 1, N'kos', NULL,
NULL, NULL, NULL, 131);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (444, 4, N'D4.7', NULL, 
N'Varilna prirobnica z grlom.
- dimenzije po EN 1092-1, tip 11, B1;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim, vijačnim in varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot fiting)', NULL, N'', NULL,
NULL, NULL, NULL, 132);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (445, 4, N'D4.7', NULL, 
N'DN 20, PN16', 2, N'kos', NULL,
NULL, NULL, NULL, 133);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (446, 4, N'D4.7', NULL, 
N'DN 32, PN16', 4, N'kos', NULL,
NULL, NULL, NULL, 134);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (447, 4, N'D4.7', NULL, 
N'DN 50, PN16', 14, N'kos', NULL,
NULL, NULL, NULL, 135);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (448, 4, N'D4.7', NULL, 
N'DN 65, PN16', 8, N'kos', NULL,
NULL, NULL, NULL, 136);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (449, 4, N'D4.7', NULL, 
N'DN 80, PN16', 2, N'kos', NULL,
NULL, NULL, NULL, 137);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (450, 4, N'D4.7', NULL, 
N'DN 100, PN16', 2, N'kos', NULL,
NULL, NULL, NULL, 138);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (451, 4, N'D4.7', NULL, 
N'DN 125, PN16', 5, N'kos', NULL,
NULL, NULL, NULL, 139);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (452, 4, N'D4.7', NULL, 
N'DN 150, PN16', 9, N'kos', NULL,
NULL, NULL, NULL, 140);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (453, 4, N'D4.7', NULL, 
N'DN 200, PN16', 18, N'kos', NULL,
NULL, NULL, NULL, 141);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (454, 4, N'D4.7', NULL, 
N'DN 250, PN16', 6, N'kos', NULL,
NULL, NULL, NULL, 142);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (455, 4, N'D4.7', NULL, 
N'DN 300, PN16', 4, N'kos', NULL,
NULL, NULL, NULL, 143);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (456, 4, N'D4.7', NULL, 
N'DN 400, PN16', 5, N'kos', NULL,
NULL, NULL, NULL, 144);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (457, 4, N'D4.8', NULL, 
N'Slepa prirobnica.
- dimenzije po EN 1092-1, tip 5;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim in vijačnim materialom.', NULL, N'', NULL,
NULL, NULL, NULL, 145);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (458, 4, N'D4.8', NULL, 
N'DN 65, PN16', 2, N'kos', NULL,
NULL, NULL, NULL, 146);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (459, 4, N'D4.8', NULL, 
N'DN 200, PN16', 6, N'kos', NULL,
NULL, NULL, NULL, 147);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (460, 4, N'D4.8', NULL, 
N'DN 250, PN16', 1, N'kos', NULL,
NULL, NULL, NULL, 148);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (461, 4, N'D4.9', NULL, 
N'Cev, za vodenje gikbih cevi za doziranje biocida in inhibitorja. Cev, varjena, nerjavna - material W.Nr.1.4301 (AISI 304), Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).', NULL, N'', NULL,
NULL, NULL, NULL, 149);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (462, 4, N'D4.9', NULL, 
N'DN 25 (Ø33,7 x 1,6 mm)', 35, N'm', NULL,
NULL, NULL, NULL, 150);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (463, 4, N'D5.1', NULL, 
N'DN 150', 2, N'kpl', NULL,
NULL, NULL, NULL, 151);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (464, 4, N'D5.1', NULL, 
N'DN 250', 2, N'kpl', NULL,
NULL, NULL, NULL, 152);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (465, 4, N'D5.1', NULL, 
N'DN 300', 1, N'kpl', NULL,
NULL, NULL, NULL, 153);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (466, 4, N'D5.1', NULL, 
N'DN 400', 1, N'kpl', NULL,
NULL, NULL, NULL, 154);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (467, 4, N'D5.2', NULL, 
N'DN 150', 2, N'kpl', NULL,
NULL, NULL, NULL, 155);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (468, 4, N'D5.2', NULL, 
N'DN 250', 2, N'kpl', NULL,
NULL, NULL, NULL, 156);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (469, 4, N'D5.2', NULL, 
N'DN 400', 2, N'kpl', NULL,
NULL, NULL, NULL, 157);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (470, 4, N'D5.3', NULL, 
N'DN 100', 2, N'kpl', NULL,
NULL, NULL, NULL, 158);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (471, 4, N'D5.3', NULL, 
N'DN 150', 2, N'kpl', NULL,
NULL, NULL, NULL, 159);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (472, 4, N'D5.3', NULL, 
N'DN 250', 2, N'kpl', NULL,
NULL, NULL, NULL, 160);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (473, 4, N'D5.3', NULL, 
N'DN 400', 1, N'kpl', NULL,
NULL, NULL, NULL, 161);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (474, 4, N'D5.4', NULL, 
N'DN 400', 1, N'kpl', NULL,
NULL, NULL, NULL, 162);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (475, 4, N'D5.5', NULL, 
N'DN 15', 15, N'kpl', NULL,
NULL, NULL, NULL, 163);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (476, 4, N'D5.5', NULL, 
N'DN 20', 10, N'kpl', NULL,
NULL, NULL, NULL, 164);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (477, 4, N'D5.5', NULL, 
N'DN 25', 4, N'kpl', NULL,
NULL, NULL, NULL, 165);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (478, 4, N'D5.5', NULL, 
N'DN 50', 25, N'kpl', NULL,
NULL, NULL, NULL, 166);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (479, 4, N'D5.5', NULL, 
N'DN 65', 5, N'kpl', NULL,
NULL, NULL, NULL, 167);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (480, 4, N'D5.5', NULL, 
N'DN 80', 35, N'kpl', NULL,
NULL, NULL, NULL, 168);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (481, 4, N'D5.5', NULL, 
N'DN 100', 20, N'kpl', NULL,
NULL, NULL, NULL, 169);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (482, 4, N'D5.5', NULL, 
N'DN 125', 2, N'kpl', NULL,
NULL, NULL, NULL, 170);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (483, 4, N'D5.5', NULL, 
N'DN 150', 10, N'kpl', NULL,
NULL, NULL, NULL, 171);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (484, 4, N'D5.5', NULL, 
N'DN 200', 2, N'kpl', NULL,
NULL, NULL, NULL, 172);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (485, 4, N'D5.5', NULL, 
N'DN 250', 6, N'kpl', NULL,
NULL, NULL, NULL, 173);
INSERT INTO EX.Components (Id, SectionID, GroupCode, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (486, 4, N'D5.5', NULL, 
N'DN 400', 4, N'kpl', NULL,
NULL, NULL, NULL, 174);
SET IDENTITY_INSERT EX.Components OFF
GO
UPDATE ex.Components SET HeaderSubgroupId = (SELECT Id FROM ex.HeaderSubgroups HSG WHERE C.GroupCode=HSG.GroupCode)
FROM ex.Components C
GO




