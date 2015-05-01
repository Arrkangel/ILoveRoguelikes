stats={}


function stats.newSheet(STR,DEX,CON,INT,WIS,CHA)
	local sheet={}
	sheet.STR=STR
	sheet.DEX=DEX
	sheet.CON=CON
	sheet.INT=INT
	sheet.WIS=WIS
	sheet.CHA=CHA

	sheet.hp=CON
	sheet.maxhp=CON

	sheet.def=0
	sheet.atk=0


	return sheet
end
