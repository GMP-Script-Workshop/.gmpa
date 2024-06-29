function OnGamemodeInit()
	print("------------------------------------------------------");
	print("Initializing gamemode for Gothic Multiplayer Accrescere");
	print("------------------------------------------------------");
	SetGamemodeName("Gamemode by Sengrath V. 1.0");
	
AddPlayerClass("PC_HERO",0,0,0,0,0,0,0,0);--0
AddPlayerClass("PC_HERO",0,0,0,0,0,0,0,0);--1
AddPlayerClass("PC_HERO",0,0,0,0,0,0,0,0);--2
AddPlayerClass("PC_HERO",0,0,0,0,0,0,0,0);--3
AddPlayerClass("PC_HERO",0,0,0,0,0,0,0,0);--4
AddPlayerClass("PC_HERO",0,0,0,0,0,0,0,0);--5
AddPlayerClass("PC_HERO",0,0,0,0,0,0,0,0);--6
AddPlayerClass("PC_HERO",0,0,0,0,0,0,0,0);--7
EnableChat(0);
end

function OnGamemodeExit()
	print("------------------------------------------------------");
	print("Gamemode removed from server.");
	print("------------------------------------------------------");
end

local Player = {};
local MAX_PLAYERS = GetMaxPlayers();
local MaxPlayers = 100;

function OnPlayerChangeClass(playerid, classid)
	print(string.format("%s %d %s %d","PlayerID:",playerid,"changed class on",classid));
	
       if classid == 0 then --WOJOWNIK INNOSA
		GameTextForPlayer(playerid,2500,4000,"WOJOWNIK INNOSSA","Font_Old_20_White_Hi.TGA",255,255,0,3000);
	    elseif classid == 1 then --STRZELEC INNOSA
	    GameTextForPlayer(playerid,2500,4000,"STRZELEC INNOSSA","Font_Old_20_White_Hi.TGA",255,255,0,3000);
	    elseif classid == 2 then --KUSZNIK INNOSA
	    GameTextForPlayer(playerid,2500,4000,"KUSZNIK INNOSSA","Font_Old_20_White_Hi.TGA",255,255,0,3000);
	    elseif classid == 3 then --MAG INNOSA
		GameTextForPlayer(playerid,2500,4000,"MAG INNOSSA","Font_Old_20_White_Hi.TGA",255,255,0,3000);
		elseif classid == 4 then --MROCZNY WOJOWNIK
		GameTextForPlayer(playerid,2500,4000,"MROCZNY WOJOWNIK","Font_Old_20_White_Hi.TGA",255,255,0,3000);
		elseif classid == 5 then --MROCZNY STRZELEC
		GameTextForPlayer(playerid,2500,4000,"MROCZNY STRZELEC","Font_Old_20_White_Hi.TGA",255,255,0,3000);
		elseif classid == 6 then --MROCZNY KUSZNIK
		GameTextForPlayer(playerid,2500,4000,"MROCZNY KUSZNIK","Font_Old_20_White_Hi.TGA",255,255,0,3000);
		elseif classid == 7 then --MROCZNY MAG
        GameTextForPlayer(playerid,2500,4000,"MROCZNY MAG","Font_Old_20_White_Hi.TGA",255,255,0,3000);
		end
end

function OnPlayerSelectClass(playerid, classid)
	print(string.format("%s %d %s %d","PlayerID:",playerid,"selected class number:",classid));
end

function OnPlayerConnect(playerid)
	SendMessageToAll(0,255,0,string.format("%s %s %d%s %s",GetPlayerName(playerid),"(ID:",playerid,")","polaczyl sie z serwerem."));
	end

function OnPlayerSpawn(playerid, classid)
	
		if classid == 0 then
SetPlayerMaxHealth(playerid,300);
SetPlayerStrength(playerid,70);
CompleteHeal(playerid);
SetPlayerSkillWeapon(playerid,0,60);
GiveItem(playerid,"ItFo_Apple",5);
GiveItem(playerid,"ItFo_Bacon",5);
GiveItem(playerid,"ItFo_CoragonsBeer",5);
GiveItem(playerid,"ItFo_Bread",5);
GiveItem(playerid,"ItFo_Wine",5);
GiveItem(playerid,"ItPo_Health_Addon_04",5);
EquipArmor(playerid,"ITAR_MIL_M");
EquipMeleeWeapon(playerid,"ITMW_SCHWERT");
	end
		if classid == 1 then
		SetPlayerMaxHealth(playerid,200);
SetPlayerStrength(playerid,70);
SetPlayerDexterity(playerid,60);
CompleteHeal(playerid);
SetPlayerSkillWeapon(playerid,2,60);
SetPlayerAcrobatic(playerid, 0);
GiveItem(playerid,"ItFo_Apple",5);
GiveItem(playerid,"ItFo_Bacon",5);
GiveItem(playerid,"ItFo_CoragonsBeer",5);
GiveItem(playerid,"ItFo_Bread",5);
GiveItem(playerid,"ItFo_Wine",5);
GiveItem(playerid,"ItPo_Health_Addon_04",5);
GiveItem(playerid,"ItRw_Arrow",500);
EquipArmor(playerid,"ITAR_MIL_L");
EquipMeleeWeapon(playerid,"ITMW_SCHWERT");
EquipRangedWeapon(playerid,"ITRW_BOW_M_01");
	end
		if classid == 2 then
		SetPlayerMaxHealth(playerid,200);
SetPlayerStrength(playerid,70);
SetPlayerDexterity(playerid,60);
CompleteHeal(playerid);
SetPlayerSkillWeapon(playerid,3,60);
SetPlayerAcrobatic(playerid, 0);
GiveItem(playerid,"ItFo_Apple",5);
GiveItem(playerid,"ItFo_Bacon",5);
GiveItem(playerid,"ItFo_CoragonsBeer",5);
GiveItem(playerid,"ItFo_Bread",5);
GiveItem(playerid,"ItFo_Wine",5);
GiveItem(playerid,"ItPo_Health_Addon_04",5);
GiveItem(playerid,"ItRw_Bolt",500);
EquipArmor(playerid,"ITAR_MIL_L");
EquipMeleeWeapon(playerid,"ITMW_SCHWERT");
EquipRangedWeapon(playerid,"ITRW_MIL_CROSSBOW");
	end
		if classid == 3 then
		SetPlayerMaxHealth(playerid,200);
SetPlayerStrength(playerid,20);
SetPlayerMaxMana(playerid,400);
SetPlayerDexterity(playerid,20);
CompleteHeal(playerid);
SetPlayerMagicLevel(playerid,6);
SetPlayerAcrobatic(playerid, 0);
GiveItem(playerid,"ITRU_LIGHT",1);
GiveItem(playerid,"ITRU_FIREBOLT",1);
GiveItem(playerid,"ITRU_SUMGOBSKEL",1);
GiveItem(playerid,"ITRU_INSTANTFIREBALL",1);
GiveItem(playerid,"ITRU_ICEBOLT",1);
GiveItem(playerid,"ITRU_SUMWOLF",1);
GiveItem(playerid,"ITRU_FIRESTORM",1);
GiveItem(playerid,"ITRU_ICECUBE",1);
GiveItem(playerid,"ITRU_CHARGEFIREBALL",1);
GiveItem(playerid,"ITRU_TELEPORTFARM",1);
GiveItem(playerid,"ITRU_TELEPORTMONASTERY",1);
GiveItem(playerid,"ITRU_TELEPORTSEAPORT",1);
GiveItem(playerid,"ITSC_TRFWOLF",5);
GiveItem(playerid,"ITSC_TRFGIANTBUG",5);
GiveItem(playerid,"ITSC_TRFFIREWARAN",5);
GiveItem(playerid,"ITSC_TRFSHADOWBEAST",5);
GiveItem(playerid,"ItPo_Mana_Addon_04",1);
EquipArmor(playerid,"ITAR_KDF_M");
	end
		if classid == 4 then
SetPlayerMaxHealth(playerid,300);
SetPlayerStrength(playerid,70);
SetPlayerMaxMana(playerid,0);
CompleteHeal(playerid);
SetPlayerSkillWeapon(playerid,1,60);
SetPlayerAcrobatic(playerid, 0);
GiveItem(playerid,"ItFo_Apple",5);
GiveItem(playerid,"ItFo_Bacon",5);
GiveItem(playerid,"ItFo_CoragonsBeer",5);
GiveItem(playerid,"ItFo_Bread",5);
GiveItem(playerid,"ItFo_Wine",5);
GiveItem(playerid,"ItPo_Health_Addon_04",5);
EquipArmor(playerid,"ITAR_SLD_M");
EquipMeleeWeapon(playerid,"ITMW_SCHWERT4");
	end
		if classid == 5 then
		SetPlayerMaxHealth(playerid,200);
SetPlayerStrength(playerid,70);
SetPlayerMaxMana(playerid,0);
SetPlayerDexterity(playerid,60);
CompleteHeal(playerid);
SetPlayerSkillWeapon(playerid,3,60);
SetPlayerAcrobatic(playerid, 0);
GiveItem(playerid,"ItFo_Apple",5);
GiveItem(playerid,"ItFo_Bacon",5);
GiveItem(playerid,"ItFo_CoragonsBeer",5);
GiveItem(playerid,"ItFo_Bread",5);
GiveItem(playerid,"ItFo_Wine",5);
GiveItem(playerid,"ItPo_Health_Addon_04",5);
GiveItem(playerid,"ItRw_Arrow",500);
EquipArmor(playerid,"ITAR_SLD_L");
EquipMeleeWeapon(playerid,"ITMW_SCHWERT4");
EquipRangedWeapon(playerid,"ITRW_BOW_M_01");
	end
		if classid == 6 then
SetPlayerMaxHealth(playerid,200);
SetPlayerStrength(playerid,70);
SetPlayerDexterity(playerid,60);
CompleteHeal(playerid);
SetPlayerSkillWeapon(playerid,3,60);
SetPlayerAcrobatic(playerid, 0);
GiveItem(playerid,"ItFo_Apple",5);
GiveItem(playerid,"ItFo_Bacon",5);
GiveItem(playerid,"ItFo_CoragonsBeer",5);
GiveItem(playerid,"ItFo_Bread",5);
GiveItem(playerid,"ItFo_Wine",5);
GiveItem(playerid,"ItPo_Health_Addon_04",5);
GiveItem(playerid,"ItRw_Bolt",500);
EquipArmor(playerid,"ITAR_SLD_L");
EquipMeleeWeapon(playerid,"ITMW_SCHWERT4");
EquipRangedWeapon(playerid,"ITRW_MIL_CROSSBOW");
	end
		if classid == 7 then
		SetPlayerInstance(playerid,"PC_HERO");
SetPlayerMaxHealth(playerid,200);
SetPlayerStrength(playerid,20);
SetPlayerMaxMana(playerid,400);
SetPlayerDexterity(playerid,20);
CompleteHeal(playerid);
SetPlayerMagicLevel(playerid,6);
SetPlayerAcrobatic(playerid, 0);
GiveItem(playerid,"ITRU_LIGHT",1);
GiveItem(playerid,"ITRU_FIREBOLT",1);
GiveItem(playerid,"ITRU_SUMGOBSKEL",1);
GiveItem(playerid,"ITRU_INSTANTFIREBALL",1);
GiveItem(playerid,"ITRU_ICEBOLT",1);
GiveItem(playerid,"ITRU_SUMWOLF",1);
GiveItem(playerid,"ITRU_FIRESTORM",1);
GiveItem(playerid,"ITRU_ICECUBE",1);
GiveItem(playerid,"ITRU_CHARGEFIREBALL",1);
GiveItem(playerid,"ITRU_TELEPORTFARM",1);
GiveItem(playerid,"ITRU_TELEPORTMONASTERY",1);
GiveItem(playerid,"ITRU_TELEPORTSEAPORT",1);
GiveItem(playerid,"ITSC_TRFWOLF",5);
GiveItem(playerid,"ITSC_TRFGIANTBUG",5);
GiveItem(playerid,"ITSC_TRFFIREWARAN",5);
GiveItem(playerid,"ITSC_TRFSHADOWBEAST",5);
GiveItem(playerid,"ItPo_Mana_Addon_04",1);
EquipArmor(playerid,"ITAR_KDW_M_ADDON");
	end
end
function OnPlayerDeath(playerid, p_classid, killerid, k_classid)
	
end

function OnPlayerDisconnect(playerid, reason)
	
	if reason == 0 then --disconnect
		SendMessageToAll(255,0,0,string.format("%s %s %d%s %s",GetPlayerName(playerid),"(ID:",playerid,")","od³¹czy³ siê od serwera."));
	
	elseif reason == 1 then --lost
		SendMessageToAll(255,0,0,string.format("%s %s %d%s %s",GetPlayerName(playerid),"(ID:",playerid,")","utraci³ po³¹czenie z serwerem."));
		
	elseif reason == 2 then --kick
        print(string.format("%s %s",GetPlayerName(playerid),"zosta³ wywalony xd"));
	elseif reason == 3 then --ban
		print(string.format("%s %s",GetPlayerName(playerid),"zosta³ zbanowany"));
	
	end
end