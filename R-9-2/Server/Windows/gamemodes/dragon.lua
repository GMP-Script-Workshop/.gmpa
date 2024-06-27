function OnGamemodeInit()
	print(" ");
	print("------------------------------------------------------");
	print("Dragons gamemode");
	print("------------------------------------------------------");
	
	AddPlayerClass("DRAGON_ICE",0.0,100.0,0.0,90,0.0,0.0,0.0,0);
	AddPlayerClass("DRAGON_FIRE",0.0,100.0,0.0,90,0.0,0.0,0.0,0);
	AddPlayerClass("DRAGON_SWAMP",0.0,100.0,0.0,90,0.0,0.0,0.0,0);
	AddPlayerClass("DRAGON_UNDEAD",0.0,100.0,0.0,90,0.0,0.0,0.0,0);
	--AddPlayerClass("WOLF",997.44,694.0,-3092.83,90,0.0,0.0,0);
	--AddPlayerClass("SNAPPER",997.44,694.0,-3092.83,90,0.0,0.0,0);
	--AddPlayerClass("SCAVENGER",997.44,694.0,-3092.83,90,0.0,0.0,0);
end

function OnPlayerChangeClass(playerid, classid)
	
	if classid == 0 then --ice
		SendPlayerMessage(playerid,255,255,255,"Lodowy smok. Jezeli uwielbiasz zime i wszystko co z nia wiazane wybierz wlasnie jego!");
		
	elseif classid == 1 then --fire
		SendPlayerMessage(playerid,255,0,0,"Smok ognisty idealnie pasuje do mrocznych i budzacych strach krain!");
		
	elseif classid == 2 then --swamp
		SendPlayerMessage(playerid,200,255,200,"Bagienny smok najlepiej nadaje sie w klimatach wody i blota!");
	
	elseif classid == 3 then --undead
		SendPlayerMessage(playerid,50,50,0,"Smok nieumarly jest wladca wszystkich smokow i okupuje mroczne podziemia");	
	
	end
end

function OnPlayerConnect(playerid)

	SendPlayerMessage(playerid,255,255,255,"  ");
	SendPlayerMessage(playerid,255,255,255,"  "); 
	SendPlayerMessage(playerid,255,255,255,"  "); 
	SendPlayerMessage(playerid,255,255,255,"  "); 
	SendPlayerMessage(playerid,255,255,255,"  ");
	SendPlayerMessage(playerid,255,255,255,"  "); 
	SendPlayerMessage(playerid,255,255,255,"  "); 
	SendPlayerMessage(playerid,255,255,255,"  "); 
	SendPlayerMessage(playerid,0,150,0,"Witaj w krainie smokow!"); 
end

function OnPlayerDisconnect(playerid, reason)
	SendPlayerMessage(playerid,255,0,255,"Disconnect player (test)"); 
end

function OnPlayerCommandText(playerid, cmdtext)

end