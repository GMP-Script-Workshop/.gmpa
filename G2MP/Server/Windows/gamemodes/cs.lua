require "Bimbol Engine/require"

--Max 16 spawnpoints
local BanditSpawn =
{
	{863.97198486328,-96.835762023926,-1327.9030761719,91},
	{865.51055908203,-96.065582275391,-1489.8846435547,91},
	{867.04333496094,-97.8017578125,-1656.6732177734,91},
	{872.91729736328,-96.246421813965,-1836.5517578125,91},
	{874.76220703125,-94.650833129883,-1987.1541748047,91},
	{658.90832519531,-83.118881225586,-1148.4565429688,88},
	{641.15795898438,-88.030334472656,-1300.8188476563,91},
	{640.88098144531,-92.825546264648,-1470.9879150391,91},
	{675.22003173828,-95.16471862793,-1641.7072753906,91},
	{676.38861083984,-96.542655944824,-1774.2614746094,91},
	{675.45709228516,-97.697814941406,-1943.6342773438,91},
	{464.89633178711,-87.899147033691,-1243.5950927734,86},
	{475.24948120117,-88.057495117188,-1412.8336181641,91},
	{475.63134765625,-90.986671447754,-1581.2565917969,91},
	{472.3916015625,-100.23233032227,-1935.2331542969,91},
	{489.88391113281,-95.903770446777,-2102.5297851563,91}
};

--Max 16 spawnpoints
local PaladinSpawn = 
{
	{9901.919921875,368.25009155273,4282.9262695313,185},
	{9710.767578125,368.24349975586,4295.5595703125,185},
	{9593.48828125,368.25765991211,4499.5747070313,249},
	{9519.2421875,368.27764892578,4685.009765625,243},
	{9425.7978515625,368.26965332031,4858.3286132813,243},
	{9357.08203125,368.23477172852,5070.3784179688,242},
	{9251.119140625,368.57620239258,5262.7763671875,242},
	{9819.814453125,368.28561401367,4687.4946289063,246},
	{9739.6181640625,368.26950073242,4858.6181640625,246},
	{9650.36328125,368.26809692383,5052.8041992188,246},
	{9547.19921875,368.25881958008,5277.5268554688,246},
	{9456.0263671875,368.30850219727,5466.25,246},
	{10056.544921875,364.97082519531,4551.33984375,243},
	{9972.0224609375,367.59133911133,4887.1953125,243},
	{9955.798828125,367.89999389648,5170.4072265625,243},
	{9721.9345703125,370.23724365234,5387.380859375,243}
};

local MAX_CSPLAYERS = 32;

local LANG_ENGLISH = 0;
local LANG_POLISH = 1;

local TIME_AWAITING_FOR_START = 10; --10 seconds
local TIME_MINUTE_ROUND = 3; --3 minutes
local TIME_SECOND_ROUND = 59; --59 seconds

local MAIN_WORLD = 0;

local SelectionPos = {262.50103759766,474.04739379883,-5298.1748046875,320};

local CSGame = {};
local CSPlayer = {};
local BanditTeam = {};
local PaladinTeam = {};
local Language = {};

function BE_OnGamemodeInit()

	print("");
	print("-------------------------------");
	print("--Counter Strike 1.0 by Risen--");
	print("-------------------------------");
	
	Enable_OnPlayerKey(1);
	gui_Init(true);
	
	InitCounterStrike();
	InitCounterStrikePlayers();
	InitTeams();
	InitLanguages();
	InitMenus();
end

function BE_OnPlayerConnect(playerid)
	SetPlayerColor(playerid,255,255,255);
end

function BE_OnPlayerDisconnect(playerid, reason)

end

function OnPlayerChangeClass(playerid, classid)

	SpawnPlayer(playerid);
end

function BE_OnPlayerSpawn(playerid, classid)

	if CSPlayer[playerid].activeInGame == false then
		ShowSelectionLanguage(playerid);
	end
end

function BE_OnPlayerDeath(playerid, p_classID, killerid, k_classID)

	if CSPlayer[playerid].alive == true then
		CSPlayer[playerid].alive = false;
	end
end

function BE_OnPlayerCommandText(playerid, cmdtext)

	if cmdtext == "/h" then
	
		SetPlayerMaxHealth(playerid,999999);
		SetPlayerHealth(playerid,999999);
		
	elseif cmdtext == "/test" then
	
		SetPlayerStrength(playerid,100);
		GiveItem(playerid,"ITMW_SHORTSWORD4",1);
		GiveItem(playerid,"ITRW_CROSSBOW_L_02",1);
		GiveItem(playerid,"ITRW_BOLT",1);
		
	elseif cmdtext == "/p" then
	
		CSPlayer[playerid].activeInGame = true;
		SetPlayerPos(playerid,BanditSpawn[1][1],BanditSpawn[1][2],BanditSpawn[1][3]);
		print(GetFirstFreeSpawn("Bandit"));

		ShowDraw(0,lolek);
		
	elseif cmdtext == "/bs" then
	
		local x,y,z = GetPlayerPos(playerid);
		Vob.Create("ItMi_Head_Bloodwyn_01.3ds","NEWWORLD\\NEWWORLD.ZEN",x,y,z);
	
		for i = 1, 16 do 
		
			Vob.Create("NW_HARBOUR_CANON_01.3DS","NEWWORLD\\NEWWORLD.ZEN",BanditSpawn[i][1],BanditSpawn[i][2],BanditSpawn[i][3]); --static method
		end
		
	elseif cmdtext == "/ps" then
	
		for i = 1, 16 do 
		
			Vob.Create("NW_HARBOUR_CANON_01.3DS","NEWWORLD\\NEWWORLD.ZEN",PaladinSpawn[i][1],PaladinSpawn[i][2],PaladinSpawn[i][3]); --static method
		end
	
	elseif cmdtext == "/cam" then
	
		local x,y,z = GetPlayerPos(playerid);
		local angle = GetPlayerAngle(playerid);
		local distance = 100;
		
		VobCamera = Vob.Create("",GetPlayerWorld(playerid),x,y,z);
		
		x = x + (math.sin(angle * 3.14 / 180.0) * distance);
		z = z + (math.cos(angle * 3.14 / 180.0) * distance);
	
		VobCamera:SetPosition(x,y,z);
		VobCamera:SetRotation(0,angle + 180,0);
		SetCameraBehindVob(playerid,VobCamera);
		
	elseif cmdtext == "/d" then
		
		SetDefaultCamera(playerid);
		switchGUIMenuUp(playerid,"SELECTION_TEAM_EN");
		
	elseif cmdtext == "/s" then
	
		local x,y,z = GetPlayerPos(playerid);
		local angle = GetPlayerAngle(playerid);
		
		local file = io.open("positions.txt","a+");          
        file:write(x .. "," .. y .. "," .. z .. "," .. angle .. "\n");             
        file:close();
		
		local vob = Vob.Create("NW_HARBOUR_CANON_01.3DS","NEWWORLD\\NEWWORLD.ZEN",x,y,z); --static method
		vob:SetRotation(0,angle + 180,0);
		
		SetPlayerPos(playerid,x,y + 200,z);
	
	elseif cmdtext == "/w" then	
		SetPlayerWorld(playerid,"OLDWORLD\\OLDWORLD.ZEN","WP_INTRO13");
		
	end
end

function OnPlayerWeaponMode(playerid, weaponmode)

	if weaponmode ~= WEAPON_NONE and weaponmode ~= WEAPON_FIST and weaponmode ~= WEAPON_BOW then
		
		SetPlayerWeaponMode(playerid,WEAPON_NONE);
		SendPlayerMessage(playerid,255,255,0,Language[CSPlayer[playerid].langID]["WR_N1"]);
	end
end

function BE_OnPlayerChangeDexterity(playerid, currDexterity, oldDexterity)

end

function BE_OnPlayerChangeGold(playerid, currGold, oldGold)

end

--Counter Strike Callbacks
function OnPlayerChangeLanguage(playerid, key, keyState, arg)

	FreezePlayer(playerid,1);

	if key == KEY_UP then
		switchGUIMenuUp(playerid,"SELECTION_LANGUAGE");	
	elseif key == KEY_DOWN then
		switchGUIMenuDown(playerid,"SELECTION_LANGUAGE");
	elseif key == KEY_RETURN then
	
		local optionID = getPlayerOptionID(playerid,"SELECTION_LANGUAGE");
		CSPlayer[playerid].langID = optionID - 1;
		HideSelectionLanguage(playerid);
		
		local langID = CSPlayer[playerid].langID;
		SendPlayerMessage(playerid,255,255,0,Language[langID]["INFO_N1"]);
		
		if CSPlayer[playerid].activeInGame == false then
			ShowSelectionTeam(playerid);
		end
	end
end

function OnPlayerChangeTeam(playerid, key, keyState, arg)

	if key == KEY_UP then
		if CSPlayer[playerid].langID == LANG_ENGLISH then
			switchGUIMenuUp(playerid,"SELECTION_TEAM_EN");	
		elseif CSPlayer[playerid].langID == LANG_POLISH then
			switchGUIMenuUp(playerid,"SELECTION_TEAM_PL");
		end
			
	elseif key == KEY_DOWN then
		if CSPlayer[playerid].langID == LANG_ENGLISH then
			switchGUIMenuDown(playerid,"SELECTION_TEAM_EN");	
		elseif CSPlayer[playerid].langID == LANG_POLISH then
			switchGUIMenuDown(playerid,"SELECTION_TEAM_PL");
		end
			
	elseif key == KEY_RETURN then
	
		local optionID;
		if CSPlayer[playerid].langID == LANG_ENGLISH then
			optionID = getPlayerOptionID(playerid,"SELECTION_TEAM_EN");
		elseif CSPlayer[playerid].langID == LANG_POLISH then
			optionID = getPlayerOptionID(playerid,"SELECTION_TEAM_PL");
		end
	
		HideSelectionTeam(playerid);
		
		if optionID == 1 then
			CSPlayer[playerid].team = "Bandit";
			ShowSelectionHero(playerid,"Bandit");
		elseif optionID == 2 then
			CSPlayer[playerid].team = "Paladin";
			ShowSelectionHero(playerid,"Paladin");
		end
	end
end

function OnPlayerChangeHero(playerid, key, keyState, arg)

	if key == KEY_UP then
		if CSPlayer[playerid].langID == LANG_ENGLISH then
			if CSPlayer[playerid].team == "Bandit" then
				switchGUIMenuUp(playerid,"SELECTION_BANDIT_HERO_EN");
				local optionID = getPlayerOptionID(playerid,"SELECTION_BANDIT_HERO_EN");
				if optionID ~= #BanditTeam.Hero + 1 then
					ChangeHero(playerid,"Bandit",optionID);
				end
			elseif CSPlayer[playerid].team == "Paladin" then
				switchGUIMenuUp(playerid,"SELECTION_PALADIN_HERO_EN");
				local optionID = getPlayerOptionID(playerid,"SELECTION_PALADIN_HERO_EN");
				if optionID ~= #PaladinTeam.Hero + 1 then
					ChangeHero(playerid,"Paladin",optionID);
				end
			end	
			
		elseif CSPlayer[playerid].langID == LANG_POLISH then
			if CSPlayer[playerid].team == "Bandit" then
				switchGUIMenuUp(playerid,"SELECTION_BANDIT_HERO_PL");
				local optionID = getPlayerOptionID(playerid,"SELECTION_BANDIT_HERO_PL");
				if optionID ~= #BanditTeam.Hero + 1 then
					ChangeHero(playerid,"Bandit",optionID);
				end
			elseif CSPlayer[playerid].team == "Paladin" then
				switchGUIMenuUp(playerid,"SELECTION_PALADIN_HERO_PL");
				local optionID = getPlayerOptionID(playerid,"SELECTION_PALADIN_HERO_PL");
				if optionID ~= #PaladinTeam.Hero + 1 then
					ChangeHero(playerid,"Paladin",optionID);
				end
			end	
		end
	elseif key == KEY_DOWN then
		if CSPlayer[playerid].langID == LANG_ENGLISH then
			if CSPlayer[playerid].team == "Bandit" then
				switchGUIMenuDown(playerid,"SELECTION_BANDIT_HERO_EN");
				local optionID = getPlayerOptionID(playerid,"SELECTION_BANDIT_HERO_EN");
				if optionID ~= #BanditTeam.Hero + 1 then
					ChangeHero(playerid,"Bandit",optionID);
				end
			elseif CSPlayer[playerid].team == "Paladin" then
				switchGUIMenuDown(playerid,"SELECTION_PALADIN_HERO_EN");
				local optionID = getPlayerOptionID(playerid,"SELECTION_PALADIN_HERO_EN");
				if optionID ~= #PaladinTeam.Hero + 1 then
					ChangeHero(playerid,"Paladin",optionID);
				end
			end	
			
		elseif CSPlayer[playerid].langID == LANG_POLISH then
			if CSPlayer[playerid].team == "Bandit" then
				switchGUIMenuDown(playerid,"SELECTION_BANDIT_HERO_PL");
				local optionID = getPlayerOptionID(playerid,"SELECTION_BANDIT_HERO_PL");
				if optionID ~= #BanditTeam.Hero + 1 then
					ChangeHero(playerid,"Bandit",optionID);
				end
			elseif CSPlayer[playerid].team == "Paladin" then
				switchGUIMenuDown(playerid,"SELECTION_PALADIN_HERO_PL");
				local optionID = getPlayerOptionID(playerid,"SELECTION_PALADIN_HERO_PL");
				if optionID ~= #PaladinTeam.Hero + 1 then
					ChangeHero(playerid,"Paladin",optionID);
				end
			end	
		end
	
	elseif key == KEY_RETURN then
	
		if CSPlayer[playerid].langID == LANG_ENGLISH then
			if CSPlayer[playerid].team == "Bandit" then
				local optionID = getPlayerOptionID(playerid,"SELECTION_BANDIT_HERO_EN");
				HideSelectionHero(playerid);
				if optionID == #BanditTeam.Hero + 1 then
					ShowSelectionTeam(playerid);
				else
					SelectHero(playerid,CSPlayer[playerid].team,optionID);
				end
			elseif CSPlayer[playerid].team == "Paladin" then
				local optionID = getPlayerOptionID(playerid,"SELECTION_PALADIN_HERO_EN");
				HideSelectionHero(playerid);
				if optionID == #PaladinTeam.Hero + 1 then
					ShowSelectionTeam(playerid);
				else
					SelectHero(playerid,CSPlayer[playerid].team,optionID);
				end
			end
			
		elseif CSPlayer[playerid].langID == LANG_POLISH then
			if CSPlayer[playerid].team == "Bandit" then
				local optionID = getPlayerOptionID(playerid,"SELECTION_BANDIT_HERO_PL");
				HideSelectionHero(playerid);
				if optionID == #BanditTeam.Hero + 1 then
					ShowSelectionTeam(playerid);
				else
					SelectHero(playerid,CSPlayer[playerid].team,optionID);
				end
			elseif CSPlayer[playerid].team == "Paladin" then
				local optionID = getPlayerOptionID(playerid,"SELECTION_PALADIN_HERO_PL");
				HideSelectionHero(playerid);
				if optionID == #PaladinTeam.Hero + 1 then
					ShowSelectionTeam(playerid);
				else
					SelectHero(playerid,CSPlayer[playerid].team,optionID);
				end
			end
		end
	end
end

--Game timer tick
function OnGameTick()
	
	--[[for i = 0, GetMaxPlayers() - 1 do
		if CSPlayer[i].activeInGame == false then
			FreezePlayer(i,1);
			setCameraBeforePlayer(i,100);
		end
	end]]--
	
	--Init Draws
	if CSGame.initiatedDraws == false then
		InitDraws();
	end
	
	if CSGame.awaitingForStart == true then

		CSGame.timeAwaitingForStart  = CSGame.timeAwaitingForStart - 1;
		
		if CSGame.timeAwaitingForStart >= 0 then
			for i = 0, GetMaxPlayers() - 1 do
				if CSPlayer[i].activeInGame == true then
					FreezePlayer(i,1);
					SetPlayerWeaponMode(i,WEAPON_BOW);
				
					local langID = CSPlayer[i].langID;
				
					local langWord;
					if CSGame.timeAwaitingForStart == 1 then
						langWord = Language[langID]["CT_N4"];
					elseif CSGame.timeAwaitingForStart >= 2 and CSGame.timeAwaitingForStart <= 4 then
						if langID == LANG_POLISH then
							langWord = Language[langID]["CT_N3"];
						else
							langWord = Language[langID]["CT_N2"];
						end
					else
						langWord = Language[langID]["CT_N2"];
					end
					
					GameTextForPlayer(i,3000,3000,Language[langID]["CT_N1"] .. " " .. CSGame.timeAwaitingForStart .. " " .. langWord,"Font_Old_20_White_Hi.TGA",255,255,0,1500);
				end
			end
		else
			for i = 0, GetMaxPlayers() - 1 do
				if CSPlayer[i].activeInGame == true then
					FreezePlayer(i,0);
					SetPlayerWeaponMode(i,WEAPON_BOW);
					
					local langID = CSPlayer[i].langID;
					
					if CSPlayer[i].team == "Bandit" then
						GameTextForPlayer(i,2000,3000,Language[langID]["CT_N5"],"Font_Old_10_White_Hi.TGA",0,255,0,6000);
					elseif CSPlayer[i].team == "Paladin" then
						GameTextForPlayer(i,2000,3000,Language[langID]["CT_N6"],"Font_Old_10_White_Hi.TGA",0,255,0,6000);
					end
				end
			end
			
			CSGame.awaitingForStart = false;
			StartRound();			
		end
		
	elseif CSGame.roundStarted == true then
	
		if CSGame.timeSecondRound > 0 then
			
			CSGame.timeSecondRound = CSGame.timeSecondRound - 1;
			
			if CSGame.timeMinuteRound == 0 and CSGame.timeSecondRound == 0 then
				CSGame.roundStarted = false;
				print("Time is up");
			end
		else
			
			if CSGame.timeMinuteRound > 0 then
				CSGame.timeMinuteRound = CSGame.timeMinuteRound - 1;
				CSGame.timeSecondRound = TIME_SECOND_ROUND;
			end
		end
		
		local countingTimeString = string.format("%02d:%02d",CSGame.timeMinuteRound,CSGame.timeSecondRound);
		UpdateDraw(CSGame.countingTimeDraw,6000,6000,countingTimeString,"Font_Old_10_White_Hi.TGA",255,255,0);
	end
end


--Counter Strike Functions
function InitCounterStrike()

	CSGame.timerTick = SetTimer("OnGameTick",1000,1);
	
	CSGame.initiatedDraws = false;
	
	CSGame.awaitingForStart = false;
	CSGame.timeAwaitingForStart = TIME_AWAITING_FOR_START;
	
	CSGame.roundStarted = false;
	CSGame.timeMinuteRound = TIME_MINUTE_ROUND;
	CSGame.timeSecondRound = TIME_SECOND_ROUND;
end

function InitCounterStrikePlayers()

	for i = 0, GetMaxPlayers() - 1 do
		
		CSPlayer[i] = {};
	
		CSPlayer[i].activeInGame = false;
		CSPlayer[i].alive = false;
		CSPlayer[i].langID = 1; --English default
		CSPlayer[i].team = "Bandit" --default
		CSPlayer[i].heroID = 0;
	end
end

function InitDraws()

	CSGame.initiatedDraws = true;
	CSGame.countingTimeDraw = CreateDraw(6000,6000,"DRAW FOR COUNTING","Font_Old_10_White_Hi.TGA",255,255,0);
end

function InitTeams()
	
	CreateBanditTeam();
	CreatePaladinTeam();
end

function InitLanguages()

	Language[0] = {};
	Language[0]["INFO_N1"] = "(Info) Counter-Strike is powered by Bimbol Engine :)";
	Language[0]["WR_N1"] = "WARNING: You can carry only bow!";
	Language[0]["CT_N1"] = "Start for";
	Language[0]["CT_N2"] = "seconds...";
	Language[0]["CT_N4"] = "second...";
	Language[0]["CT_N5"] = "Start! Destroy the altar in the hanged square by planting a bomb!";
	Language[0]["CT_N6"] = "Start! Defend the altar in the hanged square from bandits!";
	
	Language[1] = {};
	Language[1]["INFO_N1"] = "(Info) Counter-Strike jest napêdzany przez Bimbol Engine :)";
	Language[1]["WR_N1"] = "Ostrze¿enie: Mo¿esz nosiæ tylko ³uk!";
	Language[1]["CT_N1"] = "Rozpoczêcie za";
	Language[1]["CT_N2"] = "sekund...";
	Language[1]["CT_N3"] = "sekundy...";
	Language[1]["CT_N4"] = "sekundê...";
	Language[1]["CT_N5"] = "Start! Zniszcz o³tarz na placu wisielców podk³adaj¹c bombê!";
	Language[1]["CT_N6"] = "Start! Obroñ o³tarz na placu wisielców przed bandytami!";
end

function InitMenus()

	createGUIMenu("SELECTION_LANGUAGE",
		{
			{"English"},
			{"Polski"},
		},
		255,255,255,
		0,220,0,
		5500,4000,
		"Font_Old_10_White_Hi.TGA",nil,2);
	
	--Select team EN
	createGUIMenu("SELECTION_TEAM_EN",
		{
			{"Bunch of Thugs"},  --Bandit
			{"Royal Army"},      --Paladin
		}, 
		255,255,255,
		0,220,0,
		5500,4000,
		"Font_Old_10_White_Hi.TGA",nil,2);
	
	--Select team PL
	createGUIMenu("SELECTION_TEAM_PL",
		{
			{"Banda Zbirów"},     --Bandit
			{"Armia Królewska"},  --Paladin
		}, 
		255,255,255,
		0,220,0,
		5500,4000,
		"Font_Old_10_White_Hi.TGA",nil,2);
	
	--Select bandit hero EN
	createGUIMenu("SELECTION_BANDIT_HERO_EN",
		{
			{"Ripper"},
			{"Madman"}, 
			{"<- Back"},
		}, 
		255,255,255,
		0,220,0,
		5500,4000,
		"Font_Old_10_White_Hi.TGA",nil,3);
		
	--Select bandit hero PL
	createGUIMenu("SELECTION_BANDIT_HERO_PL",
		{
			{"Rozpruwacz"},
			{"Szaleniec"},
			{"<- Wróæ"},
		}, 
		255,255,255,
		0,220,0,
		5500,4000,
		"Font_Old_10_White_Hi.TGA",nil,3);
		
	--Select paladin hero EN
	createGUIMenu("SELECTION_PALADIN_HERO_EN",
		{
			{"Royal Knight"},
			{"Royal Paladin"},
			{"Royal Guard"},
			{"Royal Officer"},
			{"<- Back"},
		}, 
		255,255,255,
		0,220,0,
		5500,4000,
		"Font_Old_10_White_Hi.TGA",nil,5);
		
	--Select paladin hero PL
	createGUIMenu("SELECTION_PALADIN_HERO_PL",
		{
			{"Królewski Rycerz"},
			{"Królewski Paladyn"},
			{"Królewski Stra¿nik"},
			{"Królewski Oficer"},
			{"<- Wróæ"},
		}, 
		255,255,255,
		0,220,0,
		5500,4000,
		"Font_Old_10_White_Hi.TGA",nil,5);
end


function CreateBanditTeam()

	BanditTeam.TeamName = "Bandit";
	BanditTeam.Hero = {};
	
	CreateHero("Bandit","Ripper",200,"Hum_Body_Naked0",3,"Hum_Head_Psionic",59,"ITRW_BOW_M_02","ITAR_DJG_H");
	CreateHero("Bandit","Madman",375,"Hum_Body_Naked0",3,"Hum_Head_Psionic",59,"ITRW_BOW_M_02","ITAR_SLD_H");
end

function CreatePaladinTeam()

	PaladinTeam.TeamName = "Paladin";
	PaladinTeam.Hero = {};
	
	CreateHero("Paladin","Royal Knight",300,"Hum_Body_Naked0",3,"Hum_Head_Psionic",59,"ITRW_BOW_M_02","ITAR_PAL_M");
	CreateHero("Paladin","Royal Paladin",200,"Hum_Body_Naked0",3,"Hum_Head_Psionic",59,"ITRW_BOW_M_02","ITAR_PAL_H");
	CreateHero("Paladin","Royal Guard",480,"Hum_Body_Naked0",3,"Hum_Head_Psionic",59,"ITRW_BOW_M_02","ITAR_MIL_L");
	CreateHero("Paladin","Royal Officer",420,"Hum_Body_Naked0",3,"Hum_Head_Psionic",59,"ITRW_BOW_M_02","ITAR_MIL_M");
end

function CreateHero(teamName, heroName, maxHealth, bodyModel, bodyTextureID, headModel, headTextureID, gun, armor)

	local Hero = {};
	Hero.heroName = heroName;
	Hero.maxHealth = maxHealth;
	Hero.bodyModel = bodyModel;
	Hero.bodyTextureID = bodyTextureID;
	Hero.headModel = headModel;
	Hero.headTextureID = headTextureID;
	Hero.gun = gun;
	Hero.armor = armor;

	if teamName == "Bandit" then
		table.insert(BanditTeam.Hero,Hero);
	elseif teamName == "Paladin" then
		table.insert(PaladinTeam.Hero,Hero);
	end
end

function ShowSelectionLanguage(playerid)

	SetPlayerVirtualWorld(playerid,playerid + 1);
	
	SetPlayerPos(playerid,SelectionPos[1],SelectionPos[2] + 100,SelectionPos[3]);
	SetPlayerAngle(playerid,SelectionPos[4]);

	bindKey(playerid,KEY_UP,"DOWN",OnPlayerChangeLanguage,"N");
    bindKey(playerid,KEY_DOWN,"DOWN",OnPlayerChangeLanguage,"N");
	bindKey(playerid,KEY_RETURN,"DOWN",OnPlayerChangeLanguage,"N");
	
	showGUIMenu(playerid,"SELECTION_LANGUAGE");
end

function HideSelectionLanguage(playerid)

	removeKey(playerid,KEY_UP,"DOWN");
	removeKey(playerid,KEY_DOWN,"DOWN");
	removeKey(playerid,KEY_RETURN,"DOWN");
	
	hideGUIMenu(playerid,"SELECTION_LANGUAGE");
end

function ShowSelectionTeam(playerid)

	SetPlayerPos(playerid,SelectionPos[1],SelectionPos[2],SelectionPos[3]);
	SetPlayerAngle(playerid,SelectionPos[4]);

	bindKey(playerid,KEY_UP,"DOWN",OnPlayerChangeTeam,"N");
    bindKey(playerid,KEY_DOWN,"DOWN",OnPlayerChangeTeam,"N");
	bindKey(playerid,KEY_RETURN,"DOWN",OnPlayerChangeTeam,"N");
	
	if CSPlayer[playerid].langID == LANG_ENGLISH then
		showGUIMenu(playerid,"SELECTION_TEAM_EN");
	elseif CSPlayer[playerid].langID == LANG_POLISH then
		showGUIMenu(playerid,"SELECTION_TEAM_PL");
	end
end

function HideSelectionTeam(playerid)
	
	removeKey(playerid,KEY_UP,"DOWN");
	removeKey(playerid,KEY_DOWN,"DOWN");
	removeKey(playerid,KEY_RETURN,"DOWN");
	
	if CSPlayer[playerid].langID == LANG_ENGLISH then
		hideGUIMenu(playerid,"SELECTION_TEAM_EN");
	elseif CSPlayer[playerid].langID == LANG_POLISH then
		hideGUIMenu(playerid,"SELECTION_TEAM_PL");
	end
end

function ShowSelectionHero(playerid, teamName)

	SetPlayerPos(playerid,SelectionPos[1],SelectionPos[2],SelectionPos[3]);
	SetPlayerAngle(playerid,SelectionPos[4]);
	--FreezePlayer(playerid,1);
	--setCameraBeforePlayer(playerid, 200);
	
	bindKey(playerid,KEY_UP,"DOWN",OnPlayerChangeHero,"N");
    bindKey(playerid,KEY_DOWN,"DOWN",OnPlayerChangeHero,"N");
	bindKey(playerid,KEY_RETURN,"DOWN",OnPlayerChangeHero,"N");
	
	local optionID;
	
	if teamName == "Bandit" then
		if CSPlayer[playerid].langID == LANG_ENGLISH then
			showGUIMenu(playerid,"SELECTION_BANDIT_HERO_EN");
			optionID = getPlayerOptionID(playerid,"SELECTION_BANDIT_HERO_EN");
		elseif CSPlayer[playerid].langID == LANG_POLISH then
			showGUIMenu(playerid,"SELECTION_BANDIT_HERO_PL");
			optionID = getPlayerOptionID(playerid,"SELECTION_BANDIT_HERO_PL");
		end
	
		ChangeHero(playerid,"Bandit",optionID);
		
	elseif teamName == "Paladin" then
		if CSPlayer[playerid].langID == LANG_ENGLISH then
			showGUIMenu(playerid,"SELECTION_PALADIN_HERO_EN");
			optionID = getPlayerOptionID(playerid,"SELECTION_PALADIN_HERO_EN");
		elseif CSPlayer[playerid].langID == LANG_POLISH then
			showGUIMenu(playerid,"SELECTION_PALADIN_HERO_PL");
			optionID = getPlayerOptionID(playerid,"SELECTION_PALADIN_HERO_PL");
		end
	
		ChangeHero(playerid,"Paladin",optionID);
	end
end

function HideSelectionHero(playerid)

	removeKey(playerid,KEY_UP,"DOWN");
	removeKey(playerid,KEY_DOWN,"DOWN");
	removeKey(playerid,KEY_RETURN,"DOWN");
	
	if CSPlayer[playerid].team == "Bandit" then
		if CSPlayer[playerid].langID == LANG_ENGLISH then
			hideGUIMenu(playerid,"SELECTION_BANDIT_HERO_EN");
		elseif CSPlayer[playerid].langID == LANG_POLISH then
			hideGUIMenu(playerid,"SELECTION_BANDIT_HERO_PL");
		end
		
	elseif CSPlayer[playerid].team == "Paladin" then
		if CSPlayer[playerid].langID == LANG_ENGLISH then
			hideGUIMenu(playerid,"SELECTION_PALADIN_HERO_EN");
		elseif CSPlayer[playerid].langID == LANG_POLISH then
			hideGUIMenu(playerid,"SELECTION_PALADIN_HERO_PL");
		end
	end
end

function ChangeHero(playerid, teamName, heroID)
	
	ClearInventory(playerid);
	GiveItem(playerid,"ITRW_ARROW",9999);
	SetPlayerStrength(playerid,10);
	SetPlayerDexterity(playerid,200);
	SetPlayerSkillWeapon(playerid,SKILL_BOW,100);
	
	if teamName == "Bandit" then
		SetPlayerMaxHealth(playerid,BanditTeam.Hero[heroID].maxHealth);
		SetPlayerHealth(playerid,BanditTeam.Hero[heroID].maxHealth);
		SetPlayerAdditionalVisual(playerid,BanditTeam.Hero[heroID].bodyModel,BanditTeam.Hero[heroID].bodyTextureID,BanditTeam.Hero[heroID].headModel,BanditTeam.Hero[heroID].headTextureID);
		EquipRangedWeapon(playerid,BanditTeam.Hero[heroID].gun);
		EquipArmor(playerid,BanditTeam.Hero[heroID].armor);
		
	elseif teamName == "Paladin" then
		SetPlayerMaxHealth(playerid,PaladinTeam.Hero[heroID].maxHealth);
		SetPlayerHealth(playerid,PaladinTeam.Hero[heroID].maxHealth);
		SetPlayerAdditionalVisual(playerid,PaladinTeam.Hero[heroID].bodyModel,PaladinTeam.Hero[heroID].bodyTextureID,PaladinTeam.Hero[heroID].headModel,PaladinTeam.Hero[heroID].headTextureID);
		EquipRangedWeapon(playerid,PaladinTeam.Hero[heroID].gun);
		EquipArmor(playerid,PaladinTeam.Hero[heroID].armor);
	end
end

function SelectHero(playerid, teamName, heroID)

	CSPlayer[playerid].activeInGame = true;
	SetPlayerVirtualWorld(playerid,MAIN_WORLD);
	
	if teamName == "Bandit" then
		SetPlayerColor(playerid,0,200,255);
	elseif teamName == "Paladin" then
		SetPlayerColor(playerid,0,255,0);
	end

	if CSGame.roundStarted == false then
		if teamName == "Bandit" then
			SetRandomSpawn(playerid,teamName);
		elseif teamName == "Paladin" then
			SetRandomSpawn(playerid,teamName);
		end
	else
		SendPlayerMessage(playerid,255,0,0,"Can not join to game. Round started...");
	end
	
	if CSGame.awaitingForStart == false and CSGame.roundStarted == false then
		DoAwaitingForStart();
	end
end

function SetRandomSpawn(playerid, teamName)

	CSPlayer[playerid].alive = true;
	SetDefaultCamera(playerid);

	if teamName == "Bandit" then
		
		local index = random(16) + 1;
		if IsSpawnFree(BanditSpawn[index][1],BanditSpawn[index][2],BanditSpawn[index][3]) == true then
			SetPlayerPos(playerid,BanditSpawn[index][1],BanditSpawn[index][2] + 100,BanditSpawn[index][3]);
			SetPlayerAngle(playerid,BanditSpawn[index][4]);
		else
			local x,y,z,a = GetFirstFreeSpawn("Bandit");
			SetPlayerPos(playerid,x,y + 100,z);
			SetPlayerAngle(playerid,a);
		end
		
	elseif teamName == "Paladin" then
		
		local index = random(16) + 1;
		if IsSpawnFree(PaladinSpawn[index][1],PaladinSpawn[index][2],PaladinSpawn[index][3]) == true then
			SetPlayerPos(playerid,PaladinSpawn[index][1],PaladinSpawn[index][2] + 100,PaladinSpawn[index][3]);
			SetPlayerAngle(playerid,PaladinSpawn[index][4]);
		else
			local x,y,z,a = GetFirstFreeSpawn("Paladin");
			SetPlayerPos(playerid,x,y + 100,z);
			SetPlayerAngle(playerid,a);
		end
	end
end

function IsSpawnFree(x, y, z)
	
	for i = 0, GetMaxPlayers() - 1 do
		local pX,pY,pZ = GetPlayerPos(i);
		if GetDistance3D(x,y,z,pX,pY,pZ) <= 30 then
			return false;
		end
	end
	
	return true;
end

function GetFirstFreeSpawn(teamName)

	if teamName == "Bandit" then
		for i = 1, #BanditSpawn do
			for j = 0, GetMaxPlayers() - 1 do
				local pX,pY,pZ = GetPlayerPos(j);
				if GetDistance3D(pX,pY,pZ,BanditSpawn[i][1],BanditSpawn[i][2],BanditSpawn[i][3]) <= 30 then
						break;
				elseif j == GetMaxPlayers() - 1 and GetDistance3D(pX,pY,pZ,BanditSpawn[i][1],BanditSpawn[i][2],BanditSpawn[i][3]) > 30 then
					return BanditSpawn[i][1],BanditSpawn[i][2],BanditSpawn[i][3],BanditSpawn[i][4];
				end
			end
		end
	elseif teamName == "Paladin" then
		for i = 1, #PaladinSpawn do
			for j = 0, GetMaxPlayers() - 1 do
				local pX,pY,pZ = GetPlayerPos(j);
				if GetDistance3D(pX,pY,pZ,PaladinSpawn[i][1],PaladinSpawn[i][2],PaladinSpawn[i][3]) <= 30 then
					break;
				elseif j == GetMaxPlayers() - 1 and GetDistance3D(pX,pY,pZ,PaladinSpawn[i][1],PaladinSpawn[i][2],PaladinSpawn[i][3]) > 30 then
					return PaladinSpawn[i][1],PaladinSpawn[i][2],PaladinSpawn[i][3],PaladinSpawn[i][4];
				end
			end
		end
	end
	
	return nil;
end

function DoAwaitingForStart()
	
	CSGame.awaitingForStart = true;
	CSGame.timeAwaitingForStart = TIME_AWAITING_FOR_START;
	
	for i = 0, GetMaxPlayers() - 1 do
		if CSPlayer[i].activeInGame == true then
			FreezePlayer(i,0);
			SetPlayerWeaponMode(i,WEAPON_BOW);
		
			local langID = CSPlayer[i].langID;
				
			local langWord;
			if CSGame.timeAwaitingForStart == 1 then
				langWord = Language[langID]["CT_N4"];
			elseif CSGame.timeAwaitingForStart >= 2 and CSGame.timeAwaitingForStart <= 4 then
				langWord = Language[langID]["CT_N3"];
			else
				langWord = Language[langID]["CT_N2"];
			end
				
			GameTextForPlayer(i,3000,3000,Language[langID]["CT_N1"] .. " " .. CSGame.timeAwaitingForStart .. " " .. langWord,"Font_Old_20_White_Hi.TGA",255,255,0,1500);
		end
	end
end

	--[[Language[0]["INFO_N1"] = "(Info) Counter-Strike is powered by Bimbol Engine :)";
	Language[0]["WR_N1"] = "WARNING: You can carry only bow!";
	Language[0]["CT_N1"] = "Start for";
	Language[0]["CT_N2"] = "seconds...";
	Language[0]["CT_N3"] = "second...";
	Language[0]["CT_N5"] = "Start! Destroy the altar in the hanged square by planting a bomb!";
	Language[0]["CT_N6"] = "Start! Defend the altar in the hanged square from bandits!";
	
	Language[1] = {};
	Language[1]["INFO_N1"] = "(Info) Counter-Strike jest napêdzany przez Bimbol Engine :)";
	Language[1]["WR_N1"] = "Ostrze¿enie: Mo¿esz nosiæ tylko ³uk!";
	Language[1]["CT_N1"] = "Rozpoczêcie za";
	Language[1]["CT_N2"] = "sekund...";
	Language[1]["CT_N3"] = "sekundy...";
	Language[1]["CT_N4"] = "sekundê...";
	Language[1]["CT_N5"] = "Start! Zniszcz o³tarz na placu wisielców podk³adaj¹c bombê!";
	Language[1]["CT_N6"] = "Start! Obroñ o³tarz na placu wisielców przed bandytami!";]]--

function StartRound()

	CSGame.awaitingForStart = false;
	CSGame.roundStarted = true;
	CSGame.timeMinuteRound = TIME_MINUTE_ROUND;
	CSGame.timeSecondRound = TIME_SECOND_ROUND;
	
	local countingTimeString = string.format("%02d:%02d",CSGame.timeMinuteRound,CSGame.timeSecondRound);
	UpdateDraw(CSGame.countingTimeDraw,6000,6000,countingTimeString,"Font_Old_10_White_Hi.TGA",255,255,0);
	
	for i = 0, GetMaxPlayers() - 1 do
		if CSPlayer[i].activeInGame == true then
			ShowDraw(i,CSGame.countingTimeDraw);
		end
	end
end