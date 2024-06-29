require "gamemodes/init";
require "gamemodes/gui";

function OnGamemodeInit()
	print("Easy-to-fix errors unlikely!");
	EnableChat(0);
	
	Init_Chat();
	Init_Textboxes();
end

function OnPlayerConnect(playerid)
	SetPlayerEnable_OnPlayerKey(playerid, 1);
	
	ClearGMPAChat(playerid); --originalChat muss aktiviert sein, da es sonst zu Problemen kommt (u.a. keine Chateingabe möglich)
	ShowGui(playerid);
end

function ClearGMPAChat(playerid)
	for i = 0, 19 do
		SendPlayerMessage(playerid, 255, 255, 255, ""); --clear original chat by sending 21 empty lines (20 is the chatline maximum)
	end
end

function OnPlayerSelectClass(playerid, classid)
	SpawnPlayer(playerid);
end

function OnPlayerChangeClass(playerid, classid)
	SpawnPlayer(playerid);
end

function OnPlayerSpawn(playerid, classid)
	InitPlayer(playerid);
end

function OnPlayerText(playerid, text)
	if Player[playerid].chatmode == 0 then
		local output = GetPlayerName(playerid)..": "..text;
		local line1, line2 = nil, nil;
		
		if string.len(output) > 80 then
			line1 = string.sub(output, 0, 80);
			line2 = GetPlayerName(playerid)..": "..string.sub(output, 81);
		end
		
		if line2 == nil then
			Update_OTDraws(output);
		else
			Update_OTDraws(line1);
			Update_OTDraws(line2);
		end
		
	elseif Player[playerid].chatmode == 1 then
		local output = GetPlayerName(playerid)..": "..text;
		local line1, line2 = nil, nil;

		if string.len(text) > 80 then
			line1 = string.sub(output, 0, 80);
			line2 = GetPlayerName(playerid)..": "..string.sub(output, 81);
		end

		if IsUnconscious(playerid) == 0 and IsDead(playerid) == 0 then
			for i = 0, GetMaxPlayers() - 1 do
				if IsPlayerConnected(i) == 1 and IsNPC(i) ~= 1 then
					if GetDistancePlayers(playerid, i) < 2000 then
						if line2 == nil then
							Update_RPDraws(i,output);
						else
							Update_RPDraws(i,line1);
							Update_RPDraws(i,line2);
						end
					end
				end
			end
		end
	end
end

function OnPlayerKey (playerid, keydown)		
	if keydown == KEY_F1 then
		if Player[playerid].chatmode == 0 then
			ShowChatbox(playerid, 1);
		elseif Player[playerid].chatmode == 1 then
			ShowChatbox(playerid, 0);
		end
	end
end

function OnPlayerDisconnect(playerid, reason)	
	SetPlayerEnable_OnPlayerKey(playerid, 0);
end

function InitPlayer(playerid)
	SetPlayerInstance(playerid,"PC_HERO"); 
	SetPlayerHealth(playerid,35);
    SetPlayerMaxHealth(playerid,100);
    SetPlayerMana(playerid,0);
    SetPlayerMaxMana(playerid,0);
    SetPlayerStrength(playerid,10);
    SetPlayerDexterity(playerid,10);
    SetPlayerSkillWeapon(playerid,0,5);
	SetPlayerSkillWeapon(playerid,1,5);
	SetPlayerSkillWeapon(playerid,2,5);
	SetPlayerSkillWeapon(playerid,3,5);
    SetPlayerFatness(playerid,0);
	SetPlayerLevel(playerid, 0);
	SetPlayerExperience(playerid, 0);
	SetPlayerExperienceNextLevel(playerid, 500)
	SetPlayerLearnPoints(playerid, 10);
	SetPlayerWalk(playerid, "Humans_Tired.mds");
end