local SPAWN_ZOMBIE = 8;
local SpawnZombie = 
{
    --x, y, z, angle
	{5587.17,367.20,-5857.20,76}, --1	
	{6380.95,368.20,-3531.90,120},--2
	{8571.92,368.20,-5834.56,309}, --3
	{8461.10,368.25,-3832.24,218}, --4
	{6131.65,368.25,-4315.43,81}, --5
	{7715.59,368.10,-3396.38,241}, --6
	{8049.91,368.20,-6227.58,2}, --7
	{7653.45,368.20,-3988.10,139} --8
}

local SPAWN_HUMAN = 5;
local SpawnHuman = 
{
	--x, y, z, angle
	{12467.02,998.20,-2261.10,223}, --1
	{13221.27,998.20,-3018.44,273}, --2
	{11435.20,998.20,-3104.30,76}, --3
	{11826.88,998.20,-3812.57,24}, --4
	{14046.03,1187.80,-1371.67,226} --5
}

--Sound dead human
local SND_DEAD_HUMAN = 8;
local SoundDeadHuman;

--Sound kill zombie by human
local SND_KILL_HUMAN = 15;
local SoundKillHuman;

--Sound kill human by zombie
local SND_KILL_ZOMBIE = 3
local SoundKillZombie;

--Sound game
local SND_GAME = 3;
local SoundGame;

local TEAM_ZOMBIE = 0;
local TEAM_HUMAN = 1;

local MAX_PLAYERS = GetMaxPlayers();
local MAX_PLAYER_FIELD = 2;
local Player;

local AWAIT_MINUTE = 0; --0
local AWAIT_SECOND = 59; --59;

local ROUND_MINUTE = 4; --4;
local ROUND_SECOND = 59; --59;

function OnGamemodeInit()
	
	print("---------------------------");
	print("Zombie mode by Risen loaded");
	print("---------------------------");
	
	--Gamemode name
	SetGamemodeName("Wave of zombies 1.0");
	
	--Zombie team
	AddPlayerClass("ZOMBIE01",908.29,612.60,-6670.21,0,0,0,0,0); --0
	AddPlayerClass("ZOMBIE02",908.29,612.60,-6670.21,0,0,0,0,0); --1
	AddPlayerClass("ZOMBIE03",908.29,612.60,-6670.21,0,0,0,0,0); --2
	AddPlayerClass("ZOMBIE04",908.29,612.60,-6670.21,0,0,0,0,0); --3
	
	--Human team
	AddPlayerClass("PC_HERO",2492.85,802.80,-872.84,120,0,0,0,0); --4 pirate
	AddPlayerClass("PC_HERO",2492.85,802.80,-872.84,120,0,0,0,0); --5 dragon hunter
	AddPlayerClass("PC_HERO",2492.85,802.80,-872.84,120,0,0,0,0); --6 knight
	AddPlayerClass("PC_HERO",2492.85,802.80,-872.84,120,0,0,0,0); --7 acrobat
	
	--Init
	InitPlayer();
	InitGame();
	InitSoundGame();
	InitSoundDeadHuman();
	InitSoundKillHuman();
	InitSoundKillZombie();
end

function OnGamemodeExit()

	print("--------------------");
	print("Zombie mode unloaded");
	print("--------------------");
end

function OnPlayerChangeClass(playerid, classid)
	
	Player[playerid].cid = -1;
	
	if classid == 0
	then
		GameTextForPlayer(playerid,3200,3500,"Zombie Fighter","Font_Old_20_White_Hi.TGA",255,0,0,1000);
		Zombie01(playerid,false);
	elseif classid == 1
	then
		GameTextForPlayer(playerid,3200,3500,"Zombie Voodoo","Font_Old_20_White_Hi.TGA",255,0,0,1000);
		Zombie01(playerid,false);
	elseif classid == 2
	then
		GameTextForPlayer(playerid,3200,3500,"Zombie Hobgoblin","Font_Old_20_White_Hi.TGA",255,0,0,1000);
		Zombie01(playerid,false);
	elseif classid == 3
	then
		GameTextForPlayer(playerid,3200,3500,"Zombie Nazi","Font_Old_20_White_Hi.TGA",255,0,0,1000);
		Zombie01(playerid,false);
		
	--Human team
	elseif classid == 4 --pirate
	then
	    GameTextForPlayer(playerid,3500,3500,"Pirate","Font_Old_20_White_Hi.TGA",0,255,0,1000);
		Pirate(playerid,false);
		
	elseif classid == 5 --dragon hunter
	then
	    GameTextForPlayer(playerid,3200,3500,"Dragon Hunter","Font_Old_20_White_Hi.TGA",0,255,0,1000);
		DragonHunter(playerid,false);
	
	elseif classid == 6 --knight
	then
	    GameTextForPlayer(playerid,3500,3500,"Knight","Font_Old_20_White_Hi.TGA",0,255,0,1000);
	    Knight(playerid,false);
		
	elseif classid == 7 --acrobat
	then
	    GameTextForPlayer(playerid,3500,3500,"Acrobat","Font_Old_20_White_Hi.TGA",0,255,0,1000);
		Acrobat(playerid,false);
	end
end

function OnPlayerSelectClass(playerid, classid)
	
	Player[playerid].cid = classid;
	
	if Player[playerid].cid >= 0 and Player[playerid].cid <= 3
	then
		Player[playerid].team = TEAM_ZOMBIE;
		
	elseif Player[playerid].cid >= 4 and Player[playerid].cid <= 7
	then
		Player[playerid].team = TEAM_HUMAN;
	end
end

function OnPlayerConnect(playerid)
	
	local hello = "----====Zombie Mode 0.1 by Risen====----";
	
	local rand = random(5);
	if rand == 0 then
		SendPlayerMessage(playerid,0,255,0,hello);
	elseif rand == 1 then
		SendPlayerMessage(playerid,255,255,0,hello);
	elseif rand == 2 then
		SendPlayerMessage(playerid,255,0,255,hello);
	elseif rand == 3 then
		SendPlayerMessage(playerid,255,0,255,hello);
	elseif rand == 4 then
		SendPlayerMessage(playerid,0,255,255,hello);
	end
	
	SendMessageToAll(0,255,0,string.format("%s (ID: %d) %s",GetPlayerName(playerid),playerid,"connected to server."));
		
	ShowDraw(playerid,Game.draw_timer);
	ShowDraw(playerid,Game.draw_zombies);
	ShowDraw(playerid,Game.draw_humans);
	ShowDraw(playerid,Game.draw_round);
end

function OnPlayerDisconnect(playerid)
	
	SendMessageToAll(0,255,0,string.format("%s (ID: %d) %s",GetPlayerName(playerid),playerid,"disconnected from server."));
	
	Player[playerid].team = -1;
	Player[playerid].cid = -1;
	Player[playerid].first_spawn = false;
end

function OnPlayerSpawn(playerid, classid)

	if Player[playerid].first_spawn == false
	then
		PlayPlayerSound(playerid,SoundGame[0]);
		Player[playerid].first_spawn = true;
	end

	if Game.started == true
	then
		if Player[playerid].team == TEAM_HUMAN then
			GameTextForPlayer(playerid,1500,3000,"Too late! You joined to the Zombie Team.","Font_Old_20_White_Hi.TGA",255,0,0,5000);
		end
		RandomSpawnZombie(playerid);
		Zombie(playerid,true);
	else
		if Player[playerid].team == TEAM_ZOMBIE then
			GameTextForPlayer(playerid,250,3000,"Round has not else started. You joined to the Human Team.","Font_Old_20_White_Hi.TGA",255,255,0,5000);
		end
		RandomSpawnHuman(playerid);
		Human(playerid,true);
	end
end

function OnPlayerDeath(playerid, p_classid, killerid, k_classid)

	PlayRandomSoundDead(playerid);
	
	if killerid > -1 then
		PlayRandomSoundKill(playerid,killerid);
		
		if Player[killerid].team == TEAM_ZOMBIE and Player[playerid].team == TEAM_HUMAN
		then
			SendMessageToAll(255,0,0,string.format("%s %s %s %s","Zombie",GetPlayerName(killerid),"kill human",GetPlayerName(playerid)));
		end
		
		if Player[killerid].team == TEAM_HUMAN and Player[playerid].team == TEAM_HUMAN
		then
			SendMessageToAll(255,0,0,string.format("%s %s",GetPlayerName(killerid),"is team killer and he was killed."));
			SetPlayerHealth(killerid,0);
		end
	end
end

--ZOMBIES
--ZOMBIES
--ZOMBIES
function Zombie01(playerid, addteam)

	if addteam == true then
		Player[playerid].team = TEAM_ZOMBIE;
	else
		Player[playerid].team = -1;
	end
	
	SetPlayerInstance(playerid,"ZOMBIE01");
	SetPlayerHealth(playerid,5000);
	SetPlayerMaxHealth(playerid,5000);
	SetPlayerStrength(playerid,200);
end

function Zombie02(playerid, addteam)

	if addteam == true then
		Player[playerid].team = TEAM_ZOMBIE;
	else
		Player[playerid].team = -1;
	end
	
	SetPlayerInstance(playerid,"ZOMBIE02");
	SetPlayerHealth(playerid,5000);
	SetPlayerMaxHealth(playerid,5000);
	SetPlayerStrength(playerid,200);
end

function Zombie03(playerid, addteam)

	if addteam == true then
		Player[playerid].team = TEAM_ZOMBIE;
	else
		Player[playerid].team = -1;
	end
	
	SetPlayerInstance(playerid,"ZOMBIE03");
	SetPlayerHealth(playerid,5000);
	SetPlayerMaxHealth(playerid,5000);
	SetPlayerStrength(playerid,200);
end

function Zombie04(playerid, addteam)

	if addteam == true then
		Player[playerid].team = TEAM_ZOMBIE;
	else
		Player[playerid].team = -1;
	end
	
	SetPlayerInstance(playerid,"ZOMBIE04");
	SetPlayerHealth(playerid,5000);
	SetPlayerMaxHealth(playerid,5000);
	SetPlayerStrength(playerid,200);
end

--HUMANS
--HUMANS
--HUMANS
function Pirate(playerid, addteam)

	if addteam == true then
		Player[playerid].team = TEAM_HUMAN;
	else
		Player[playerid].team = -1;
	end
	
	SetPlayerInstance(playerid,"PC_HERO");
	SetPlayerAdditionalVisual(playerid,"Hum_Body_Naked0"3,"Hum_Head_Psionic",59);
	SetPlayerHealth(playerid,300);
	SetPlayerMaxHealth(playerid,300);
	SetPlayerStrength(playerid,145);
	SetPlayerSkillWeapon(playerid,1,60);
	EquipArmor(playerid,"ITAR_PIR_H_Addon");
	EquipMeleeWeapon(playerid,"ITMW_KRUMMSCHWERT");
end

function DragonHunter(playerid, addteam)

	if addteam == true then
		Player[playerid].team = TEAM_HUMAN;
	else
		Player[playerid].team = -1;
	end
	
	SetPlayerInstance(playerid,"PC_HERO");
	SetPlayerAdditionalVisual(playerid,"Hum_Body_Naked0",2,"Hum_Head_Fighter",120);
    SetPlayerHealth(playerid,300);
	SetPlayerMaxHealth(playerid,300);
	SetPlayerStrength(playerid,90);
	SetPlayerDexterity(playerid,50);
	SetPlayerSkillWeapon(playerid,0,60);
	SetPlayerSkillWeapon(playerid,3,50);
	EquipArmor(playerid,"ITAR_DJG_M");
	EquipMeleeWeapon(playerid,"ITMW_RUBINKLINGE");
	EquipRangedWeapon(playerid,"ITRW_CROSSBOW_L_02");
	GiveItem(playerid,"ITRW_BOLT",50);
end

function Knight(playerid, addteam)

	if addteam == true then
		Player[playerid].team = TEAM_HUMAN;
	else
		Player[playerid].team = -1;
	end
	
	SetPlayerInstance(playerid,"PC_HERO");
	SetPlayerAdditionalVisual(playerid,"Hum_Body_Naked0",1,"Hum_Head_FatBald",32);
    SetPlayerHealth(playerid,300);
	SetPlayerMaxHealth(playerid,300);
	SetPlayerStrength(playerid,120);
	SetPlayerDexterity(playerid,80);
	SetPlayerSkillWeapon(playerid,1,60);
	SetPlayerSkillWeapon(playerid,2,50);
	EquipArmor(playerid,"ITAR_PAL_M");
	EquipMeleeWeapon(playerid,"ITMW_2H_PAL_SWORD");
	EquipRangedWeapon(playerid,"ITRW_BOW_M_02");
	GiveItem(playerid,"ITRW_ARROW",50);
end

function Acrobat(playerid, addteam)

	if addteam == true then
		Player[playerid].team = TEAM_HUMAN;
	else
		Player[playerid].team = -1;
	end
	
	SetPlayerInstance(playerid,"PC_HERO");
	SetPlayerAdditionalVisual(playerid,"Hum_Body_Naked0",2,"Hum_Head_Thief",95);
	SetPlayerHealth(playerid,300);
	SetPlayerMaxHealth(playerid,300);
	SetPlayerStrength(playerid,40);
	SetPlayerDexterity(playerid,100);
	SetPlayerSkillWeapon(playerid,1,40);
	SetPlayerSkillWeapon(playerid,2,90);
	SetPlayerAcrobatic(playerid,1);
	EquipArmor(playerid,"ITAR_DIEGO");
	EquipMeleeWeapon(playerid,"ItMw_FrancisDagger_Mis");
	EquipRangedWeapon(playerid,"ITRW_BOW_M_03");
	GiveItem(playerid,"ITRW_ARROW",200);
end

function Zombie(playerid, addteam)
	
	local classid = 0;
	if Player[playerid].cid >= 0 and Player[playerid].cid <= 3
	then
		classid = Player[playerid].cid;
	else
		classid = random(4);
	end
	
	if classid == 0 then
		Zombie01(playerid,addteam);
	elseif classid == 1 then
		Zombie02(playerid,addteam);
	elseif classid == 2 then
		Zombie03(playerid,addteam);
	elseif classid == 3 then
		Zombie04(playerid,addteam);
	end
end

function Human(playerid, addteam)

	Player[playerid].team = TEAM_HUMAN;

	local classid = 0;
	if Player[playerid].cid >= 4 and Player[playerid].cid <= 7
	then
		classid = Player[playerid].cid;
	else
		classid = random(4) + 4;
	end
	
	if classid == 4 then
		Pirate(playerid,addteam);
	elseif classid == 5 then
		DragonHunter(playerid,addteam);
	elseif classid == 6 then
		Knight(playerid,addteam);
	elseif classid == 7 then
		Acrobat(playerid,addteam);
	end
end

function RandomSpawnZombie(playerid)

	local spawnid = random(SPAWN_ZOMBIE) + 1;
	
	SetPlayerPos(playerid,SpawnZombie[spawnid][1],SpawnZombie[spawnid][2],SpawnZombie[spawnid][3]);
	SetPlayerAngle(playerid,SpawnZombie[spawnid][4]);
end

function RandomSpawnHuman(playerid)

	local spawnid = random(SPAWN_HUMAN) + 1;
	
	SetPlayerPos(playerid,SpawnHuman[spawnid][1],SpawnHuman[spawnid][2],SpawnHuman[spawnid][3]);
	SetPlayerAngle(playerid,SpawnHuman[spawnid][4]);
end

function GetRandomPlayerForZombie()

	--Create and clear structure random player
	RandomPlayer = {};
	
	for i = 0, MAX_PLAYERS - 1
	do
		RandomPlayer[i] = -1;
	end
	
	local p_index = 0;
	for i = 0, MAX_PLAYERS - 1
	do
		if IsPlayerConnected(i) == 1 and Player[i].team == TEAM_HUMAN
		then
			RandomPlayer[p_index] = i;
			p_index = p_index + 1;
		end
	end
	
	if p_index > 0
	then
		
		local p_rand = random(p_index);
		
		local text = string.format("%s %s",GetPlayerName(RandomPlayer[p_rand]),"was randomly choosen as the zombie");
		GameTextForAll(1000,3000,text,"Font_Old_20_White_Hi.TGA",255,0,0,5000);
		
		RandomSpawnZombie(RandomPlayer[p_rand]);
		Zombie(RandomPlayer[p_rand],true);
		return true;
	end
	return false;
end

function PlayRandomSoundDead(playerid)

	if Player[playerid].team == TEAM_HUMAN
	then
		
		local px,py,pz = GetPlayerPos(playerid);
		local sound_dead = random(SND_DEAD_HUMAN);
		
		for i = 0, MAX_PLAYERS - 1
		do
			if IsPlayerConnected(i) == 1 then
				PlayPlayerSound3D(i,SoundDeadHuman[sound_dead],px,py,pz,2000);
			end
		end
	end
end

function PlayRandomSoundKill(playerid, killerid)

	if Player[killerid].team == TEAM_HUMAN and Player[playerid].team == TEAM_ZOMBIE
	then
	
		local px,py,pz = GetPlayerPos(killerid);
		local sound_kill = random(SND_KILL_HUMAN);
		
		for i = 0, MAX_PLAYERS - 1
		do
			if IsPlayerConnected(i) == 1 then
				PlayPlayerSound3D(i,SoundKillHuman[sound_kill],px,py,pz,2000);
			end
		end
	elseif Player[killerid].team == TEAM_ZOMBIE and Player[playerid].team == TEAM_HUMAN
	then
	
		local px,py,pz = GetPlayerPos(killerid);
		local sound_kill = random(SND_KILL_ZOMBIE);
		
		for i = 0, MAX_PLAYERS - 1
		do
			if IsPlayerConnected(i) == 1 then
				PlayPlayerSound3D(i,SoundKillZombie[sound_kill],px,py,pz,2000);
			end
		end
	end
end

--INIT GAME
--INIT GAME
--INIT GAME
function InitGame()

	--Create structure game 
	Game = {};
	
	--Clear structure game
	Game.started = false;
	Game.zombies = 0;
	Game.humans = 0;
	Game.i_nozombies = 0;
	Game.minute = AWAIT_MINUTE;
	Game.second = AWAIT_SECOND;
	
	local format_time = string.format("%d:%02d",Game.minute,Game.second);
	Game.draw_timer = CreateDraw(6500,5700,format_time,"Font_Old_10_White_Hi.TGA",255,255,255);
	Game.draw_zombies = CreateDraw(6500,6000,"Zombies: 0","Font_Old_10_White_Hi.TGA",255,0,0);
	Game.draw_humans = CreateDraw(6500,6300,"Humans: 0","Font_Old_10_White_Hi.TGA",0,255,0);
	Game.draw_round = CreateDraw(6500,5400,"Begin the game in:","Font_Old_10_White_Hi.TGA",255,0,255);
	
	Game.timer = SetTimer("GameTimer",1000,1);
	Game.check_timer = SetTimer("CheckTimer",500,1);
end

--INIT PLAYER
--INIT PLAYER
--INIT PLAYER
function InitPlayer()

    --Create structure players
	Player = {};
	for i = 0, MAX_PLAYERS - 1
	do
		Player[i] = {};
		for j = 0, MAX_PLAYER_FIELD - 1
		do
			Player[i][j] = {};
		end
	end
	
	--Clear structure players
	for i = 0, MAX_PLAYERS - 1
	do
		Player[i].team = -1;
		Player[i].cid = -1;
		Player[i].first_spawn = false;
	end
end

function InitSoundDeadHuman()

	--Create and clear structure Sound Dead Human
	SoundDeadHuman = {};
	for i = 0, SND_DEAD_HUMAN - 1
	do
		SoundDeadHuman[i] = -1;
	end
	
	SoundDeadHuman[0] = CreateSound("SVM_9_DEAD.WAV");
	SoundDeadHuman[1] = CreateSound("SVM_6_DEAD.WAV");
	SoundDeadHuman[2] = CreateSound("SVM_3_DEAD.WAV");
	SoundDeadHuman[3] = CreateSound("SVM_5_DEAD.WAV");
	SoundDeadHuman[4] = CreateSound("SVM_12_DEAD.WAV");
	SoundDeadHuman[5] = CreateSound("SVM_4_DEAD.WAV");
	SoundDeadHuman[6] = CreateSound("SVM_7_DEAD.WAV");
	SoundDeadHuman[7] = CreateSound("SVM_11_DEAD.WAV");
end

function InitSoundKillHuman()

	--Create and clear structure Sound Kill Human
	SoundKillHuman = {};
	for i = 0, SND_KILL_HUMAN - 1
	do
		SoundKillHuman[i] = -1;
	end
	
	SoundKillHuman[0] = CreateSound("SVM_13_KILLENEMY.WAV");
	SoundKillHuman[1] = CreateSound("SVM_14_KILLENEMY.WAV");
	SoundKillHuman[2] = CreateSound("SVM_1_KILLENEMY.WAV");
	SoundKillHuman[3] = CreateSound("SVM_11_KILLENEMY.WAV");
	SoundKillHuman[4] = CreateSound("SVM_6_KILLENEMY.WAV");
	SoundKillHuman[5] = CreateSound("SVM_12_KILLENEMY.WAV");
	SoundKillHuman[6] = CreateSound("SVM_12_ENEMYKILLED.WAV");
	SoundKillHuman[7] = CreateSound("SVM_4_ENEMYKILLED.WAV");
	SoundKillHuman[8] = CreateSound("SVM_5_ENEMYKILLED.WAV");
	SoundKillHuman[9] = CreateSound("SVM_8_ENEMYKILLED.WAV");
	SoundKillHuman[10] = CreateSound("SVM_10_ENEMYKILLED.WAV");
	SoundKillHuman[11] = CreateSound("SVM_9_ENEMYKILLED.WAV");
	SoundKillHuman[12] = CreateSound("SVM_3_ENEMYKILLED.WAV");
	SoundKillHuman[13] = CreateSound("SVM_3_ENEMYKILLED.WAV");
	SoundKillHuman[14] = CreateSound("SVM_7_ENEMYKILLED.WAV");
end

function InitSoundKillZombie()

	--Create and clear structure Sound Kill Zombie
	SoundKillZombie = {};
	for i = 0, SND_KILL_ZOMBIE - 1
	do
		SoundKillZombie[i] = -1;
	end
	
	SoundKillZombie[0] = CreateSound("BREATH01.WAV");
	SoundKillZombie[1] = CreateSound("BREATH02.WAV");
	SoundKillZombie[2] = CreateSound("BREATH03.WAV");
end

function InitSoundGame()

	--Create and clear structure Sound game
	SoundGame = {};
	for i = 0, SND_GAME - 1
	do
		SoundGame[i] = -1;
	end
	
	SoundGame[0] = CreateSound("OPENPORTAL.WAV"); --start game
	SoundGame[1] = CreateSound("ZOMBIE_01.WAV"); --zombies win
	SoundGame[2] = CreateSound("CHAPTER_01.WAV"); --humans win
end

function GameTimer()
	
	if Game.second > 0
	then
		Game.second = Game.second - 1;
		
	elseif Game.second == 0
	then
	
		if Game.minute > 0
		then
			Game.minute = Game.minute - 1;
			Game.second = 59;
		elseif Game.minute == 0 and Game.second == 0
		then
			
			if Game.started == true then
				
				if Game.humans > 0
				then
					--humans win
					for i = 0, MAX_PLAYERS - 1
					do
						if IsPlayerConnected(i) and Player[i].cid > -1
						then
							PlayPlayerSound(i,SoundGame[2]);
						end
					end
				
					GameTextForAll(1800,3000,"Humans managed to survive the carnage!","Font_Old_20_White_Hi.TGA",0,255,0,7000);
					BeginAwait();
				end
			else
				BeginRound();
			end
		end
	end
	
	--Update time
	UpdateTime();
	
	--Update statistic team
	UpdateStatisticTeam();
	
	--Check if no zombies
	CheckZombies();
	
	--Check if no humans
	CheckHumans();
end

function UpdateTime()

	local format_time = string.format("%d:%02d",Game.minute,Game.second);
	UpdateDraw(Game.draw_timer,6500,5700,format_time,"Font_Old_10_White_Hi.TGA",255,255,255);
end

function UpdateStatisticTeam()

	local zombies = 0;
	local humans = 0;
	
	for i = 0, MAX_PLAYERS - 1
	do
		if Player[i].team == TEAM_ZOMBIE then
			zombies = zombies + 1;
		elseif Player[i].team == TEAM_HUMAN then
			humans = humans + 1;
		end
	end
	
	if Game.zombies == zombies
	then
	
	else
		Game.zombies = zombies;
		local zombies_stat = string.format("%s %d","Zombies:",Game.zombies);
		UpdateDraw(Game.draw_zombies,6500,6000,zombies_stat,"Font_Old_10_White_Hi.TGA",255,0,0);
	end
	
	if Game.humans == humans
	then
	
	else
		Game.humans = humans;
		local humans_stat = string.format("%s %d","Humans:",Game.humans);
		UpdateDraw(Game.draw_humans,6500,6300,humans_stat,"Font_Old_10_White_Hi.TGA",0,255,0);
	end
end

function BeginRound()

	if GetRandomPlayerForZombie() == true
	then
		Game.started = true;
		Game.minute = ROUND_MINUTE;
		Game.second = ROUND_SECOND;
		UpdateDraw(Game.draw_round,6500,5400,"End of round in:","Font_Old_10_White_Hi.TGA",255,0,255);
		
		for i = 0, MAX_PLAYERS - 1
		do
			if IsPlayerConnected(i) and Player[i].cid > -1
			then
				PlayPlayerSound(i,SoundGame[0]);
			end
		end
	else
		GameTextForAll(1500,3000,"Can't start game. No players active to game.","Font_Old_20_White_Hi.TGA",255,0,0,5000);
		BeginAwait();
	end
end

function BeginAwait()

	Game.started = false;
	Game.i_nozombies = 0;
	Game.minute = AWAIT_MINUTE;
	Game.second = AWAIT_SECOND;
	UpdateDraw(Game.draw_round,6500,5400,"Begin the game in:","Font_Old_10_White_Hi.TGA",255,0,255);
	
	for i = 0, MAX_PLAYERS - 1
	do
		if IsPlayerConnected(i) == 1 and Player[i].cid > -1
		then
			RandomSpawnHuman(i);
			Human(i,true);
		end
	end
end

function CheckZombies()
	
	if Game.started == true
	then
		if Game.zombies == 0
		then
			if Game.i_nozombies < 15 then
				Game.i_nozombies = Game.i_nozombies + 1;
			else
				if GetRandomPlayerForZombie() == false
				then
					GameTextForAll(1000,3000,"Can't continue game. No active humans and zombies.","Font_Old_20_White_Hi.TGA",255,0,0,5000);
					BeginAwait();
				end
			end
		else	
			if Game.i_nozombies > 0 then
				Game.i_nozombies = 0;
			end
		end
	end
end

function CheckHumans()
	
	if Game.started == true
	then
		if Game.humans == 0
		then
			for i = 0, MAX_PLAYERS - 1
			do
				if IsPlayerConnected(i) == 1 and Player[i].cid > -1
				then
					StopPlayerSound(i,SoundGame[0]);
					PlayPlayerSound(i,SoundGame[1]);
				end
			end
		
			GameTextForAll(200,3000,"Humans didn't survive. Zombies again took over human life.","Font_Old_20_White_Hi.TGA",255,0,0,7000);
			BeginAwait();
		end
	end
end

--timer check players
function CheckTimer()

	for i = 0, MAX_PLAYERS - 1
	do
		if IsPlayerConnected(i) == 1 and Player[i].team == TEAM_HUMAN
		then
		
			local x,y,z = GetPlayerPos(i);
			
			if GetDistance3D(x,y,z,9287.83,925.16,-4676.88) <= 700
			then
				GameTextForPlayer(i,1500,3000,"You have to defend the fort against zombie!","Font_Old_20_White_Hi.TGA",255,255,0,5000);
				SetPlayerPos(i,10979.91,998.10,-4047.13);
				SetPlayerAngle(i,240);
			end
		end
	end
end