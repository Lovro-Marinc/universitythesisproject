use Indigomat;
go

use _indigomat_plant3dproject_Piping
go

--Priprava in razvod
select 
	* 
from 
	_indigomat_plant3dproject_PnId.dbo.Equipment_PNP


select 
	* 
from
	_indigomat_plant3dproject_PnId.dbo.HandValves
	
select 
	* 
from
	_indigomat_plant3dproject_PnId.dbo.ButterflyValve_PNP

	
select 
	* 
from
	_indigomat_plant3dproject_PnId.dbo.CheckValve_PNP

select 
	* 
from
	_indigomat_plant3dproject_PnId.dbo.BallValve_PNP

select 
	* 
from
	_indigomat_plant3dproject_PnId.dbo.Equipment_PNP


select 
	STEVILCNAOZNAKA,TIPOPREME,TLACNASTOPNJA,PnPClassName,PnPTimestamp,ClassName,CRKOVNAOZNAKA,Description,DIMENZIJA, FLUID, MODEL,MONTAŽA, OPIS,OPIS1Oprema,OPIS2Oprema,OPIS3Oprema,OPIS4Oprema, OPIS5OPREME,PROIZVAJALEC
from
	_indigomat_plant3dproject_PnId.dbo.EngineeringItems_PNP
order by TIPOPREME

Dvodelni krogelni ventil, z razbremenitvijo tlaka v vmesnem prostoru ventila (luknjica ali razbremenilno tesnilo) v odprtem in zaprtem položaju, 
industrijska izvedba, za 50% etilen-glikolsko mešanico. Temperatura medija -25 do 40 °C, tlak do 8 bar(g). 

---1. FAZA
---> EXCEL SHEET => iz tabele , samo vrstni red, brez oblikovanja
		--select 
		--	STEVILCNAOZNAKA,TIPOPREME,TLACNASTOPNJA,PnPClassName,PnPTimestamp,ClassName,CRKOVNAOZNAKA,Description,DIMENZIJA, FLUID, MODEL,MONTAŽA, OPIS,OPIS1Oprema,OPIS2Oprema,OPIS3Oprema,OPIS4Oprema, OPIS5OPREME,PROIZVAJALEC
		--from
		--	_indigomat_plant3dproject_PnId.dbo.EngineeringItems_PNP
		--order by TIPOPREME
---2. FAZA
---> aplikacija in integracija Plant3d; lisp komande za import tekstov/šifrantov

---> EXCEL SHEET => iz tabele 
		--select 
		--	STEVILCNAOZNAKA,TIPOPREME,TLACNASTOPNJA,PnPClassName,PnPTimestamp,ClassName,CRKOVNAOZNAKA,Description,DIMENZIJA, FLUID, MODEL,MONTAŽA, OPIS,OPIS1Oprema,OPIS2Oprema,OPIS3Oprema,OPIS4Oprema, OPIS5OPREME,PROIZVAJALEC
		--from
		--	_indigomat_plant3dproject_PnId.dbo.EngineeringItems_PNP
		--order by TIPOPREME
---3. FAZA
--   Razširitev excela proti finalni verziji

select 
	*
from
	_indigomat_plant3dproject_PnId.dbo.FlowMeasurement_PNP

	select 
	*
from
	_indigomat_plant3dproject_PnId.dbo.HandValves

	select 
	*
from
	_indigomat_plant3dproject_PnId.dbo.InLineAssets_PNP

		select 
	*
from
	_indigomat_plant3dproject_PnId.dbo.InlineInstruments_PNP

		select 
	*
from
	_indigomat_plant3dproject_PnId.dbo.Instrumentation_PNP

	select 
	*
from
	_indigomat_plant3dproject_PnId.dbo.Instrumentation_PNP

select 	* from	_indigomat_plant3dproject_PnId.dbo.Tanks_PNP

select 	* from	_indigomat_plant3dproject_PnId.dbo.Nozzles_PNP

select 	* from	_indigomat_plant3dproject_PnId.dbo.PipeLineGeneral_PNP

--- KOSOVNICE
select 	* from	_indigomat_plant3dproject_PnId.dbo.PnpPickLists_PNP where PNPID=49
select 	* from	_indigomat_plant3dproject_PnId.dbo.PnpPickListValues_PNP


