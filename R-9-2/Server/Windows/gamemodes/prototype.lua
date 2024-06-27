function OnGamemodeInit()
	print("------------------------------------------------------");
	print("Initializing gamemode for Gothic Multiplayer Accrescere");
	print("------------------------------------------------------");
	
	AddPlayerClass("ORCWARRIOR_ROAM",946.88,746.5,1295.40,192,65107.519,2595.90,-7481.41,180);
	AddPlayerClass("ORCELITE_ROAM",946.88,746.5,1295.40,192,322.55,-88.5,1916.97,170);
	AddPlayerClass("ORCSHAMAN_SIT",946.88,746.5,1295.40,192,1235.18,-99.5,312.04,266);
	AddPlayerClass("UNDEADORCWARRIOR",946.88,746.5,1295.40,192,764.235,-92.5,1174.86,206);
	AddPlayerClass("PC_HERO",879.89,812.5,-887.39,326,244.93,-91.97,-1911.84,3);
	AddPlayerClass("PC_ROCKEFELLER",879.89,812.5,-887.39,326,-219.16,94.5,-1259.12,16);
	AddPlayerClass("PC_HERO",879.89,812.5,-887.39,326,-219.16,94.5,-1259.12,16);
	SetGamemodeName("NPC/BOT test");
end

function OnGamemodeExit()
	print("------------------------------------------------------");
	print("Gamemode removed from server.");
	print("------------------------------------------------------");
end

function OnPlayerChangeClass(playerid, classid)
	print(string.format("%s %d %s %d","PlayerID:",playerid,"changed class on",classid));
end

function OnPlayerSelectClass(playerid, classid)
	print(string.format("%s %d %s %d","PlayerID:",playerid,"selected class number:",classid));
end

function OnPlayerConnect(playerid)
	SendMessageToAll(0,255,0,string.format("%s %s %d%s %s",GetPlayerName(playerid),"(ID:",playerid,")","polaczyl sie z serwerem."));
	SendPlayerMessage(playerid,255,255,0,"Use /worlds to teleport to another world");
end

function OnPlayerSpawn(playerid, classid)
	SendMessageToAll(29,255,100,string.format("%s %s",GetPlayerName(playerid),"has spawned."));
	
	if classid == 6
	then
		SetPlayerMaxHealth(playerid,1000);
		SetPlayerHealth(playerid,1000);
		SetPlayerMaxMana(playerid,5000);
		SetPlayerMana(playerid,5000);
		SetPlayerMagicLevel(playerid,6);
		EquipArmor(playerid,"ITAR_KDF_L");
		GiveItem(playerid,"ITRu_Waterfist",1);
		GiveItem(playerid,"ITRu_Whirlwind",1);
		GiveItem(playerid,"ITRU_ZAP",1);
		GiveItem(playerid,"ITRu_Geyser",1);
		GiveItem(playerid,"ITRU_CHARGEFIREBALL",1);
		GiveItem(playerid,"ITRU_CONCUSSIONBOLT",1);
		GiveItem(playerid,"ITRU_FULLHEAL",1);
	end
	
	SetPlayerStrength(playerid,100);
end

function OnPlayerDeath(playerid, p_classid, killerid, k_classid)
	
	if killerid == -1 then
	    SendMessageToAll(29,210,230,string.format("%s %s",GetPlayerName(playerid),"kill himself."));
	else
		SendMessageToAll(29,210,230,string.format("%s %s %s",GetPlayerName(killerid),"killed",GetPlayerName(playerid)));
	end
end

function OnPlayerDisconnect(playerid, reason)
	
	if reason == 0 then --disconnect
		SendMessageToAll(255,0,0,string.format("%s %s %d%s %s",GetPlayerName(playerid),"(ID:",playerid,")","disconnected from server."));
	
	elseif reason == 1 then --lost
		SendMessageToAll(255,0,0,string.format("%s %s %d%s %s",GetPlayerName(playerid),"(ID:",playerid,")","lost connection with server."));
		
	elseif reason == 2 then --kick
	
	elseif reason == 3 then --ban
		print(string.format("%s %s",GetPlayerName(playerid),"zostal zbanowany"));
	
	end
end


function OnPlayerCommandText(playerid, cmdtext)

	if cmdtext == "/worlds"
	then
		SendPlayerMessage(playerid,255,255,0,"Use: /khorinis /gd /jarkendar");
	elseif cmdtext == "/khorinis"
	then
		SetPlayerWorld(playerid,"NEWWORLD\\NEWWORLD.ZEN","START_OW_ORETRAIL");
	elseif cmdtext == "/gd"
	then
		SetPlayerWorld(playerid,"OLDWORLD\\OLDWORLD.ZEN","WP_INTRO13");
	elseif cmdtext == "/jarkendar"
	then
		SetPlayerWorld(playerid,"ADDON\\ADDONWORLD.ZEN","START_OW_ORETRAIL");	
	end
end