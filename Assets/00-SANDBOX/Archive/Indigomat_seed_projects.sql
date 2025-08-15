create database Indigomat;
go
USE Indigomat
GO
CREATE SCHEMA SETUP;
GO
CREATE SCHEMA APP;
GO
CREATE SCHEMA EX;
GO

select * from ex.Component

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
)

-- Create tables with SortOrder
CREATE TABLE EX.ProjectSection (
    Id INT IDENTITY PRIMARY KEY
	,ProjectId INT FOREIGN KEY REFERENCES APP.Projects(Id)
    ,SectionName NVARCHAR(255)
    ,SheetName NVARCHAR(255)
    ,SortOrder INT
	,CreatedOn DATETIME DEFAULT GETDATE()
	,CreatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,UpdatedOn DATETIME DEFAULT GETDATE()
	,UpdatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,[RowVersion] RowVersion
);

CREATE TABLE EX.Component (
    Id INT IDENTITY PRIMARY KEY
    ,SectionID INT FOREIGN KEY REFERENCES EX.ProjectSection(Id)
    ,Position NVARCHAR(50)
    ,Description NVARCHAR(MAX)
    ,Quantity DECIMAL(10, 2)
    ,Unit NVARCHAR(50)
    ,SupplyPerUnit DECIMAL(10, 2)
    ,InstallationPerUnit DECIMAL(10, 2)
    ,TotalPerUnit DECIMAL(10, 2)
    ,Total DECIMAL(10, 2)
    ,SortOrder INT
	,CreatedOn DATETIME DEFAULT GETDATE()
	,CreatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,UpdatedOn DATETIME DEFAULT GETDATE()
	,UpdatedBy NVARCHAR(100) DEFAULT SUSER_SNAME()
	,[RowVersion] RowVersion
);
INSERT INTO app.Projects(ProjectName)  VALUES ('870-SandboxProject')
-- Insert project sections
SET IDENTITY_INSERT EX.ProjectSection ON
INSERT INTO EX.ProjectSection (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (1,1, N'Rekapitulacija', N'Rekapitulacija', 1);
INSERT INTO EX.ProjectSection (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (2,1, N'Priprava in razvod GM-25_-15', N'Priprava in razvod GM-25_-15', 2);
INSERT INTO EX.ProjectSection (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (3,1, N'HV29-35_PTV11_VMEH', N'HV29-35_PTV11_VMEH ', 3);
INSERT INTO EX.ProjectSection (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (4,1, N'Hladilna voda HV20-30', N'Hladilna voda HV20-30', 4);
INSERT INTO EX.ProjectSection (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (5,1, N'SKUPNO', N'SKUPNO', 5);
INSERT INTO EX.ProjectSection (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (6,1, N'KVALIFIKACIJE', N'KVALIFIKACIJE', 6);
INSERT INTO EX.ProjectSection (Id,ProjectId, SectionName, SheetName, SortOrder) VALUES (7,1, N'SPLOŠNO', N'SPLOŠNO', 7);
SET IDENTITY_INSERT EX.ProjectSection OFF
-- Insert EX.Components
SET IDENTITY_INSERT EX.Component ON
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (1, 2, N'A1.1', N'HLADILNI AGREGAT -25/-15 (samo montaža)
Serijsko tovarniško izdelan vodno hlajen hladilnik tekočin za pripravo 50% etilen-glikolske mešanice. Dobava: nerazloženo na tovornjaku . Vnos v objekt z uporabo avtodvigala, transport in postavljanje na mesto vgradnje (montaža v 1N, kota + 7,6m, vnosna odprtina š3000xv4500mm). Niveliranje in fiksiranje  na mestu postavitve, vključno s pritrdilnim materialom..  Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje in SCADO v sklopu elektro popisa.
STROJNE ZAHTEVE:
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
- možnost krmiljenja črpalke kondenzatorja
Tehnične karkteristike:
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
(Predvidena oprema: CULE AEGIR 150-2-5SPEC)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 1);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (2, 2, N'A1.2', N'HIDRAVLIČNA KRETNICA - VERTIKALNI REZERVOAR 6,5 m3
Izdelava, dobava in montaža vertikalnega rezervoarja za 50 % etilen-glikolsko mešanico. Temperatura medija -25°C.
Transport in postavljanje na mesto vgradnje (montaža v 1N, kota + 7,6m). Niveliranje in fiksiranje rezervoarja na mestu postavitve, vključno s pritrdilnim materialom. Izdelan skladno z direktivo o tlačni opremi (PED).
Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.
Tehnične karakteristike:
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
(Ustreza: Izdelan po merski skici tega načrta)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 2);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (3, 2, N'A1.3', N'RAZDELILNIK/ZBIRALNIK GM-25/-15
Izdelava, dobava in montaža zbiralnika/razdelilnika za 50 % etilen-glikolsko mešanico. Obratovalna emperatura medija -25°C. Transport in postavljanje na mesto vgradnje (montaža v 1N, kota + 7,6m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz cevi ter cevnih kap. Protikorozijsko zaščiten z barvanjem 2x osnovni + 2x končni premaz, z barvo ustrezno za obratovalne pogoje.  Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.
Tehnične karakteristike:
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
(Ustreza: Izdelan po merski skici tega načrta)
Tehnične karakteristike:
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
(Ustreza: Izdelan po merski skici tega načrta)
Tehnične karakteristike:
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
(Ustreza: Izdelan po merski skici tega načrta)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 3);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (4, 2, N'A1.4', N'REZERVOAR GLIKOLA ZA DOPOLNJEVANJE GM-25/-20 in GM-5/1
Izdelava, dobava in montaža pravokotnega rezervoarja za etilen-glikolsko mešanico. Vertikalna pregrada po sredinini - dva prekata, en prekat za 50% EG mešanico, drugi prekat za 30% EG mešanico. Temperatura medija 20°C. Odprt na atmosfero (ni tlačna posoda).
Transport in postavljanje na mesto vgradnje (montaža v 1N, kota + 7,6m). Niveliranje in fiksiranje rezervoarja na mestu postavitve, vključno s pritrdilnim materialom.
Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten, ojačitev in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.
Tehnične karakteristike:
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
(Ustreza: Izdelan po merski skici tega načrta)
MERILNA OPREMA', NULL, 
N'', NULL, NULL, 
NULL, NULL, 4);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (5, 2, N'A2.1', N'MERILNIK PRETOKA
Elektromagnetni merilnik pretoka, primeren za 50% etilen-glikolsko mešanico. 
Prirobnični procesni priključek, obratovalna temperatura medija -25°C, tlak do 8 bar(g). Priključki iz nerjavnega jekla, PTFE obloga. Vključno s pomožnim, montažnim in tesnilnim materialom.
Tehnične karakteristike:
- Merilno območje: 5 do 100  m3/h, nazivni pretok 70 m3/h
- Priključek: prirobnični, EN 1092-1, DN125, PN16
- Napajanje: 24 V DC
- Izhod: 4 - 20 mA
(Poz: FI 9001.730)
(Ustreza: E+H Promag P 300)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 5);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (6, 2, N'A2.2', N'MERILNIK TLAKA
Merilnik tlaka, primeren za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Vključno z nerjavno priključno U/O cevko, z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Merilno območje: 0 do 10 bar(g)
- Piezouporovni merilni princip
- Priključek: navojni, G 1/2"
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
(Poz: PI 9000.711, PI 9000.712, PIC 9001.710, PICA 9001.711)
(Ustreza: E+H PMP21)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 6);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (7, 2, N'A2.3', N'MERILNIK TEMPERATURE
Merilnik temperature, uporovni, 1x Pt100, s priključno glavo na zaščitnem vratu, primeren za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Z integriranim pretvornikom. Vključno z ustrezno nerjavno zaščitno tulko. Dolžina ustrezna za montažo v cev DN100...DN400. Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Merilno območje: -30 do +60 °C
- 1 x Pt100, 3 žilna vezava
- Priključek: navojni, G 1/2"
- Potopna dolžina 100 mm, dolžina zaščitnega vratu 80 mm
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
(Poz: TI 9000.701, TI 9000.702, TIC 9000.703, TIC 9000.704, TI 9001.700, TI 9001.701, TI 9001.702)
(Ustreza: E+H TM121)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 7);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (8, 2, N'A2.4', N'BYPASS NIVOKAZ
Bypass nivokaz, z magnetnim plovcem, in magnetostriktnivnim senzorjem nivoja; PP valjčki za vizualni prikaz in dvema končnima stikaloma. Za montažo na rezervoar glikolske mešanice za dopolnjevanje, gostota medija 1060 kg/m3, delovna temperatura 0 do +40°C, max. tlak 1 bar(g), procesni prirobnični priključek DN15, PN16 (EN 1092), nerjavna izvedba, tlačna stopnja PN16. Dolžino pred kontrolirati glede na razmak med priključkoma na rezervoarju T 9002.01  (predvidoma 1750mm). Napajanje magnetostriktivnega senzorja: 24V DC, izhod 4-20 mA. Vključno s pomožnim, montažnim, elektro in tesnilnim materialom ter s funkcionalno montažo.
(Poz: LI 9002.720 + LSLA 9002.721 + LSHA 9002.722 + LI 9002.723)
(Ustreza: Kobold NBK-M2F15PT10 + 2x NBK-RM)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 8);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (9, 2, N'A2.5', N'MANOMETER
Lokalni manometer za prikaz tlaka 50% etilen-glikolske mešanice. Temperatura medija -25 do 40°C. 
Vključno z nerjavno priključno U cevko, z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm
- Polnilo: silikonsko olje
Merilno območje 0 - 4 bar(g)
Radialni priključek
(Poz: PI 9000.910, PI 9000.911, PI 9000.912, PI 9000.913, PI 9000.914, PI 9000.915, PI 9000.916, PI 9001.910, PI 9001.912, PI 9002.910)
(Ustreza: INOL IM 821 DN100)
Merilno območje 0 - 10 bar(g)
(Poz: PI 9001.911)
(Ustreza: INOL IM 821 DN100)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 9);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (10, 2, N'A2.6', N'TERMOMETER
Lokalni direktni termometer za prikaz temperature 50% etilen-glikolske mešanice. Industrijski termometer, ki deluje na principu spremembe volumna polnila v tipalu, ki se preko membranske kapsule in mehanizma prenaša na kazalec. Tlak medija do 8 bar(g). Vključno z ustrezno nerjavno zašitno tulko.  Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm
Merilno območje -40 / +40°C
Aksialni priključek
(Poz: TI 9000.901, TI 9000.902, TI 9000.903, TI 9000.904, TI 9000.905, TI 9000.906, TI 9001.900, TI 9001.902, TI 9011.901)
(Ustreza: INOL TI-291 DN100 + tulka)
ARMATURE', NULL, 
N'', NULL, NULL, 
NULL, NULL, 10);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (11, 2, N'A3.1', N'KROGELNI ZAPORNI VENTIL - VARILNI
Trodelni krogelni ventil, z razbremenitvijo tlaka v vmesnem prostoru ventila (luknjica ali razbremenilno tesnilo), industrijska izvedba, za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: trodelni krogelni ventil, z razbremenilno luknjico
- Priključek: varilni
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
DN40
(Poz:V 9002.030, V 9002.031)
(Ustreza: END Armaturen ZE31 - z luknjico)
DN40 s ključavnico
(Poz: V 9000.004, V 9002.032)
(Ustreza: END Armaturen ZE31 - z luknjico + ključavnica)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 11);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (12, 2, N'A3.2', N'KROGELNI ZAPORNI VENTIL - PRIROBNIČNI
Dvodelni krogelni ventil, z razbremenitvijo tlaka v vmesnem prostoru ventila (luknjica ali razbremenilno tesnilo) v odprtem in zaprtem položaju, industrijska izvedba, za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: dvodelni krogelni ventil, z razbremenilno luknjico
- Priključek: prirobnični, po EN 1092
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
DN15
(Poz: V 9002.012, V 9002.013)
(Ustreza: END Armaturen MP31 - z luknjico)
DN25
(Poz: V 9002.001, V 9002.004, V 9002.005, V 9002.008, V 9002.010, V 9002.020, V 9002.023)
(Ustreza: END Armaturen MP31 - z luknjico)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 12);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (13, 2, N'A3.3', N'ZAPORNA LOPUTA:
Zaporna loputa, medprirobnična wafer izvedba, primerna za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Loputa mora zagotavljati razred tesnenja A po EN 12266-1. Vključno s spojnim, vijačnim, tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: dvojni offset
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: Ročni polžni pogon
- Material: Jeklena litina, disk nerjavno jeklo
- Tesnila: R-PTFE
DN 150
(Poz: BV 9000.001, BV 9000.002, BV 9000.110, BV 9000.116, BV 9000.140, BV 9000.146, BV 9001.010, BV 9001.013, BV 9001.014, BV 9001.017, BV 9001.030, BV 9001.110, BV 9001.121)
(Ustreza: ABO 2E5 5590B-GB DN150 PN16 z ročnim polžnim pogonom)
DN 300
(Poz: BV 9000.101, BV 9001.001, BV 9001.003, BV 9001.101, BV 9001.102)
(Ustreza: ABO 2E5 5590B-GB DN300 PN16 z ročnim polžnim pogonom)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 13);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (14, 2, N'A3.4', N'NEPOVRATNA LOPUTA:
Nepovratna loputa, za vertikalno vgradnjo brez vzmeti, primerna za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: medprirobnični, EN1092-1, PN16 
- Material: ohišje 1.0460, disk 1.4581
- Tesnilo: EPDM
DN 125
(Poz: CV 9000.113, CV 9000.143, CV 9001.012, CV 9001.016)
(Ustreza: Gestra CB26)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 14);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (15, 2, N'A3.5', N'NEPOVRATNI VENTIL
Nepovratni ventil - kompaktna disk izvedba, z vzmetjo, primerna za 50% etilen-glikolsko mešanico. Temperatura medija 5 do 40 °C, tlak do 8 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: medprirobnični, EN1092-1, PN16 
- Material: 1.4317, disk 1.4571
- Mehko tesnenje, tesnilo EPDM
DN 25
(Poz: CV 9002.003, CV 9002.007, CV 9002.009)
(Ustreza: Gestra RK86)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 15);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (16, 2, N'A3.6', N'LOVILEC NEČISTOČ:
Lovilnik nesnage, primeren za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 4 bar(g). Vključno s spojnim, vijačnim, tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični, EN1092-1, PN16 
- Material: 1.0619+N
- Sito: standardno, nerjavno (1.4301)
DN 15
(Poz: SF 9002.021, SF 9002.024)
(Ustreza: ARI Armaturen, tip 34.050)
DN 150
Z izpustnim (čistilnim) vijakom na čistilnem pokrovu. 
(Poz: SF 9000.111, SF 9000.141)
(Ustreza: ARI Armaturen, tip 34.050)
DN 300
Z izpustnim (čistilnim) vijakom na čistilnem pokrovu. 
(Poz: SF 9001.002)
(Ustreza: ARI Armaturen, tip 34.050)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 16);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (17, 2, N'A3.7', N'VARNOSTNI VENTIL:
Varnostni ventil, razbremenilna funkcija, ustrezen za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. Priložen certifikat testa.
Tehnične karakteristike:
- Priključek: navojni
- Material: nerjavno jeklo
- Tlak odpiranja: 6 bar(g)
- Zaprta izvedba mehanizma
- Vzmetni, prednastavljen.
DN 15 / DN 15
(Poz: SV 9000.121, SV 9000.151)
(Ustreza: ARI TCP - Fig. 57.961 )
DN 25 / DN 25
(Poz: SV 9000.007)
(Ustreza: ARI TCP - Fig. 57.961 )', NULL, 
N'', NULL, NULL, 
NULL, NULL, 17);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (18, 2, N'A3.8', N'MANOMETRSKI VENTIL
Manometrski iglični ventil, navojni priključek: G 1/2". Material: nerjavni (1.4301 ali boljše).
Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Z odprtino za razbremenitev (DIN 16270).  
(Poz: V 9000.008, V 9000.115, V 9000.119, V 9000.132, V 9000.145, V 9000.149, V 9000.162, V 9001.005, V 9001.035, V 9001.104, V 9002.004)
(Ustreza: INOL manom. ventil (inox) DIN16270)
Z odprtino za razbremenitev in testnim priključkom (DIN 16271)
(Poz: V 9000.114, V 9000.144, V 9001.036, V 9001.105)
(Ustreza: INOL manom. ventil (inox) DIN16271)
CEVOVODI', NULL, 
N'', NULL, NULL, 
NULL, NULL, 18);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (19, 2, N'A4.1', N'CEV, NERJAVNA
Cev, varjena, nerjavna - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10217-7,  certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 15 (Ø21,3 x 1,6 mm)
DN 25 (Ø33,7 x 1,6 mm)
DN 32 (Ø42,4 x 1,6 mm)
DN 40 (Ø48,3 x 1,6 mm)
DN 50 (Ø60,3 x 1,6 mm)
DN 80 (Ø88,9 x 2 mm)
DN 100 (Ø114,3 x 2 mm)
DN 125 (Ø139,7 x 2 mm)
DN 150 (Ø168,3 x 2 mm)
DN 300 (Ø323,9 x 3 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 19);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (20, 2, N'A4.2', N'KOLENO 90°, NERJAVNO
Koleno, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 15 (Ø21,3 x 1,6 mm)
DN 25 (Ø33,7 x 1,6 mm)
DN 40 (Ø48,3 x 1,6 mm)
DN 50 (Ø60,3 x 1,6 mm)
DN 150 (Ø168,3 x 2 mm)
DN 300 (Ø323,9 x 3 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 20);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (21, 2, N'A4.3', N'KOLENO 45°, NERJAVNO
Koleno 45°, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 150 (Ø168,3 x 2 mm)
DN 300 (Ø323,9 x 3 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 21);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (22, 2, N'A4.4', N'T-KOS, NERJAVNI
T-kos, nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 25 (Ø33,7 x 1,6 mm)
DN 40 (Ø48,3 x 1,6 mm)
DN 50 (Ø60,3 x 1,6 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 22);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (23, 2, N'A4.5', N'REDUCIRNI T-KOS, NERJAVNI
Reducirni ''T-kos, nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 40/25', NULL, 
N'', NULL, NULL, 
NULL, NULL, 23);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (24, 2, N'A4.6', N'REDUCIRNI KOS, NERJAVNI
Reducirni kos. nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 40/25
DN 125/100
DN 150/100
DN 150/125', NULL, 
N'', NULL, NULL, 
NULL, NULL, 24);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (25, 2, N'A4.7', N'PRIROBNICA, NERJAVNA
Varilna prirobnica z grlom.
- dimenzije po EN 1092-1, tip 11, B1;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim, vijačnim in varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot fiting)
DN 15, PN16
DN 25, PN16
DN 40, PN16
DN 50, PN16
DN 100, PN16
DN 125, PN16
DN 150, PN16
DN 300, PN16', NULL, 
N'', NULL, NULL, 
NULL, NULL, 25);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (26, 2, N'A4.8', N'PRIROBNICA, SLEPA, NERJAVNA
Slepa prirobnica.
- dimenzije po EN 1092-1, tip 05;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim in  vijačnim materialom.
DN 200, PN16
DN 250, PN16', NULL, 
N'', NULL, NULL, 
NULL, NULL, 26);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (27, 2, N'A4.9', N'ODZRAČEVALNA POSODA
Odzračevalni lonec, izdelan iz cevi DN 100, material 1.4301.  Dolžina cca 250mm, z zaključnima kapama po EN 10253-4.
Varilni priključek spodaj DN 32, varilni priključek zgoraj DN 15. Vgradnja na cevovode DN100 do DN350, vključno z izdelavo odcepa na cevovodu in varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cevovod).', NULL, 
N'', NULL, NULL, 
NULL, NULL, 27);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (28, 2, N'A4.10', N'ZBIRNI LIJAK
Izdelava, dobava in montaža nerjavnega zbirnega lijaka odzračevanj. Primeren za glikol in vodo. Dimenzije (d x š x v) cca : 500x150x250, iztok DN50 (varilni priključek). S konzolo za pritrditev na AB steno. Vključno s pomožnim, montažnim in pritrdilnim materialom.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 28);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (29, 2, N'A4.11', N'VICTAULIC SPOJKA
Victaulic spojka, vključno z varilnim adapterjem, ustreznim za povezovanje na nerjavni cevovod. Tesnilo ustrezno za obratovalne temperature -25°C, tlak do 8 bar(g). Dimenzijo kontrolirati glede na priključke na uparjalniku dobavljenega hladilnega agregata.
DN 125 (Ø139,7 x 2 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 29);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (30, 2, N'A4.12', N'TC SPOJKA, končna
Varilna ferula+tesnilo+slepa prirobnica + objemka. Material 1.4301 ali boljši. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 40-Ø48,3x2, A=64 mm
OPREMA CEVOVODOV', NULL, 
N'', NULL, NULL, 
NULL, NULL, 30);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (31, 2, N'A5.1', N'DRSNA PODPORA - predizolirana
Višinsko nastavljivo pomično ležišče za drsne pritrditve cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba s predizolirano objemko cevi. Za delovno temperaturno območje -25 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip D.P.1)
Ustreza: Sikla LK-HV-150, alternativa Hilti.
DN 150', NULL, 
N'', NULL, NULL, 
NULL, NULL, 31);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (32, 2, N'A5.2', N'DRSNA PODPORA Z BOČNIM VODENJEM- predizolirana
Višinsko nastavljivo pomično ležišče za drsne pritrditve cevi  z dodatnim elementom za bočno vodenje v aksialni smeri. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba s predizolirano objemko cevi. Za delovno temperaturno območje -25 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip B.V.1)
Ustreza: Sikla LK-HV-150 + ustrezno bočno vodilo, alternativa Hilti.
DN 150
DN 300', NULL, 
N'', NULL, NULL, 
NULL, NULL, 32);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (33, 2, N'A5.3', N'FIKSNA TOČKA
Višinsko nastavljivo ležišče, z dodatnim elementom za fiksno pritrditev cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje -25 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom. ter izolacijo celotne podpore s fleksibilno elastomerno peno, na osnovi sintetične gume, z zaprto celično strukturo.  Dispozicija in način izvedbe glede na risbe tega načrta (tip F.T.1).
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2 + ustreznen fiksirni element
DN 150', NULL, 
N'', NULL, NULL, 
NULL, NULL, 33);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (34, 2, N'A5.4', N'OBEŠALO
Obešalo cevovodov, sestavljeno iz: predizolirane objemke cevovoda z debelino pene 19mm, plošče za pritrditev, ustrezen povezovalni element (navojna palica ali navojni adapter). Izdelano iz pocinkane pločevine. Za delovno temperaturno območje -25 do 40°C. Primerno za montažo na jekleno podporno konstrukcijo ali v AB ploščo. Vključno z vijačnim in pritrdilnim materialom. Dispozicija in način izvedbe glede na risbe tega načrta (tip O.1).
Ustreza: Sikla GPL + objemka LKS 19 ali ekvivalent Hilti
DN 15
DN 25
DN 40
DN 50', NULL, 
N'', NULL, NULL, 
NULL, NULL, 34);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (35, 2, N'A5.5', N'JEKLENE PODPORNE KONSTRUKCIJE PODPOR CEVOVODOV
Iz pocinkanega materiala, vključuje sistemske modularne nosilce ustreznih dimenzij glede na podpore cevovodov, pripadajoče originalne spojne elemnte, vijačni material, zaključne pokrove in fiksiranje na nosilne konstrukcije na trasi cevovodov. Velikost podporne konstrukcije definirati glede na obtežbo, skladno z vsebino tega načrta. Ocena teže.
Ustreza: Sikla SiMotec 80, Sikla SiConnect 41/41', NULL, 
N'', NULL, NULL, 
NULL, NULL, 35);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (36, 2, N'A5.6', N'TOPLOTNA IZOLACIJA CEVOVODOV IN ARMATUR:
Fleksibilna elastomerna pena, na osnovi sintetične gume, z zaprto celično strukturo. Samougasljiv material ki ne kaplja in ne širi plamenov. Izolacija ustrezna za industrijske aplikacije, izdelana skladno z EN 14304. Primerna za temperaturno območje od -5°C do 20°C. Požarna klasifikacija B-s3,d0 (plošče) oz. Bl-s3, d0 (cevaki) po EN13501-1. CE oznaka. Toplotna prevodnost λ 0° ≤ 0,035 W/mK, koeficient parozapornosti μ ≥ 10,000. Upoštevana je dolžina cevi, dobava in montaža na enoto mora upoštevati dodatek za izolacijo cevnih elementov in armatur.  Vključno z lepilom in pomožnim montažnim materialom. 
Ustreza: Armacell Armaflex ACE Plus - cevaki in plošče + lepilo Armaflex 520.
DN 15 - cevaki, debelina = 19 mm
DN 25 - cevaki, debelina = 19 mm
DN 32 - cevaki, debelina = 19 mm
DN 40 - cevaki, debelina = 25 mm
DN 50 - cevaki, debelina = 32 mm
DN 80 - cevaki, debelina = 32 mm
DN 100 - cevaki, debelina = 40 mm
DN 125 - cevaki, debelina = 40 mm
DN 150 - plošče, debelina = 40 mm
DN 300 - plošče, debelina = 50 mm', NULL, 
N'', NULL, NULL, 
NULL, NULL, 36);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (37, 2, N'A5.7', N'TOPLOTNA IZOLACIJA OPREME
Fleksibilna elastomerna pena, na osnovi sintetične gume, z zaprto celično strukturo. Samougasljiv material ki ne kaplja in ne širi plamenov. Izolacija ustrezna za industrijske aplikacije, izdelana skladno z EN 14304. Primerna za temperaturno območje od -5°C do 20°C. Požarna klasifikacija B-s3,d0 (plošče) po EN13501-1. CE oznaka. Toplotna prevodnost λ 0° ≤ 0,035 W/mK, koeficient parozapornosti μ ≥ 10,000.  Vključno z lepilom in pomožnim montažnim materialom. 
Ustreza: Armacell Armaflex ACE Plus - cevaki in plošče + lepilo Armaflex 520.
Hidravlična kretnica  - plošče - dvoslojno, debelina = 64 mm (32+32 mm), ocena površine: 20 m2
Razdelilnik  - plošče - dvoslojno, debelina = 50 mm (25+25 mm), ocena površine: 5 m2
Razdelilnik  - plošče - dvoslojno, debelina = 50 mm (25+25 mm), ocena površine: 8 m2
Črpalka  - plošče - dvoslojno, debelina = 44 mm (25+19 mm), ocena površine: 2 m2', NULL, 
N'', NULL, NULL, 
NULL, NULL, 37);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (38, 3, N'C1.1', N'HLADILNI STOLP
Serijsko tovarniško izdelan hladilni stolp odprte, protitočne izvedbe s sesalnim prepihavanjem zraka s pomočjo dveh aksialnih ventilatorjev. Elektromotorji ventilatorjev so enostopenjski, za delovanje v omočenem ozračju, primerni za ločen frekvenčni pretvornik.   Dobava: nerazloženo na tovornjaku. Vnos na streho objekta z uporabo avtodvigala, transport in postavljanje na mesto vgradnje (kota +20 m). Niveliranje in fiksiranje  na mestu postavitve, na pripravljeno konstrukcijo, vključno s pritrdilnim materialom.  Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje v sklopu elektro popisa.
STROJNE ZAHTEVE:
- vibracijsko stikalo
- zaščitna mreža na ventilatorjih
- ventilatorji z nižjo stropnjo hrupa
- električni grelci v prostoru elektromotorja
- remote sump (iztok na dnu, za popolno izpraznitev ob zaustavitvi)
ELEKTRO ZAHTEVE:
- elektromotor IE3
- PTC zaščita elektromotorja
- motor ustrezen za ločen frekvenčni pretvornik
Tehnične karakteristike:
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
(Predvidena oprema: EVAPCO AT28-4K21)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 1);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (39, 3, N'C1.2', N'ČRPALKA, centrifugalna
Enostopenjska centrifugalna črpalka, blok izvedba, črpalka in motor monitrana na skupni osnovni okvir, prirobnični priključek. Ohišje in tekač iz sive litine. Primerna za vodo, temperatura medija 20°C do 40 °C, tlak do 8 bar(g). Tesnila ustrezna glede na medij in obratovalne razmere. Primerna za ločen frekvenčni regulator vrtljajev. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Vključno z nosilno konstrukcijo črpalke in komplet montažnim, pritrdilnim in tesnilnim materialom.
Tehnične karakteristike:
Priključek: DN100/80, PN16 (po EN 1092);
H= 25 m;
Q= 80 m3/h;
Pe=  11 kW; 4p, 3x400V
(Poz.: P 9021.20, P 9021.21)
(Ustreza: Grundfos NK 80-250/270
Tehnične karakteristike:
Priključek: DN150/125, PN16 (po EN 1092);
H= 25 m;
Q= 250 m3/h;
Pe=  30 kW; 4p, 3x400V
(Poz.: P 9022.20, P 9020.21)
(Ustreza: Grundfos NK 125-315/317', NULL, 
N'', NULL, NULL, 
NULL, NULL, 2);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (40, 3, N'C1.3', N'ČRPALKA, centrifugalna
Enostopenjska centrifugalna črpalka, inline izvedba, prirobnični priključek. Ohišje in tekač iz sive litine. Primerna za vodo, temperatura medija 20°C do 40 °C, tlak do 8 bar(g). Tesnila ustrezna glede na medij in obratovalne razmere. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Vključno z nosilno konstrukcijo črpalke in komplet montažnim, pritrdilnim in tesnilnim materialom.  
Tehnične karakteristike:
Priključek: DN40, PN16 (po EN 1092);
H= 20 m;
Q= 10 m3/h;
Pe= 1,5 kW; 4p, 3x400V
(Poz.: P 9041.20)
(Ustreza: Grundfos TP 40-270/2)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 3);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (41, 3, N'C1.4', N'VERTIKALNI REZERVOAR 10 m3
Izdelava, dobava in montaža vertikalnega rezervoarja - zalogovnika stolpne vode. Temperatura medija 5 do 40°C.
Transport in postavljanje na mesto vgradnje (montaža v 2N, kota + 13,2m). Niveliranje in fiksiranje rezervoarja na mestu postavitve, vključno s pritrdilnim materialom. Izdelan skladno z direktivo o tlačni opremi (PED).
Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.
Tehnične karakteristike:
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
(Ustreza: Izdelan po merski skici tega načrta)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 4);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (42, 3, N'C1.5', N'PEŠČENI FILTER
Avtomatski peščeni filter za filtriranje stolpne vode v obvodu. Tlačna posoda iz armiranega poliestra, komplet z ocevjem, vsemi potrebnimi loputami, ventili, šobami in polnitvijo z ustreznim filtrskim medijem - antracit + kremenčev pesek. Krmiljenje: standardni lokalni krmilnik (interno nastavljanje časov pranja) – možnost pranja glede na časovni interval, glede na dP ali preko zunanjega signala. V ceno vključena postavitev opreme, polnjenje filtrirnega materiala, izdelava koračnega diagrama, konfiguracija parametrov in spuščanje v pogon. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje v sklopu elektro popisa.
Tehnične karakteristike:
- nominalni pretok 10 m3/h
- statični tlak: 2 bar
- max dp. pri zamašenem filtru: 1,5 bar
- tlak v sistemu do 4 bar(g)
- izpiranje z zunanjo (tehnološko) vodo, tlak 4 bar
- izhodi na CNS: prikaz stanja (obratovanje/pranje, napaka) + zunanje proženje pranja + 2x 4-20 mA (tlak)
(Poz: F 9041.01)
(Ustreza: MAK-CMC INIF H-7 ali ekvivalentno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 5);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (43, 3, N'C1.6', N'SKLOP MEHČALNE NAPRAVE + SOLNIK
Ionska mehčalna naprava za mehčanje vode, z avtomatsko regeneracijo z raztopino natrijevega klorida (soli). Dvojna izvedba - obratovanje brez prekinitve med regeneracijo.Tlačna posoda iz armiranega poliestra, komplet z ocevjem, vsemi potrebnimi ventili in krmilnikom. Vključno z ločenim dnevnim rezervoar slanice. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m,  vnos skozi odprtino 1,8x1,8m).). Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje v sklopu elektro popisa.
Centralni solnik, za pripravo slanice, izdelan iz umetnega materiala PP, z vsemi potrebnimi ojačitvami in priključki za črpalko in merilnike, vključno z ustrezno črpalko za kemikalije, za črpanje slanice - izdelana iz PP. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m,  vnos skozi odprtino 1,8x1,8m).). Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje v sklopu elektro popisa.
Tehnične karakteristike mehčalne naprave:
- nominalni pretok do 30 m3/h
- tlak vstopne vode: 4 bar(g)
- dnevni rezervoar slanice 2,5 m3
Dodatna oprema za dnevni rezervoar slanice:
-pnevmatski zaporni ventil za slanico
-nivojska stikala
PVC material (cevi, fitingi) za povezavo slanik-dnevni rezervoar slanice (cca 20m)
Tehnične karakteristike solnika:
- Volumen: 5 m3
- Dimenzije: premer 1600 x višina 2600 mm 
-Odprtina za vsipni kanal: 600x600
-Priključek za dovod vode DN25
-2x Priključek za obvod vode DN25
-Priključek za črpalko: DN 32
-Priključek za stisnjen zrak: DN15
-Varnostni preliv: DN50
-2x Drenažni čep 3/4"
- Centrifugalna črpalka, predvidena kapaciteta 2m3/h pri 5m:
Dodatna oprema za centralni solnik:
Pnevmatski zaporni ventil za dovod vodovodne vode
Indikator pretoka
Ultrazvočni senzor in transmiter za merjenje nivoja sipke snovi
Radarski senzor nivoja tekočine
Mejna zaščitna stikala (3 kos)
Kolektorska cev za tekočo slanico s sapnicami
PVC material (cevi, fitingi)
(Poz: MN 9040.01 + T 9040.03+ S 9040.02 + P 9040.20)
(Ustreza: Mehčalna naprava MAK-CMC INOM 7D + rezervar slanice + solnik - izdelan po merski skici)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 6);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (44, 3, N'C1.7', N'VZORČNO MESTO ZA NADZOR STOLPNE VODE
Naprava za avtomatski nadzor kvalitete stolpne vode in kontrolo delovanja kondicioniranja s kemičnimi dodatki in nadzor odsoljevanja stolpne vode. RS485 komunikacija (Modbus). Kompaktna verzija za stensko montažo. Vključno z ustreznimi cevnimi fitingi za priklop nerjavne cevi DN15 na PVC priključek 25 mm.
Dobavitelj opreme izvede ožičenje signalov med dozirnimi črpalkami (P 9025.21, P 2025.20) in napravo.
(Poz: VV 9025.01)
(Ustreza: Nalco 3D Trasar CW8206)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 7);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (45, 3, N'C1.8', N'SISTEM ZA DOZIRANJE INHIBITORJA
Postaja za doziranje inhibitorja v stolpno hladilno vodo, sestavljena iz membranske dozirne črpalke, vgrajene na namensko dozirno posodo. Sestoječa iz:
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
(Ustreza: Grundfos DDA 7,5 + dodatki)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 8);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (46, 3, N'C1.9', N'SISTEM ZA DOZIRANJE BIOCIDA
Postaja za doziranje biocida v stolpno hladilno vodo, sestavljena iz membranske dozirne črpalke, vgrajene na namensko dozirno posodo. Sestoječa iz:
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
(Ustreza: Grundfos DDA 7,5 + dodatki)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 9);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (47, 3, N'C1.10', N'LOVILNA SKLEDA - PALETA
Lovilna posoda - paleta, za preprečevanje razlitij kemikalij. Volumen: 80L, dimenzije cca 132 x 66 x 14 cm. Statična obremenitev do 400 kg.
(Ustreza: Npr. SPC SC-SD2 lovilna paleta ali ekvivalent)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 10);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (48, 3, N'C1.11', N'RAZDELILNIK STOLPNE VODE
Izdelava, dobava in montaža zbiralnika/razdelilnika za stolpno vodo. Obratovalna emperatura medija 5 do 40°C. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz nerjavnih cevi ter cevne kape. Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.
Tehnične karakteristike:
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
(Ustreza: Izdelan po merski skici tega načrta)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 11);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (49, 3, N'C1.12', N'RAZDELILNIK/ZBIRALNIK STOLPNE VODE
Izdelava, dobava in montaža zbiralnika/razdelilnika za stolpno vodo. Obratovalna emperatura medija 5 do 40°C. Transport in postavljanje na mesto vgradnje (montaža v 2N, kota 13,2m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz nerjavnih cevi ter cevnih kap. Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.
Tehnične karakteristike:
- DN400 - Ø406,4mm, skupna dolžina cca 3700 mm
- Prirobnični priključki, EN1092-1, tip 11, PN16:
    6x DN200 (Ø219,1mm),
    4x DN250 (Ø273mm),
- Obratovalni tlak:  2 bar(g);
- Maksimalni tlak: 4 bar(g);
- Preizkusni tlak: 6 bar(g) 
- Material: nerjavno jeklo, 1.4301
(Poz:T 9023.01)
(Ustreza: Izdelan po merski skici tega načrta)
MERILNA OPREMA', NULL, 
N'', NULL, NULL, 
NULL, NULL, 12);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (50, 3, N'C2.1', N'VODOMER
Vodomer,  primeren za stolpno  (hladilno) vodo, pulzni izhod. 
Prirobnični procesni priključek, temperatura medija od 5 do 40 °C, tlak do 8 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom.
Tehnične karakteristike:
- Merilno območje: 0,4 do 40  m3/h, nazivni pretok 15 m3/h
- Priključek: prirobnični, EN 1092-1, DN50, PN16
- Izhod:pulz
(Poz: FQI 9020.730, FQI 9040.730, FQI 9040.731)
(Ustreza: ITRON Woltex M + Cyble sensor V2)
Tehnične karakteristike:
- Merilno območje: 1 do 100  m3/h, nazivni pretok 40 m3/h
- Priključek: prirobnični, EN 1092-1, DN80, PN16
- Izhod: pulz
(Poz: FQI 9042.730, FQI 9042.731)
(Ustreza: ITRON Woltex M + Cyble sensor V2)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 13);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (51, 3, N'C2.2', N'MERILNIK TLAKA
Merilnik tlaka, primeren za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Vključno z nerjavno priključno cevko in z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Piezouporovni merilni princip
- Priključek: navojni, G 1/2"
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
Merilno območje: 0 do 10 bar(g)
(Poz: PIC 9020.710, PI 9021.710, PI 9021.711, PI 9022.710, PI 9022.711, PIC 9042.)
(Ustreza: E+H PMP21)
Merilno območje: 0 do 1 bar(g) - hidrostatična meritev nivoja (do 6m)
(Poz: LIC 9020.720)
(Ustreza: E+H PMP21)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 14);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (52, 3, N'C2.3', N'MERILNIK TEMPERATURE
Merilnik temperature, uporovni, 1x Pt100, s priključno glavo na zaščitnem vratu, primeren za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Z integriranim pretvornikom. Vključno z ustrezno nerjavno zaščitno tulko. Dolžina ustrezna za montažo v cev DN100...DN400. Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Merilno območje: -50 do +50 °C
- 1 x Pt100, 3 žilna vezava
- Priključek: navojni, G 1/2"
- Potopna dolžina 100 mm, dolžina zaščitnega vratu 80 mm
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
(Poz: TIC 9020.700, TIC 9021.700, TIC 9021.701, TIC 9022.700, TIC 9022.701, TIC 9023.701, TIC 9023.702)
(Ustreza: E+H TM121)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 15);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (53, 3, N'C2.4', N'NIVOJSKO STIKALO
Nivojsko mejno stikalo - vibracijske vilice, primerno za stolpno vodo. Temperatura medija do 40°C, tlak do 2 bar (g). Vključno s pomožnim, montažnim, tesnilnim in elektro materialom in s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: zunanji navoj G3/4"
- Material: Nerjavno jeklo, 1.4301 ali boljši
- Napajanje: 24 V DC
(Poz: LSLA 9020.721, LSHA 9020.722, LSLLA 9020.723)
(Ustreza: E+H Liquiphant FTL 41)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 16);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (54, 3, N'C2.5', N'MERILNIK PREVODNOSTI
Merilnik prevodnosti, primeren za tehnološko vodo in deževnico. Temperatura medija 5 do 40°C, tlak do 6 bar (g). Vključno s pomožnim, montažnim, tesnilnim in elektro materialom in s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: zunanji navoj G1"
- Merilno območje: 10 - 20000 µS/cm
- Napajanje: 24 V DC
(Poz: QIC 9042.745)
(Ustreza: E+H Liquiphant CLS21E + LiquilineCM442)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 17);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (55, 3, N'C2.6', N'MANOMETER
Lokalni manometer za prikaz tlaka vode. Temperatura medija 5 do 50°C. Vključno z nerjavno priključno cevko z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm
- Polnilo: silikonsko olje
Merilno območje 0 - 4 bar(g)
Radialni priključek
(Poz: PI 9020.910, PI 9020.911, PI 9020.912, PI 9020.913, PI 9020.914, PI 9022.911, PI 9022.912, PI 9022.914, PI 9022.915, PI 9041.910, PI 9041.911, PI 9042.910, PI 9021.911A, PI 9021.911B, PI 9021.912A, PI 9021.912B, PI 9021.914A, PI 9021.914B, PI 9021.915A, PI 9021.915B)
(Ustreza: INOL IM 821 DN100)
Merilno območje 0 - 6 bar(g)
Radialni priključek
(Poz: PI 9021.910, PI 9021.913, PI 9022.910, PI 9022.911)
(Ustreza: INOL IM 821 DN100)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 18);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (56, 3, N'C2.7', N'TERMOMETER
Lokalni direktni termometer za prikaz temperature vode. Industrijski termometer, ki deluje na principu spremembe volumna polnila v tipalu, ki se preko membranske kapsule in mehanizma prenaša na kazalec. Tlak medija do 6 bar(g). Vključno z ustrezno nerjavno zašitno tulko.  Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm
Merilno območje 0 / +60°C
Aksialni priključek
(Poz: TI 9020.900, TI 9022.900, TI 9022.901, TI 9022.902, TI 9022.903, TI 9021.900A, TI 9021.900B, TI 9021.901A, TI 9021.901B, TI 9021.902A, TI 9021.902B, TI 9021.903A, TI 9021.903B)
(Ustreza: INOL TI291 DN100 + tulka)
ARMATURE', NULL, 
N'', NULL, NULL, 
NULL, NULL, 19);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (57, 3, N'C3.1', N'ZAPORNA LOPUTA - MOTORNI POGON - ON/OFF
Zaporna loputa, medprirobnična LUG izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Loputa mora zagotavljati razred tesnenja A po EN 12266-1. Vključno s spojnim, vijačnim, tesnilnim ter elektro materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: Elektromotorni pogon z ON/OFF regulacijo in ustreznim navorom
- Material ohišja: nodularna litina
- Tesnila: EPDM
- Napajanje: 24 VDC
- 2x stikalo končnih leg
- Ohišje zaščita IP67
DN 250
(Poz:  MBV 9023.001, MBV 9023.003, MBV 9023.005, MBV 9023.007)
(Ustreza: Belimo  D6250WL + PRCA-S2-T-250 ali ekvivalent ARI Armaturen ali IMP Armature)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 20);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (58, 3, N'C3.2', N'ZAPORNA LOPUTA - MOTORNI POGON - REGULACIJSKA
Zaporna loputa, medprirobnična wafer izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Loputa mora zagotavljati razred tesnenja A po EN 12266-1. Vključno s spojnim, vijačnim, tesnilnim ter elektro materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: Elektromotorni pogon z zvezno regulacijo in ustreznim navorom
- Material: nodularna litina
- Tesnila: EPDM
- Napajanje: 24 VDC
- Krmilni signal 4-20 mA
- 2x stikalo končnih leg
- Ohišje zaščita IP67
DN 200
(Poz: MBV 9023.009) 
(Ustreza: Belimo  D6250W + PRCA-BAC-S2-T-250 ali ekvivalent ARI Armaturen ali IMP Armature)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 21);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (59, 3, N'C3.3', N'KROGELNI 3-POTNI VENTIL - MOTORNI POGON - ON/OFF
Tripotni krogelni ventil z elektromotornim pogonom, L konfiguracija, prirobnična izvedba.primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim, tesnilnim in elektro materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični, EN1092, PN16
- Material: nerjavno jeklo
- Napajanje: 24 VDC
- 2 končno stikalo
- možnost ročnega pogona
DN50
(Poz: MV 9041.001, MV 9041.011)
(Ustreza: END Armaturen MD31 + pogon NE092100 ali enakovredno', NULL, 
N'', NULL, NULL, 
NULL, NULL, 22);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (60, 3, N'C3.4', N'ELEKTROMOTORNI KROGELNI ZAPORNI VENTIL - PRIROBNIČNI
Dvodelni krogelni ventil, industrijska izvedba, primeren za stolpno vodo. Temperatura medija 0 do 40 °C, tlak do 6 bar(g). Elektromotorni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: dvodelni krogelni ventil,
- Priključek: prirobnični, po EN 1092
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
- Napajanje: 24 VDC
- 2 končno stikalo
- optični indikator položaja
- možnost ročnega pogona
DN80
(Poz: MV 9042.003, MV 9042.014, MV 9042.022, MV 9042.023)
(Ustreza: END Armaturen MP31 + pogon NE092100)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 23);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (61, 3, N'C3.5', N'ELEKTROMAGNETNI ZAPORNI VENTIL
Prehodni zaporni ventil z elektromagnetnim pogonom, 2/2 membranski servo, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g).  Vključno s pomožnim, montažnim, tesnilnim in elektro materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek: navojni
- Material: medenina + EPDM
- Min. tlak: 0,5 bar(g)
- Kvs = 37 m3/h
- Zaščita IP65
- Napajanje: 24V DC
- NC (v primeru izpada el. enegije se ventil zapre)
DN50
(Poz: EV 9020.051)
(Ustreza: Jakša M286 G2 ali enakovredno', NULL, 
N'', NULL, NULL, 
NULL, NULL, 24);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (62, 3, N'C3.6', N'PNEVMATSKI POŠEVNOSEDEŽNI VENTIL
Poševnosedežni ventil s pnevmatskim pogonom, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g).  Vključno s pomožnim, montažnim, tesnilnim in elektro materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek: navojni
- Material: nerjavni,+ PTFE sedež
- Krmilni medij: zrak 6 bar(g)
- Zapiranje proti toku
- NC (v primeru izpada kom. zraka se ventil zapre)
DN50
(Poz: PV 9040.004, PV 9040.008)
(Ustreza:  End Armaturen DGD2D3 ali enakovredno', NULL, 
N'', NULL, NULL, 
NULL, NULL, 25);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (63, 3, N'C3.7', N'KROGELNI ZAPORNI VENTIL - NAVOJNI
Trodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: trodelni krogelni ventil
- Priključek: navojni
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
DN15
(Poz: V 9020.003, V 9020.008, V 9020.013, V 9020.018, V 9020.060, V 9021.006, V 9021.026, V 9022.006, V 9022.026, V 9023.002, V 9023.004, V 9025.001, V 9025.002, V 9025.011, V 9041.006)
(Ustreza: END Armaturen ZE31 ali enakovredno)
DN15 s ključavnico
(Poz: V 9021.014A, V 9021.014B, V 9021.034A, V 9021.034B, V 9022.014, V 9022.034)
(Ustreza: END Armaturen ZE31 + ključavnica ali enakovredno)
DN20
(Poz: V 9021.008, V 9021.028)
(Ustreza: END Armaturen ZE31 ali enakovredno)
DN25
(Poz: V 9021.003, V 9021.023, V 9022.003, V 9022.023)
(Ustreza: END Armaturen ZE ali enakovredno)
DN32
(Poz: V 9021.011A, V 9021.011B, V 9021.016A, V 9021.016A, V 9021.016B, V 9021.031A , V 9021.031B, V 9021.036B, V 9022.011, V 9022.016, V 9022.031, V 9022.036)
(Ustreza: END Armaturen ZE31+ključavnica ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 26);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (64, 3, N'C3.8', N'KROGELNI ZAPORNI VENTIL - PRIROBNIČNI
Dvodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: dvodelni krogelni ventil
- Priključek: prirobnični, po EN 1092
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
DN50
(Poz: V 9020.040, V 9020.041, V 9020.042, V 9020.043, V 9020.050 )
(Ustreza: END Armaturen MP31 ali enakovredno)
DN80
(Poz: V 9040.001, V 9042.001, V 9042.004, V 9042.011, V 9042.015, V 9042.021)
(Ustreza: END Armaturen MP ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 27);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (65, 3, N'C3.9', N'KROGELNI ZAPORNI VENTIL - VARILNI
Trodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 0 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: trodelni krogelni ventil
- Priključek: varilni
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
DN25
(Poz: V 9042.024)
(Ustreza: END Armaturen ZE31)
DN50
(Poz: V 9020.053, V 9040.002, V 9040.006, V 9040.010, V 9040.011, V 9041.004, V 9041.008, V 9041.010, V 9042.020)
(Ustreza: END Armaturen ZE31)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 28);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (66, 3, N'C3.10', N'ZAPORNA LOPUTA - ROČNA
Zaporna loputa, medprirobnična WAFER izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s spojnim, vijačnim in tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: ročni pogon z ročico do vključno DN100,
               ročni polžni pogon nad DN100
- Material ohišja: nodularna litina
- Tesnila: EPDM
DN80
(Poz: BV 9021.010A, BV 9021.010B, BV 9021.017A, BV 9021.017B, BV 9021.030A, BV 9021.030B, BV 9021.037A, BV 9021.037B) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)
DN125
(Poz: BV 9021.002, BV 9021.022) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)
DN200
(Poz: BV 9020.001, BV 9020.006, BV 9020.011, BV 9020.016, BV 9022.002, BV 9022.010, BV 9022.017, BV 9022.022, BV 9022.030, BV 9022.037) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 29);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (67, 3, N'C3.11', N'ZAPORNA LOPUTA - ROČNA
Zaporna loputa, medprirobnična LUG izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s spojnim, vijačnim in tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: ročni pogon z ročico do vključno DN100,
               ročni polžni pogon nad DN100
- Material ohišja: nodularna litina
- Tesnila: EPDM
DN200
(Poz: BV 9020.021, BV 9020.026, BV 9021.058, BV 9022.058) 
(Ustreza: IMP Armature tip Art. 126- ali enakovredno ARI Armaturen tip Gesa)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 30);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (68, 3, N'C3.12', N'NEPOVRATNA LOPUTA:
Nepovratna loputa, za vertikalno vgradnjo brez vzmeti, primerna za vodo. Temperatura medija 0 do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: medprirobnični, EN1092-1, PN16 
- Material: ohišje 1.0460, disk 1.4581
- Tesnilo: EPDM
DN 125
(Poz: CV 9021.001, CV 9021.021)
(Ustreza: Gestra CB26 ali enakovredno)
DN 125
(Poz: CV 9022.001, CV 9022.021)
(Ustreza: Gestra CB26 ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 31);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (69, 3, N'C3.13', N'NEPOVRATNI VENTIL
Nepovratni ventil - kompaktna disk izvedba, z vzmetjo, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: medprirobnični, EN1092-1, PN16 
- Material: Nerjeveče jeklo - 1.4301 ali boljše
- Mehko tesnenje, tesnilo EPDM
DN 50
(Poz: CV 9040.003, CV 9040.007, CV 9040.011)
(Ustreza: Gestra RK86 ali End Armaturen ZR ali ekvivalent)
DN 80
(Poz: CV 9040.001, CV 9042.002, CV 9042.012)
(Ustreza: Gestra RK86 ali End Armaturen ZR ali ekvivalent)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 32);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (70, 3, N'C3.14', N'NEPOVRATNI VENTIL
Nepovratni ventil - kompaktna disk izvedba, z vzmetjo, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: navojni
- Material: Nerjeveče jeklo - 1.4301 ali boljše
- Mehko tesnenje, tesnilo PTFE
DN 15
(Poz: CV 9021.007, CV 9021.027, CV 9022.007, CV 9022.027)
(Ustreza: End Armaturen EB31 ali ekvivalent)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 33);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (71, 3, N'C3.15', N'DUŠILNI VENTIL
Dušilni ventil za hidravlično uravnoteženje, primeren za stolpno vodo. Poševnosedežna izvedba, z regulacijskim stožcem. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: navojni
- Mehko tesnenje, tesnilo PTFE
DN 15
(Poz: RV 9025.010)
(Ustreza: AE311062/L-RK  ali ekvivalent)
DN 50
(Poz: RV 9020.052, RV 9040.005, RV 9040.009)
(Ustreza: AE311067/L-RK  ali ekvivalent)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 34);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (72, 3, N'C3.16', N'LOVILEC NEČISTOČ
Lovilnik nesnage, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g). NULL z izpustnim čepom in izpustnim ventilom 1/2". Vključno s spojnim, vijačnim, tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični, EN1092-1, PN16 
- Material: siva litina (EN-GJL-250)
- Sito: standardno, nerjavno (1.4301)
DN 50
(Poz: SF 9041.005)
(Ustreza: IMP Armature Art. 020)
DN 200
(Poz: SF 9020.002, SF 9020.007, SF 9020.012, SF 9020.017)
(Ustreza: IMP Armature Art. 020)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 35);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (73, 3, N'C3.17', N'VARNOSTNI VENTIL:
Varnostni ventil, razbremenilna funkcija, ustrezen za stolpno vodo. Temperatura medija  do 40 °C. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. Priložen certifikat testa.
Tehnične karakteristike:
- Priključek: navojni
- Material: nerjavno jeklo
- Tlak odpiranja: 8 bar(g)
- Zaprta izvedba mehanizma
- Vzmetni, prednastavljen.
DN 15 / DN 15
(Poz: SV 9021.015A, SV 9021.015B, SV 9021.035A, SV 9021.035B, SV 9022.015, SV 9022.035)
(Ustreza: End Armaturen SV320023/L )', NULL, 
N'', NULL, NULL, 
NULL, NULL, 36);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (74, 3, N'C3.18', N'AVTOMATSKI ODZRAČEVALNI LONČEK
Avtomatski odzračevalni lonček s plovcem, industrijska izvedba, primeren za hladilno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek vstop: notranji navoj, G 3/4" 
- Priključek izstop: zunanji navoj, G 1/2" 
- Material: nerjaveče jeklo
(Poz: AO 9021.009, AO 9021.029)
(Ustreza: Mankenberg EB 1.32 ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 37);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (75, 3, N'C3.19', N'MANOMETRSKI VENTIL
Manometrski iglični ventil, navojni priključek: G 1/2". Material: nerjavni (1.4301 ali boljše).
Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Z odprtino za razbremenitev (DIN 16270).  
(Poz: V 9020.004, V 9020.009, V 9020.014, V 9020.019, V 9020.045, V 9021.005, V 9021.012A, V 9021.012B, V 9021.013A, V 9021.013B, V 9021.025, V 9021.032A, V 9021.032B, V 9021.033A, V 9021.033B, V 9022.005, V 9022.012, V 9022.013, V 9022.025, V 9022.032, V 9022.033, V 9041.007, V 9041.009, V 9042.013, V 9042.016)
(Ustreza: INOL manom. ventil (inox) DIN16270)
Z odprtino za razbremenitev in testnim priključkom (DIN 16271)
(Poz: V 9020.044, V 9021.004, V 9021.024, V 9022.004, V 9022.024)
(Ustreza: INOL manom. ventil (inox) DIN16271)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 38);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (76, 3, N'C3.20', N'KOMPENZATOR
Prirobnični gumi kompenzator, primeren za hladilno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični, po EN 1092
- Material prirobnic: pocinkano ali ponikljano jeklo
- Material meha: EPDM
DN 100
(Poz: K 9020.005, K 9020.010)
(Ustreza: Giaflex EGK ali End Armaturen KP54 ali enakovredno)
DN 150
(Poz: K 9020.015, K 9020.020)
(Ustreza: Giaflex EGK ali End Armaturen KP54 ali enakovredno)
CEVOVODI', NULL, 
N'', NULL, NULL, 
NULL, NULL, 39);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (77, 3, N'C4.1', N'CEV, NERJAVNA
Cev, varjena, nerjavna - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10217-7,  certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 15 (Ø21,3 x 1,6 mm)
DN 25 (Ø33,7 x 1,6 mm)
DN 32 (Ø42,4 x 1,6 mm)
DN 50 (Ø60,3 x 1,6 mm)
DN 80 (Ø88,9 x 2 mm)
DN 100 (Ø114,3 x 2 mm)
DN 125 (Ø139,7 x 2 mm)
DN 200 (Ø219,1 x 2,6 mm)
DN 250 (Ø273,0 x 2,6 mm)
DN 350 (Ø355,6 x 3 mm)
DN 400 (Ø406,4 x 3 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 40);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (78, 3, N'C4.2', N'KOLENO 90°, NERJAVNO
Koleno, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 15 (Ø21,3 x 1,6 mm)
DN 25 (Ø33,7 x 1,6 mm)
DN 50 (Ø60,3 x 1,6 mm)
DN 80 (Ø88,9 x 2 mm)
DN 100 (Ø114,3 x 2 mm)
DN 125 (Ø139,7 x 2 mm)
DN 200 (Ø219,1 x 2,6 mm)
DN 250 (Ø273,0 x 2,6 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 41);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (79, 3, N'C4.3', N'KOLENO 90°, NERJAVNO
Koleno, tip 2D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 350 (Ø355,6 x 3 mm)
DN 400 (Ø406,4 x 3 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 42);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (80, 3, N'C4.4', N'KOLENO 45°, NERJAVNO
Koleno, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 100 (Ø114,3 x 2 mm)
DN 200 (Ø219,1 x 2,6 mm)
DN 250 (Ø273,0 x 2,6 mm)
DN 400 (Ø406,4 x 3 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 43);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (81, 3, N'C4.5', N'T-KOS, NERJAVNI
T-kos, nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 15 (Ø21,3 x 1,6 mm)
DN 50 (Ø60,3 x 1,6 mm)
DN 80 (Ø88,9 x 2 mm)
DN 100 (Ø114,3 x 2 mm)
DN 125 (Ø139,7 x 2 mm)
DN 250 (Ø273,0 x 2,6 mm)
DN 400 (Ø406,4 x 3 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 44);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (82, 3, N'C4.6', N'REDUCIRNI T-KOS, NERJAVNI
Reducirni T-kos, nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 80/50,
DN 100/50,
DN 200/125
DN 250/150', NULL, 
N'', NULL, NULL, 
NULL, NULL, 45);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (83, 3, N'C4.7', N'REDUCIRNI KOS, NERJAVNI
Reducirni kos. nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 20/15
DN 50/40
DN 80/50
DN 125/80
DN 200/100
DN 200/125
DN 200/150
DN 250/200', NULL, 
N'', NULL, NULL, 
NULL, NULL, 46);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (84, 3, N'C4.8', N'PRIROBNICA, NERJAVNA
Varilna prirobnica z grlom.
- dimenzije po EN 1092-1, tip 11, B1;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim, vijačnim in varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot fiting)
DN 40, PN16
DN 50, PN16
DN 80, PN16
DN 100, PN16
DN 125, PN16
DN 150, PN16
DN 200, PN16
DN 250, PN16
DN 350, PN16
DN 400, PN16', NULL, 
N'', NULL, NULL, 
NULL, NULL, 47);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (85, 3, N'C4.9', N'PRIROBNICA, SLEPA, NERJAVNA
Slepa prirobnica
- dimenzije po EN 1092-1, tip 05;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim in  vijačnim materialom
DN 200, PN16
DN 250, PN16
DN 400, PN16', NULL, 
N'', NULL, NULL, 
NULL, NULL, 48);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (86, 3, N'C4.10', N'GIBKA CEV
Gibka cev, primerna za vodo, obratovalna temperatura 5 do 30 °C, tlak do 6 bar(g). Prirobnični priključki po EN 1092-1.
Dolžino in priključke preveriti in prilagoditi glede na dobavljeno mehčalno napravo.
DN80, dolžina cca 1500 mm', NULL, 
N'', NULL, NULL, 
NULL, NULL, 49);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (87, 3, N'C4.11', N'VICTAULIC SPOJKA
Victaulic spojka, vključno z varilnim adapterjem, ustreznim za povezovanje na nerjavni cevovod. Tesnilo ustrezno za obratovalne temperature 20 do 40 °C, tlak do 8 bar(g). Dimenzijo kontrolirati glede na priključke na uparjalniku dobavljenega hladilnega agregata.
DN 80 (Ø88,9 x 2 mm)
DN 250 (Ø273,0 x 2,6 mm)
HDPE CEVOVODI', NULL, 
N'', NULL, NULL, 
NULL, NULL, 50);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (88, 3, N'C5.1', N'CEV, PE100
Polietilenska cev, material PE100, SDR11, primerna za tehnološko vodo in deževnico.
Ø50mm SDR11
Ø90mm SDR11', NULL, 
N'', NULL, NULL, 
NULL, NULL, 51);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (89, 3, N'C5.2', N'PP PRIROBNICA
Prirobnica, dimenzije po EN1092, material PP - za spajanje s polietilensko cevjo.
Ø90mm SDR11, DN80, PN10/16', NULL, 
N'', NULL, NULL, 
NULL, NULL, 52);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (90, 3, N'C5.3', N'IZDELAVA ODCEPA
Izdelava odcepa na obstoječem PE cevovodu tehnološke vode (PTV11) (v kineti), z uporabo navrtalnega sedla
odcep - Ø90mm SDR11', NULL, 
N'', NULL, NULL, 
NULL, NULL, 53);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (91, 3, N'C5.4', N'CEVNA UVODNICA
Cevna uvodnica, za prehod PE100 cevi skozi AB steno v kleti. Vključno s sanacijo hidroizolacije.
Debelina stene: 300 mm
Ø90mm SDR11
OPREMA CEVOVODOV', NULL, 
N'', NULL, NULL, 
NULL, NULL, 54);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (92, 3, N'C6.1', N'DRSNA PODPORA
Višinsko nastavljivo (90-110mm) pomično ležišče za drsne pritrditve cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje 5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip D.P.1)
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2
DN 125
DN 200
DN 250', NULL, 
N'', NULL, NULL, 
NULL, NULL, 55);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (93, 3, N'C6.2', N'DRSNA PODPORA Z BOČNIM VODENJEM
Višinsko nastavljivo (90-110mm)  pomično ležišče za drsne pritrditve cevi  z dodatnim elementom za bočno vodenje v aksialni smeri. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje 5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip B.V.1)
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2 + ustrezno bočno vodilo
DN 125
DN 200
DN 250', NULL, 
N'', NULL, NULL, 
NULL, NULL, 56);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (94, 3, N'C6.3', N'FIKSNA TOČKA
Višinsko nastavljivo (90-110mm) ležišče, z dodatnim elementom za fiksno pritrditev cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje 5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom. Dispozicija in način izvedbe glede na risbe tega načrta (tip F.T.1).
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2 + ustreznen fiksirni element
DN 125
DN 200
DN 250', NULL, 
N'', NULL, NULL, 
NULL, NULL, 57);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (95, 3, N'C6.4', N'FIKSNA TOČKA
Fiksna točka, izdelana po meri, za fiksiranje vertikalnega cevovoda na talno AB ploščo (preboj).
2x streme + podporne konzole. Nerjavna izvedba (1.4301). Vključno z vijačnim in pritrdilnim materialom.
DN 400', NULL, 
N'', NULL, NULL, 
NULL, NULL, 58);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (96, 3, N'C6.5', N'OBEŠALO
Obešalo cevovodov, sestavljeno iz: objemke cevovoda s profilirano gumo, plošče za pritrditev, ustrezen povezovalni element (navojna palica ali navojni adapter). Izdelano iz pocinkane pločevine. Za delovno temperaturno območje 0 do 40°C. Primerno za montažo na jekleno podporno konstrukcijo ali v AB ploščo. Vključno z vijačnim in pritrdilnim materialom. Dispozicija in način izvedbe glede na risbe tega načrta (tip O.1).
Ustreza: Sikla GPL + objemka Stabil D-3G m.E ali ekvivalent Hilti
DN 15
DN 25
DN 50
DN 80
DN 100
DN 125
DN 200
DN 250
DN 400', NULL, 
N'kg', NULL, NULL, 
NULL, NULL, 59);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (97, 3, N'C6.6', N'JEKLENE PODPORNE KONSTRUKCIJE PODPOR CEVOVODOV
Iz pocinkanega materiala, vključuje sistemske modularne nosilce ustreznih dimenzij glede na podpore cevovodov, pripadajoče originalne spojne elemnte, vijačni material, zaključne pokrove in fiksiranje na nosilne konstrukcije na trasi cevovodov. Velikost podporne konstrukcije definirati glede na obtežbo, skladno z vsebino tega načrta. Ocena teže.
Ustreza: Sikla SiMotec 100, Sikla SiMotec 80, Sikla SiConnect 41/41 ali ekvivalent Hilti', 1200, 
N'', NULL, NULL, 
NULL, NULL, 60);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (98, 4, N'D1.1', N'HLADILNI STOLP
Serijsko tovarniško izdelan hladilni stolp odprte, protitočne izvedbe s sesalnim prepihavanjem zraka s pomočjo dveh aksialnih ventilatorjev. Elektromotorji ventilatorjev so enostopenjski, za delovanje v omočenem ozračju, primerni za ločen frekvenčni pretvornik.   Dobava: nerazloženo na tovornjaku. Vnos na streho objekta z uporabo avtodvigala, transport in postavljanje na mesto vgradnje (kota +20 m). Niveliranje in fiksiranje  na mestu postavitve, na pripravljeno konstrukcijo, vključno s pritrdilnim materialom.  Vključno z drobnim montažnim, tesnilnim in elektro materialom. Priklop na električno omrežje v sklopu elektro popisa.
STROJNE ZAHTEVE:
- vibracijsko stikalo
- zaščitna mreža na ventilatorjih
- ventilatorji z nižjo stropnjo hrupa
- električni grelci v prostoru elektromotorja
- remote sump (iztok na dnu, za popolno izpraznitev ob zaustavitvi)
ELEKTRO ZAHTEVE:
- elektromotor IE3
- PTC zaščita elektromotorja
- motor ustrezen za ločen frekvenčni pretvornik
Tehnične karakteristike:
Tehnične karakteristike se navaja pri naslednjih pogojih:
  -temperatura vlažnega termometra vstopnega zraka: 16 °C    
  -temperaturni režim hlajene vode: 20/30 °C  
 - hladilna moč : 4,3 MW  
- Okvirne dimenzije (DxŠxV): 3650 x 7400 x 5050 mm 
- Okvirna teža: 8200 kg, najtežji posamezni del 3000 kg, obratovalna teža 10550 kg
(Poz.: HS 9030.05)
(Predvidena oprema: EVAPCO AT212-4N24)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 1);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (99, 4, N'D1.2', N'ČRPALKA, centrifugalna
Enostopenjska centrifugalna črpalka, blok izvedba, črpalka in motor monitrana na skupni osnovni okvir, prirobnični priključek. Ohišje in tekač iz sive litine. Primerna za vodo, temperatura medija 20°C do 40 °C, tlak do 6 bar(g). Tesnila ustrezna glede na medij in obratovalne razmere. Primerna za ločen frekvenčni regulator vrtljajev. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Vključno z nosilno konstrukcijo črpalke in komplet montažnim, pritrdilnim in tesnilnim materialom.
Tehnične karakteristike:
Priključek: DN100/80, PN16 (po EN 1092);
H= 52 m;
Q= 240 m3/h;
Pe=  55 kW; 4p, 3x400V
(Poz.: P 9030.20, P 9030.21, P 9030.22)
(Ustreza: Grundfos NK 125-400/392', NULL, 
N'', NULL, NULL, 
NULL, NULL, 2);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (100, 4, N'D1.3', N'VZORČNO MESTO ZA NADZOR STOLPNE VODE
Naprava za avtomatski nadzor kvalitete stolpne vode in kontrolo delovanja kondicioniranja s kemičnimi dodatki in nadzor odsoljevanja stolpne vode. RS485 komunikacija (Modbus). Kompaktna verzija za stensko montažo. Vključno z ustreznimi cevnimi fitingi za priklop nerjavne cevi DN15 na PVC priključek 25 mm.
Dobavitelj opreme izvede ožičenje signalov med dozirnimi črpalkami (P 9032.21, P 2032.20) in napravo.
(Poz: VV 9032.01)
(Ustreza: Nalco 3D Trasar CW8206)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 3);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (101, 4, N'D1.4', N'SISTEM ZA DOZIRANJE INHIBITORJA
Postaja za doziranje inhibitorja v stolpno hladilno vodo, sestavljena iz membranske dozirne črpalke, vgrajene na namensko dozirno posodo. Sestoječa iz:
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
(Ustreza: Grundfos DDA 7,5 + dodatki)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 4);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (102, 4, N'D1.5', N'SISTEM ZA DOZIRANJE BIOCIDA
Postaja za doziranje biocida v stolpno hladilno vodo, sestavljena iz membranske dozirne črpalke, vgrajene na namensko dozirno posodo. Sestoječa iz:
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
(Ustreza: Grundfos DDA 7,5 + dodatki)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 5);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (103, 4, N'D1.6', N'LOVILNA SKLEDA - PALETA
Lovilna posoda - paleta, za preprečevanje razlitij kemikalij. Volumen: 80L, dimenzije cca 132 x 66 x 14 cm. Statična obremenitev do 400 kg.
(Ustreza: Npr. SPC SC-SD2 lovilna paleta ali ekvivalent)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 6);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (104, 4, N'D1.7', N'RAZDELILNIK STOLPNE VODE
Izdelava, dobava in montaža zbiralnika/razdelilnika za stolpno vodo. Obratovalna emperatura medija 5 do 40°C. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz nerjavnih cevi ter cevne kape. Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.
Tehnične karakteristike:
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
(Ustreza: Izdelan po merski skici tega načrta)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 7);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (105, 4, N'D1.8', N'RAZDELILNIK/ZBIRALNIK STOLPNE VODE
Izdelava, dobava in montaža zbiralnika/razdelilnika za stolpno vodo. Obratovalna emperatura medija 5 do 40°C. Transport in postavljanje na mesto vgradnje (montaža v kleti, kota - 4m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz nerjavnih cevi ter 2x cevih kap. Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.
Tehnične karakteristike:
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
(Ustreza: Izdelan po merski skici tega načrta)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 8);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (106, 4, N'D1.9', N'ZBIRALNIK STOLPNE VODE
Izdelava, dobava in montaža zbiralnika/razdelilnika za stolpno vodo. Obratovalna emperatura medija 5 do 40°C. Vnos na streho objekta  in postavljanje na mesto vgradnje (kota +20 m). Izdelan skladno z direktivo o tlačni opremi (PED). Izdelan iz nerjavnih cevi ter 2x cevih kap. Komplet z izdelavo delavniškega načrta, trdnostnega izračuna z določitvijo debeline sten in izdelavo varilskih in konstrukcijskih detajlov. Vključno z atesti in certifikati ( 3.1-EN 10204, ...) vseh materialov in varilcev, izvedba tlačnega oz. tesnostnega preizkusa in zapisnika, ter z vsem montažnim, pritrdilnim, vijačnim, ter tesnilnim materialom.
Tehnične karakteristike:
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
(Ustreza: Izdelan po merski skici tega načrta)
MERILNA OPREMA', NULL, 
N'', NULL, NULL, 
NULL, NULL, 9);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (107, 4, N'D2.1', N'MERILNIK PRETOKA
Elektromagnetni merilnik pretoka, primeren za vodo. 
Prirobnični procesni priključek, temperatura medija od 5 do 40 °C, tlak do 8 bar(g). Priključki iz ogljikovega jekla, PFA obloga. Vključno s pomožnim, montažnim in tesnilnim materialom.
Tehnične karakteristike:
- Merilno območje: 10 do 150  m3/h, nazivni pretok 120 m3/h
- Priključek: prirobnični, EN 1092-1, DN125, PN16
- Napajanje: 24 V DC
- Izhod: 4 - 20 mA
(Poz: FI 9030.732)
(Ustreza: E+H Promag P 300)
Tehnične karakteristike:
- Merilno območje: 20 do 300  m3/h, nazivni pretok 260 m3/h
- Priključek: prirobnični, EN 1092-1, DN200, PN16
- Napajanje: 24 V DC
- Izhod: 4 - 20 mA
(Poz: FI 9030.732)
(Ustreza: E+H Promag P 300)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 10);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (108, 4, N'D2.2', N'VODOMER
Vodomer,  primeren za stolpno  (hladilno) vodo, pulzni izhod. 
Prirobnični procesni priključek, temperatura medija od 5 do 40 °C, tlak do 8 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom.
Tehnične karakteristike:
- Merilno območje: 0,4 do 40  m3/h, nazivni pretok 15 m3/h
- Priključek: prirobnični, EN 1092-1, DN50, PN16
- Izhod:pulz
(Poz: FQI 9030.730)
(Ustreza: ITRON Woltex M + Cyble sensor V2)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 11);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (109, 4, N'D2.3', N'PRETOČNO STIKALO
Pretočno stikalo z lopatico, za varovanje kompresorja, primerno za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Primerno za vgradnjo v cev DN65. Vključno z izdelavo odcepa DN25 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo.
Tehnične karakteristike:
- Nastavljivo območje (cca 7,5 m3/h na cevi DN65)
- Priključek: navojni, G 1"
- Material: Medenina
- Napajanje: 24 - 250 V AC
(Poz: FSAL 9031.730)
(Ustreza: Kobold FPS-2100 P)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 12);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (110, 4, N'D2.4', N'MERILNIK TLAKA
Merilnik tlaka, primeren za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Vključno z nerjavno priključno cevko in z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Piezouporovni merilni princip
- Priključek: navojni, G 1/2"
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
Merilno območje: 0 do 10 bar(g)
(Poz: PIC 9030.710)
(Ustreza: E+H PMP21)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 13);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (111, 4, N'D2.5', N'MERILNIK TEMPERATURE
Merilnik temperature, uporovni, 1x Pt100, s priključno glavo na zaščitnem vratu, primeren za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Z integriranim pretvornikom. Vključno z ustrezno nerjavno zaščitno tulko. Dolžina ustrezna za montažo v cev DN100...DN400. Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Merilno območje: -50 do +50 °C
- 1 x Pt100, 3 žilna vezava
- Priključek: navojni, G 1/2"
- Potopna dolžina 100 mm, dolžina zaščitnega vratu 80 mm
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
(Poz: TI 9030.700, TI 9030.701, TI 9030.702, TI 9030.703, TI 9030.704)
(Ustreza: E+H TM121)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 14);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (112, 4, N'D2.6', N'MERILNIK NIVOJA
Radarski merilnik nivoja (gladina vode), primeren za vgradnjo v bazen stolpne vode. Obratovalna temperatura 5 do 40 °C. Vključno z izdelavo nosilne konstrukcije za montažo na betonsko steno ali strop bazena ter s pomožnim, montažnim, elektro in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Radarski (80 GHz) merilni princip
- Priključek: navojni, G 1-1/2"
- Material: Nerjavno jeklo
- Napajanje: 24V DC
- Izhod: 4-20 mA
Merilno območje: 0 do 4000 mm
(Poz: LIC 9030.720)
(Ustreza: E+H Micropilot FMR60B)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 15);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (113, 4, N'D2.7', N'MANOMETER
Lokalni manometer za prikaz tlaka vode. Temperatura medija 5 do 40°C. Vključno z nerjavno priključno cevko z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm
- Polnilo: silikonsko olje
Merilno območje 0 - 6 bar(g)
Radialni priključek
(Poz: PI 9030.910, PI 9031.910, PI 9031.911, PI 9031.912, PI 9031.913)
(Ustreza: INOL 821 DN100)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 16);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (114, 4, N'D2.8', N'TERMOMETER
Lokalni direktni termometer za prikaz temperature vode. Industrijski termometer, ki deluje na principu spremembe volumna polnila v tipalu, ki se preko membranske kapsule in mehanizma prenaša na kazalec. Tlak medija do 6 bar(g). Vključno z ustrezno nerjavno zašitno tulko.  Vključno z izdelavo odcepa DN15 za procesni priključek na nerjavnem cevovodu ter s pomožnim, montažnim in tesnilnim materialom in s funkcionalno montažo. 
Tehnične karakteristike:
- Priključek: G 1/2" 
- Material: 1.4301 ali boljše
- Premer ohišja 100 mm
Merilno območje 0 / +60°C
Aksialni priključek
(Poz: TI 9030.900, TI 9031.900, TI 9031.901, TI 9031.902, TI 9031.903)
(Ustreza: INOL TI291 DN100 + tulka)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 17);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (115, 4, N'D2.9', N'NIVOJSKO STIKALO
Nivojsko stikalo, tripalična sonda z navojnim priključkom 1 1/2", z integrirani, stikalom. Z nosilcem za pritrditev v steno. Vključno z izdelavo nosilca in z vsem drobnim montažnim, tesnilnim, spojnim in elektro materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek: G 1 1/2" 
- 3x sonda, material 316L
- Dolžina sond: 3500 mm
(Poz: LSLA 9030.721 + LSHA 9030.722)
(Ustreza: E+H Liquipoint FTW31 + FEW54)
ARMATURE', NULL, 
N'', NULL, NULL, 
NULL, NULL, 18);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (116, 4, N'D3.1', N'ZAPORNA LOPUTA - MOTORNI POGON - ON/OFF
Zaporna loputa, medprirobnična LUG izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Loputa mora zagotavljati razred tesnenja A po EN 12266-1. Vključno s spojnim, vijačnim, tesnilnim ter elektro materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: Elektromotorni pogon z ON/OFF regulacijo in ustreznim navorom
- Material ohišja: nodularna litina
- Tesnila: EPDM
- Napajanje: 24 VDC
- 2x stikalo končnih leg
- Ohišje zaščita IP67
DN 250
(Poz:  MBV 9030.110, MBV 9030.111)
(Ustreza: Belimo  D6250WL + PRCA-S2-T-250 ali ekvivalent ARI Armaturen ali IMP Armature)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 19);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (117, 4, N'D3.2', N'ZAPORNA LOPUTA - MOTORNI POGON - REGULACIJSKA
Zaporna loputa, medprirobnična wafer izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Loputa mora zagotavljati razred tesnenja A po EN 12266-1. Vključno s spojnim, vijačnim, tesnilnim ter elektro materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: Elektromotorni pogon z zvezno regulacijo in ustreznim navorom
- Material: nodularna litina
- Tesnila: EPDM
- Napajanje: 24 VDC
- Krmilni signal 4-20 mA
- 2x stikalo končnih leg
- Ohišje zaščita IP67
DN 200
(Poz: MBV 9030.070) 
(Ustreza: Belimo  D6250W + PRCA-BAC-S2-T-250 ali ekvivalent ARI Armaturen ali IMP Armature)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 20);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (118, 4, N'D3.3', N'KROGELNI VENTIL - MOTORNI POGON - ON/OFF
Krogelni ventil z elektromotornim pogonom, prirobnična izvedba. Primeren za stolpno vodo. Temperatura medija 5 do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim, tesnilnim in elektro materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Pogon: Elektromotorni pogon z ON/OFF regulacijo in ustreznim navorom
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
- Napajanje: 24V DC
- 2x stikalo končnih leg
DN20
- Priključek: Varilni, DN20
(Poz: MV 9031.023)
(Ustreza: END Armaturen MP31 + pogon NE032100 ali enakovredno)
DN65
- Priključek: prirobnični, DN65,  EN1092, PN16
(Poz: MV 9031.007)
(Ustreza: END Armaturen MP31 + pogon NE092100 ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 21);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (119, 4, N'D3.4', N'ELEKTROMAGNETNI ZAPORNI VENTIL
Prehodni zaporni ventil z elektromagnetnim pogonom, 2/2 membranski servo, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g).  Vključno s pomožnim, montažnim, tesnilnim in elektro materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek: navojni
- Material: medenina + EPDM
- Min. tlak: 0,5 bar(g)
- Kvs = 37 m3/h
- Zaščita IP65
- Napajanje: 24V DC
- NC (v primeru izpada el. enegije se ventil zapre)
DN50
(Poz: EV 9030.062)
(Ustreza: Jakša M286 G2 ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 22);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (120, 4, N'D3.5', N'KROGELNI ZAPORNI VENTIL - NAVOJNI
Trodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: trodelni krogelni ventil
- Priključek: navojni
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
DN15
(Poz: V 9030.004, V 9030.010, V 9030.016, V 9030.045, V 9030.047, V 9030.048, V 9030.060, V 9030.065, V 9030.112, V 9030.113, V 9031.001, V 9031.010, V 9031.021, V 9031.123)
(Ustreza: END Armaturen ZE31 ali enakovredno)
DN15 s ključavnico
(Poz: V 9031.101, V 9031.121)
(Ustreza: END Armaturen ZE31 ali enakovredno)
DN25
(Poz: V 9030.049, V 9030.051, V 9030.054, V 9030.066)
(Ustreza: END Armaturen ZE31 ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 23);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (121, 4, N'D3.6', N'KROGELNI ZAPORNI VENTIL - PRIROBNIČNI
Dvodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: dvodelni krogelni ventil
- Priključek: prirobnični, po EN 1092
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
DN50
(Poz: V 9030.040, V 9030.041, V 9030.042, V 9030.044, V 9030.061)
(Ustreza: END Armaturen MP31 ali enakovredno)
DN65
(Poz: V 9031.004, V 9031.103, V 9031.104, V 9032.001)
(Ustreza: END Armaturen MP31 ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 24);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (122, 4, N'D3.7', N'KROGELNI ZAPORNI VENTIL - VARILNI
Trodelni krogelni ventil, industrijska izvedba, za vodo. Temperatura medija 0 do 40 °C, tlak do 6 bar(g). Ročni pogon, ohišje in krogla iz nerjavnega materiala. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. S ključavnico glede na specifikacijo.
Tehnične karakteristike:
- Izvedba: trodelni krogelni ventil
- Priključek: varilni
- Material: Nerjaveče jeklo - AISI 316L
- Tesnila: PTFE
DN20
(Poz: V 9031.002, V 9031.020, V 9031.124)
(Ustreza: END Armaturen ZE31 ali enakovredno)
DN50
(Poz: V 9030.064)
(Ustreza: END Armaturen ZE31  ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 25);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (123, 4, N'D3.8', N'ZAPORNA LOPUTA - ROČNA
Zaporna loputa, medprirobnična WAFER izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s spojnim, vijačnim in tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: ročni pogon z ročico do vključno DN100,
               ročni polžni pogon nad DN100
- Material ohišja: nodularna litina
- Tesnila: EPDM
DN80
(Poz: BV 9030.059, BV 9030.103) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)
DN150
(Poz: BV 9030.053, BV 9030.055, BV 9030.058, BV 9030.104) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)
DN200
(Poz: BV 9030.002, BV 9030.007, BV 9030.008, BV 9030.014, BV 9030.019, BV 9030.102, BV9030.013) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)
DN250
(Poz: BV 9030.050, BV 9030.052, BV 9030.101) 
(Ustreza: IMP Armature tip Art. 120- ali enakovredno ARI Armaturen tip Zesa)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 26);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (124, 4, N'D3.9', N'ZAPORNA LOPUTA - ROČNA
Zaporna loputa, medprirobnična LUG izvedba, primerna za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s spojnim, vijačnim in tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: medprirobnični, EN1092-1, PN16
- Pogon: ročni pogon z ročico do vključno DN100,
               ročni polžni pogon nad DN100
- Material ohišja: nodularna litina
- Tesnila: EPDM
DN200
(Poz: BV 9030.025, BV 9030.020, BV 9030.057, BV 9030.031, BV 9030.026, BV 9030.056, BV 9030.106, BV 9030.105) 
(Ustreza: IMP Armature tip Art. 126- ali enakovredno ARI Armaturen tip Gesa)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 27);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (125, 4, N'D3.10', N'ZAPORNI ZASUN - ROČNI
Zaporni  zasun, prirobnični, primeren za stolpno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s spojnim, vijačnim in tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Izvedba: centrična
- Priključek: prirobnični, EN1092-1, PN16
- Material ohišja: EN GJS-400-15
- Tesnila: EPDM
DN400
(Poz: V 9030.001) 
(Ustreza: IMP Armature tip Art. 735 ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 28);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (126, 4, N'D3.11', N'NEPOVRATNA LOPUTA:
Nepovratna loputa, za vertikalno vgradnjo brez vzmeti, primerna za vodo. Vgradna dolžina po EN 558-1, serija 14. Ročni pogon s kolesom. Temperatura medija 0 do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: medprirobnični, EN1092-1, PN16 
- Material: ohišje 1.0460, disk 1.4581
- Tesnilo: EPDM
DN 200
(Poz: CV 9030.006, CV 9030.012, CV 9030.018)
(Ustreza: Gestra CB26 ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 29);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (127, 4, N'D3.12', N'DUŠILNI VENTIL - PRIROBNIČNI
Dušilni ventil za hidravlično uravnoteženje, primeren za stolpno vodo. Poševnosedežna izvedba. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični,  EN 1092, PN16
- Material: Siva litina (EN-GJL-250)
- Tesnila: EPDM
DN65
(Poz: RV 9031.008)
(Ustreza: IMI TA STAF ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 30);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (128, 4, N'D3.13', N'DUŠILNI VENTIL
Dušilni ventil za hidravlično uravnoteženje, primeren za stolpno vodo. Poševnosedežna izvedba, z regulacijskim stožcem. Temperatura medija do 40°C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter s funkcionalno montažo.
Tehnične karakteristike:
- Priključek: varilni
- Mehko tesnenje, tesnilo PTFE
DN15
(Poz: RV 9030.046, RV 9031.024)
(Ustreza: END Armaturen AE311062/L-RK  ali enakovredno)
DN50
(Poz: RV 9030.063)
(Ustreza: END Armaturen AE311067/L-RK  ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 31);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (129, 4, N'D3.14', N'LOVILEC NEČISTOČ', NULL, 
N'', NULL, NULL, 
NULL, NULL, 32);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (130, 4, N'D3.14', N'Lovilnik nesnage, primeren za stolpno vodo. Temperatura medija do 40°C, tlak do 6 bar(g). NULL z izpustnim čepom. Vključno s spojnim, vijačnim, tesnilnim materialom in funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični, EN1092-1, PN16 
- Material: siva litina (EN-GJL-250)
- Sito: standardno, nerjavno (1.4301)
DN20
(Poz: SF 9031.022)
(Ustreza: IMP Armature Art. 020)
DN65
(Poz: SF 9031.006)
(Ustreza: IMP Armature Art. 020)
DN 200
Z izpustnim ventilom 1/2"
(Poz: SF 9030.003, SF 9030.009, SF 9030.015)
(Ustreza: IMP Armature Art. 020)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 33);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (131, 4, N'D3.15', N'VARNOSTNI VENTIL
Varnostni ventil, razbremenilna funkcija, ustrezen za hladilno vodo. Temperatura medija 5 do 40 °C. Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo. Priložen certifikat testa.
Tehnične karakteristike:
- Priključek: navojni
- Material: nerjavno jeklo
- Tlak odpiranja: 6 bar(g)
- Zaprta izvedba mehanizma
- Vzmetni, prednastavljen. 
DN 15 / DN 15
(Poz: SV 9031.102, SV 9031.122)
(Ustreza: End Armaturen SV320023/L)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 34);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (132, 4, N'D3.5.12', N'MANOMETRSKI VENTIL
Manometrski iglični ventil, navojni priključek: G 1/2". Material: nerjavni (1.4301 ali boljše).
Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Z odprtino za razbremenitev (DIN 16270).  
(Poz: V 9030.068, V 9031.009, V 9031.025, V 9031.100,  V 9031.120)
(Ustreza: INOL manom. ventil (inox) DIN16270)
Z odprtino za razbremenitev in testnim priključkom (DIN 16271)
(Poz: V 9030.067)
(Ustreza: INOL manom. ventil (inox) DIN16271)
AVTOMATSKI ODZRAČEVALNI LONČEK
Avtomatski odzračevalni lonček s plovcem, industrijska izvedba, primeren za hladilno vodo. Temperatura medija 5 do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek vstop: notranji navoj, G 3/4" 
- Priključek izstop: zunanji navoj, G 1/2" 
- Material: nerjaveče jeklo
(Poz: AO 9031.003)
(Ustreza: Mankenberg EB 1.32 ali enakovredno)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 35);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (133, 4, N'D3.5.14', N'KOMPENZATOR
Prirobnični gumi kompenzator, primeren za hladilno vodo. Temperatura medija do 40 °C, tlak do 6 bar(g). Vključno s pomožnim, montažnim in tesnilnim materialom ter funkcionalno montažo.
Tehnične karakteristike:
- Priključek: prirobnični, po EN 1092
- Material prirobnic: pocinkano ali ponikljano jeklo
- Material meha: EPDM
DN 150
(Poz: K 9030.005, K 9030.011, K 9030.017
(Ustreza: Giaflex EGK ali End Armaturen KP54 ali enakovredno)
CEVOVODI', NULL, 
N'', NULL, NULL, 
NULL, NULL, 36);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (134, 4, N'D4.1', N'CEV, NERJAVNA
Cev, varjena, nerjavna - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10217-7,  certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 15 (Ø21,3 x 1,6 mm)
DN 20 (Ø26,9 x 1,6 mm)
DN 25 (Ø33,7 x 1,6 mm)
DN 50 (Ø60,3 x 1,6 mm)
DN 65 (Ø76,1 x 2 mm)
DN 80 (Ø88,9 x 2 mm)
DN 100 (Ø114,3 x 2 mm)
DN 125 (Ø139,7 x 2 mm)
DN 150 (Ø168,3 x 2 mm)
DN 200 (Ø219,1 x 2,6 mm)
DN 250 (Ø273,0 x 2,6 mm)
DN 300 (Ø323,9 x 3 mm)
DN 400 (Ø406,4 x 3,2 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 37);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (135, 4, N'D4.2', N'KOLENO 90°, NERJAVNO
Koleno, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 15 (Ø21,3 x 2 mm)
DN 20 (Ø26,9 x 1,6 mm)
DN 25 (Ø33,7 x 1,6 mm)
DN 50 (Ø60,3 x 1,6 mm)
DN 65 (Ø76,1 x 2 mm)
DN 80 (Ø88,9 x 2 mm)
DN 100 (Ø114,3 x 2 mm)
DN 150 (Ø168,3 x 2 mm)
DN 200 (Ø219,1 x 2,6 mm)
DN 250 (Ø273,0 x 2,6 mm)
DN 300 (Ø323,9 x 3 mm)
DN 400 (Ø406,4 x 3,2 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 38);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (136, 4, N'D4.3', N'KOLENO 45°, NERJAVNO
Koleno 45°, tip 3D, varjeno, nerjavno - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 100 (Ø114,3 x 2 mm)
DN 150 (Ø168,3 x 2 mm)
DN 250 (Ø273,0 x 2,6 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 39);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (137, 4, N'D4.4', N'T-KOS, NERJAVNI
T-kos, material W.Nr.1.4301, tehnični pogoji po EN10253-4. Certifikat EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 50 (Ø60,3 x 1,6 mm)
DN 80 (Ø88,9 x 2 mm)
DN 250 (Ø273,0 x 2,6 mm)', NULL, 
N'', NULL, NULL, 
NULL, NULL, 40);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (138, 4, N'D4.5', N'T-KOS REDUCIRNI, NERJAVNI
T-kos reducirni, material W.Nr.1.4301, tehnični pogoji po EN10253-4. Certifikat EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 80/65
DN 400/300', NULL, 
N'', NULL, NULL, 
NULL, NULL, 41);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (139, 4, N'D4.6', N'REDUCIRNI KOS, NERJAVNI
Reducirni kos. nerjavni - material W.Nr.1.4301 (AISI 304), dimenzije po EN ISO 1127, dobavni pogoji po EN 10253-4, certifikat: EN 10204/3.1. Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 20/15
DN 32/20
DN 65/50
DN 80/65
DN 150/100
DN 150/125
DN 200/125
DN 200/150
DN 250/200
DN 400/300', NULL, 
N'', NULL, NULL, 
NULL, NULL, 42);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (140, 4, N'D4.7', N'PRIROBNICA, NERJAVNA
Varilna prirobnica z grlom.
- dimenzije po EN 1092-1, tip 11, B1;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim, vijačnim in varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot fiting)
DN 20, PN16
DN 32, PN16
DN 50, PN16
DN 65, PN16
DN 80, PN16
DN 100, PN16
DN 125, PN16
DN 150, PN16
DN 200, PN16
DN 250, PN16
DN 300, PN16
DN 400, PN16', NULL, 
N'', NULL, NULL, 
NULL, NULL, 43);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (141, 4, N'D4.8', N'PRIROBNICA, SLEPA, NERJAVNA
Slepa prirobnica.
- dimenzije po EN 1092-1, tip 5;
- material: W.Nr.1.4301;
- certifikat: EN 10204/3.1;
- vključno s tesnilnim in vijačnim materialom.
DN 65, PN16
DN 200, PN16
DN 250, PN16', NULL, 
N'', NULL, NULL, 
NULL, NULL, 44);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (142, 4, N'D4.9', N'CEV, NERJAVNA - za gibke cevi kemikalij
Cev, za vodenje gikbih cevi za doziranje biocida in inhibitorja. Cev, varjena, nerjavna - material W.Nr.1.4301 (AISI 304), Vključno z varilnim materialom (varjeno v zaščitni obojestranski atmosferi z inertnim plinom, varilna žica enake kvalitete kot cev).
DN 25 (Ø33,7 x 1,6 mm)
OPREMA CEVOVODOV', NULL, 
N'', NULL, NULL, 
NULL, NULL, 45);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (143, 4, N'D5.1', N'DRSNA PODPORA
Višinsko nastavljivo (90-110mm) pomično ležišče za drsne pritrditve cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje 5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip D.P.1)
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2
DN 150
DN 250
DN 300
DN 400', NULL, 
N'', NULL, NULL, 
NULL, NULL, 46);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (144, 4, N'D5.2', N'DRSNA PODPORA Z BOČNIM VODENJEM
Višinsko nastavljivo (90-110mm)  pomično ležišče za drsne pritrditve cevi  z dodatnim elementom za bočno vodenje v aksialni smeri. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje 5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom.  Dispozicija in način izvedbe glede na risbe tega načrta (tip B.V.1)
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2 + ustrezno bočno vodilo
DN 150
DN 250
DN 400', NULL, 
N'', NULL, NULL, 
NULL, NULL, 47);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (145, 4, N'D5.3', N'FIKSNA TOČKA
Višinsko nastavljivo (90-110mm) ležišče, z dodatnim elementom za fiksno pritrditev cevi. Izdelana iz pocinkane pločevine, drsna plošča z nizkim koeficientom trenja (iz poliamida ali teflona). Izvedba z dvojno objemko cevi. Za delovno temperaturno območje -5 do 40°C. Primerna za montažo na jekleno podporno konstrukcijo ali ustrezno sistemsko podkonstrukcijo. Vključno z vijačnim in pritrdilnim materialom. Dispozicija in način izvedbe glede na risbe tega načrta (tip F.T.1).
Ustreza: Sikla LC-HV-90 alternativa Hilti MP-PS-L2-2 + ustreznen fiksirni element
DN 100
DN 150
DN 250
DN 400', NULL, 
N'', NULL, NULL, 
NULL, NULL, 48);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (146, 4, N'D5.4', N'FIKSNA TOČKA
Fiksna točka, izdelana po meri, za fiksiranje vertikalnega cevovoda na talno AB ploščo bazena.
Izdelava podpore v kolenu cevovoda (cev + naležna pločevina). Izdelano iz nerjavnega materiala (1.4301). Vključno z vijačnim in pritrdilnim materialom in morebitno sanacijo vodotesnega nanosa.
DN 400', NULL, 
N'', NULL, NULL, 
NULL, NULL, 49);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (147, 4, N'D5.5', N'OBEŠALO
Obešalo cevovodov, sestavljeno iz: objemke cevovoda s profilirano gumo, plošče za pritrditev, ustrezen povezovalni element (navojna palica ali navojni adapter). Izdelano iz pocinkane pločevine. Za delovno temperaturno območje 0 do 40°C. Primerno za montažo na jekleno podporno konstrukcijo ali v AB ploščo. Vključno z vijačnim in pritrdilnim materialom. Dispozicija in način izvedbe glede na risbe tega načrta (tip O.1).
Ustreza: Sikla GPL + objemka Stabil D-3G m.E ali ekvivalent Hilti
DN 15
DN 20
DN 25
DN 50
DN 65
DN 80
DN 100
DN 125
DN 150
DN 200
DN 250
DN 400', NULL, 
N'kg', NULL, NULL, 
NULL, NULL, 50);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (148, 4, N'D5.6', N'JEKLENE PODPORNE KONSTRUKCIJE PODPOR CEVOVODOV
Iz pocinkanega materiala, vključuje sistemske modularne nosilce ustreznih dimenzij glede na podpore cevovodov, pripadajoče originalne spojne elemnte, vijačni material, zaključne pokrove in fiksiranje na nosilne konstrukcije na trasi cevovodov. Velikost podporne konstrukcije definirati glede na obtežbo, skladno z vsebino tega načrta. Ocena teže.
Ustreza: Sikla SiMotec 100, Sikla SiMotec 80, Sikla SiConnect 41/41 ali ekvivalent Hilti', 800, 
N'', NULL, NULL, 
NULL, NULL, 51);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (149, 5, N'I.1', N'Izdelava prebojev s kronskim vrtanje v AB steno / strop vključno s sanacijo preboja po montaži in izdelavo rozete.
do dimenzije Φ100 mm', NULL, 
N'', NULL, NULL, 
NULL, NULL, 1);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (150, 5, N'I.2', N'Zatesnitev prebojev cevi skozi predizdelane odprtine v AB steni / stropu.
do dimenzije Φ100 mm ali 100x100
do dimenzije Φ200 mm ali 200x200
do dimenzije Φ300 mm ali 300x300
do dimenzije Φ500 mm ali 500x500', NULL, 
N'', NULL, NULL, 
NULL, NULL, 2);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (151, 5, N'I.3', N'Zatesnitev prebojev AB plošče.
Dimenzije preboja 2400x500mm, prehod 1x cev DN250', NULL, 
N'', NULL, NULL, 
NULL, NULL, 3);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (152, 5, N'I.4', N'Požarna zatesnitev prebojev AB stene / stropa do dimenzije Φ100, izvedeni skladno študijo požarne varnosti.
do dimenzije Φ100 mm ali 100x100
do dimenzije Φ600 mm ali 600x600', NULL, 
N'', NULL, NULL, 
NULL, NULL, 4);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (153, 5, N'I.5', N'Požarna zatesnitev prebojev AB stene, izvedeni skladno študijo požarne varnosti.
Dimenzije preboja 2400x500mm, prehod 3x cev DN250', NULL, 
N'', NULL, NULL, 
NULL, NULL, 5);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (154, 5, N'I.6', N'Požarna zatesnitev prebojev AB talne plošče, izvedeni skladno študijo požarne varnosti.
Dimenzije preboja 2400x500mm, prehod 2x cev DN250, 2x cev DN200', NULL, 
N'kpl', NULL, NULL, 
NULL, NULL, 6);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (155, 5, N'I.7', N'Tlačni preizkus inštalacij sanitarne vode, 1.5 x obratovalni tlak ali skladno s tehničnim poročilom, vključno z vsem potrebnim materialom (čepi, ...) Medij preizkusa zagotovi izvajalec, investitor zagotovi medije če so na voljo oziroma do obratovalnih tlakov. Izveden skladno z veljavnimi predpisi, z vsem potrebnim materialom, ter izdelavo pisnega poročila o uspešno opravljenem tlačnem preizkusu. Obvezna prisotnost skrbnika ali nadzornika sistema.', 1, 
N'kpl', NULL, NULL, 
NULL, NULL, 7);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (156, 5, N'I.8', N'Tlačni preizkus inštalacij glikolskih mešanic, 1.5 x obratovalni tlak ali skladno s tehničnim poročilom, vključno z vsem potrebnim materialom (čepi, ...) Medij preizkusa zagotovi izvajalec, investitor zagotovi medije če so na voljo oziroma do obratovalnih tlakov. Izveden skladno z veljavnimi predpisi, z vsem potrebnim materialom, ter izdelavo pisnega poročila o uspešno opravljenem tlačnem preizkusu. Obvezna prisotnost skrbnika ali nadzornika sistema.', 2, 
N'kpl', NULL, NULL, 
NULL, NULL, 8);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (157, 5, N'I.9', N'Tlačni preizkus inštalacij stolpne/hladilne vode, 1.5 x obratovalni tlak ali skladno s tehničnim poročilom, vključno z vsem potrebnim materialom (čepi, ...) Medij preizkusa zagotovi izvajalec, investitor zagotovi medije če so na voljo oziroma do obratovalnih tlakov. Izveden skladno z veljavnimi predpisi, z vsem potrebnim materialom, ter izdelavo pisnega poročila o uspešno opravljenem tlačnem preizkusu. Obvezna prisotnost skrbnika ali nadzornika sistema.', 2, 
N'kpl', NULL, NULL, 
NULL, NULL, 9);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (158, 5, N'I.10', N'Tlačni preizkus inštalacij stisnjenega zraka, 1.5 x obratovalni tlak ali skladno s tehničnim poročilom, vključno z vsem potrebnim materialom (čepi, ...) Medij preizkusa zagotovi izvajalec, investitor zagotovi medije če so na voljo oziroma do obratovalnih tlakov. Izveden skladno z veljavnimi predpisi, z vsem potrebnim materialom, ter izdelavo pisnega poročila o uspešno opravljenem tlačnem preizkusu. Obvezna prisotnost skrbnika ali nadzornika sistema.', 1, 
N'kpl', NULL, NULL, 
NULL, NULL, 10);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (159, 5, N'I.11', N'Preizkus tesnosti kanalizacije. Izveden skladno z veljavnimi predpisi, z vsem potrebnim materialom, ter izdelavo pisnega poročila o uspešno opravljenem tesnostnem preizkusu. Obvezna prisotnost skrbnika ali nadzornika sistema.', 1, 
N'kpl', NULL, NULL, 
NULL, NULL, 11);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (160, 5, N'I.12', N'Izdelava ročnih ali elektronskih zaznamb in sprememb glede na PZI dokumentacijo.', 1, 
N'kpl', NULL, NULL, 
NULL, NULL, 12);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (161, 5, N'I.13', N'Izdelava ročnih ali elektronskih zaznamb in sprememb glede na PZI dokumentacijo.', 1, 
N'kpl', NULL, NULL, 
NULL, NULL, 13);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (162, 5, N'I.14', N'Šolanje uporabnikov ter ostala tehnična dokumentacija.', 1, 
N'kpl', NULL, NULL, 
NULL, NULL, 14);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (163, 5, N'I.15', N'Označevanje opreme, armatur in cevovodov (izvedba s samolepilnimi nalepkami in napisnimi ploščicami) - izvedba v skladu s LEKovimi internimi standardi.', 1, 
N'kpl', NULL, NULL, 
NULL, NULL, 15);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (164, 5, N'I.16', N'Regulacija celotnega sistema', 1, 
N'kpl', NULL, NULL, 
NULL, NULL, 16);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (165, 5, N'I.17', N'Varilska dokumentacija', 1, 
N'', NULL, NULL, 
NULL, NULL, 17);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (166, 6, N'J.1', N'Izdelava dokumentacije in validacije v skladu z GMP/GEP:
- Izdelava kompletne IQ dokumentacije in vsa testiranja opreme na terenu, krmilnike in nadzorni sistem glede na vzorčne priloge investitorja. V dokumentaciji se vključi varilna dokumentacija za sprostitev (certifikat podjetja, atesti varilcev, postopki WPS/WPQR). IQ dokumentacija mora biti predana za potrditev v elektronski obliki z vsemi prilogami, kjer so označeni elementi (tip ...).
- Sodelovanje pri zagonu v sodelovanju z investitorjem in dobaviteljem programske opreme.', 1, 
N'kpl', NULL, NULL, 
NULL, NULL, 1);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (167, 6, N'J.2', N'Varilska dokumentacija (certifikat podjetja, vhodna kontrola materiala, atesti varilcev, varilski dnevnik, ročne izometrične sheme, poročilo o NDT pregledu cevnih instalacij, priprava sprostitvene dokumentacije ter testov za pričetek varilskih del..', 1, 
N'kpl', NULL, NULL, 
NULL, NULL, 2);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (168, 6, N'J.3', N'Kontrola varilskih del nerjavnih cevovodov, katera zajema endoskopski nadzor zvarov. Kontrolo lahko izvaja pooblaščena in certificirana oseba s strani izvajalca, končno poročilo pa potrjuje samo neodvisni kontrolni organ. 
OBSEG DEL: 100% zunanji vizualni pregled in 10% endoskopska kontrola zvarov cevi s poročilom  (mesta kontrol določi nadzornik). V primeru, da se med pregledanimi zvari odkrije napaka se določi dodatne zvare za pregled. Obseg se določi v dogovoru med nadzornikom, investitorjem in izvajalcem glede na število napak. Razliko kontrole plača izvajalec varilskih del.', 1, 
N'', NULL, NULL, 
NULL, NULL, 3);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (169, 7, N'K.1', N'Dobava material v takšni zaščiti, da ne pride do mehanskih poškodb in do kontaminacije z vlago, olji ali delci. Enaka kakovost je potrebno zagotoviti tudi med transportom.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 1);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (170, 7, N'K.2', N'Skladiščenje, varovanje in izdaja dobavljene opreme med montažo.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 2);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (171, 7, N'K.3', N'Splošni, zavarovalni, manipulativni in transportni stroški do gradbišča (lokacija gradbišča je LEK Mengeš), pripravljalna, zaključna dela in organizacija gradbišča. Ti stroški naj bodo v celoti upoštevani in vključeni v cenah postavk.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 3);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (172, 7, N'K.4', N'Vsa oprema in material se smatrata kot vgrajena na objektu vključno z nabavo, transportom, zavarovanjem, usklajevanjem z gradbincem ter zarisovanjem, montažo in vsem potrebnim drobnim montažnim materialom.
Vsa oprema in material sta do končnega prevzema s strani investitorja v lasti izvajalca del.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 4);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (173, 7, N'K.5', N'Montaža vključuje vsa potrebna dela od vključno raztovarjanja iz kamiona do postavitve in montaže na mesto vgradnje. Vključuje tudi postavitev montažnih odrov z varovalno ograjo ali uporabo električnih dvižnih košar.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 5);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (174, 7, N'K.6', N'Dela so opravljajo na višini do 8 metrov, vsi odri, dvižne ploščadi in dvigala so zajeta v ceni.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 6);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (175, 7, N'K.7', N'Ob dobavi vse opreme in armatur mora biti priložena tehnična dokumentacija (certifikati vgrajene opreme in materiala, garancijski listi, vgrana, vzdrževalna in obratovalna navodila proizvajalcev vgrajene opreme, kalibracijski listi) navodila za vgradnjo, obratovanje in vzdrževanje v originalnem in slovenskem jeziku, tehnični prospekti in diagrami z osnovnimi karakteristikami v originalnem jeziku, vključno z znakom CE in izjavo o skladnosti z Odredbo o varnosti strojev v originalnem in slovenskem jeziku. 
Priložiti tehnično dokumentacijo (certifikati vgrajene opreme in materiala, garancijski listi, vzdrževalna in obratovalna navodila proizvajalcev vgrajene opreme, kalibracijski listi).', NULL, 
N'', NULL, NULL, 
NULL, NULL, 7);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (176, 7, N'K.8', N'V ceni navojnih armatur so všteti vsi navojni kosi (dvovijačniki, kolčaki,..)  in holandci. Holandci se uporabijo pri vseh navojnih elementih, ki imajo električno napajanje (črpalke, elektro motorni ventili, termodinamični ventili, merilniki pretoka,…..).', NULL, 
N'', NULL, NULL, 
NULL, NULL, 8);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (177, 7, N'K.9', N'V ceni termometrov, manometrov in ostalih merilnih elementov je zajeta privaritev kolčaka (mufne), DN 15 ali DN 20, na glavni cevovod. Ta del se ne obravnava kot T kos.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 9);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (178, 7, N'K.10', N'V ceni vseh cevi je vključeno tesnjenje vseh prebojev, med istimi požarnimi sektorji, s purpenom ali mineralno volno glede na aplikacijo oziroma medij. Prav tako se z rozeto (kovinska ali PVC ) obdela viden prehod cevi skozi stene.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 10);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (179, 7, N'K.11', N'O vsakem odstopanju od projekta, in o morebitni zamenjavi opreme, je izvajalec dolžan obvestiti nadzornika in dobiti potrditev.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 11);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (180, 7, N'K.12', N'V kolikor izvajalec del vgradi opremo drugega dobavitelja, kot je bila sprojektirana (zgornje točke), je dolžan kriti stroške vseh potrebnih sprememb, ki nastanejo zaradi spremenjene opreme. Prav tako je dolžan določiti ustrezen tip in dimenzije nove opreme ter preveriti vse elemente, ki tvorijo funkcionalno celoto.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 12);
INSERT INTO EX.Component (Id, SectionID, Position, Description, Quantity, Unit, SupplyPerUnit, InstallationPerUnit, TotalPerUnit, Total, SortOrder)
VALUES (181, 7, N'K.13', N'Vsi cevni elementi (cevi, kolena, T-kosi…) morajo biti dobavljeni po ustreznem dimenzijskem standardu cevi.', NULL, 
N'', NULL, NULL, 
NULL, NULL, 13);