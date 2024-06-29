function OnFilterscriptInit()
	print("-------------------------------------------");
	print("Test filterscript for accrescere was loaded");
	print("-------------------------------------------");
	
	Enable_OnPlayerKey(1);
	
	CreateItem("ITFO_BEER",1,5955,382 + 50,2594,"NEWWORLD\\NEWWORLD.ZEN");
	CreateItem("ITFO_BEER",1,5921,382 + 50,2716.,"NEWWORLD\\NEWWORLD.ZEN");
	CreateItem("ITFO_BEER",1,5857,382 + 50,2808,"NEWWORLD\\NEWWORLD.ZEN");
	
	print(math.sin(90.0 * 3.14 / 180.0));
end

function OnFilterscriptExit()
	print("------------------------");
	print("Removing filterscript...");
	print("------------------------"); 
end

local drawPlayerID;

local gVob;

function OnPlayerSpawn(playerid, classid)

	FreezePlayer(playerid,1);
end

function OnPlayerCommandText(playerid, cmdtext)

	if cmdtext == "/c" then
	
		local npc = CreateNPC("Bo¿y dar");
		SetPlayerInstance(npc,"PC_HERO");
		SpawnPlayer(npc);
		
	elseif cmdtext == "/create" then
	
	    local y = 0;
		for i = 0, 50 do
		    drawPlayerID = CreatePlayerDraw(playerid,3000,y,"Hello. This is first draw player!","Font_Old_10_White_Hi.TGA",255,255,0);
			ShowPlayerDraw(playerid,drawPlayerID);
			y = y + 100;
		end
		
	elseif cmdtext == "/show" then
		ShowPlayerDraw(playerid,drawPlayerID);
	
	elseif cmdtext == "/update" then
		UpdatePlayerDraw(playerid,drawPlayerID,3000,3000,"Hello. This is second draw player!","Font_Old_10_White_Hi.TGA",255,0,255);
	
	elseif cmdtext == "/hide" then
		HidePlayerDraw(playerid,drawPlayerID);
	
	elseif cmdtext == "/destroy" then
		DestroyPlayerDraw(playerid,drawPlayerID);
		
	elseif cmdtext == "/destroyall" then
		DestroyAllPlayerDraws(playerid);
		
	elseif cmdtext == "/lyzka" then
		GiveItem(playerid,"ITMI_SCOOP",5);
	
	elseif cmdtext == "/test" then
	
		for i = 0, 3 do
		   CreateNPC("Risen2");
		end
		
		SendPlayerMessage(playerid,255,255,0,"/test");
		
	elseif cmdtext == "/isnpc" then
	
		if IsNPC(399) == 1 then
			SendPlayerMessage(playerid,255,255,0,"IsNPC = 1");
		else
			SendPlayerMessage(playerid,255,255,0,"IsNPC = 0");
		end
		
	elseif cmdtext == "/visual" then
	
		SetPlayerAdditionalVisual(playerid,"Hum_Body_Babe0",9,"Hum_Head_Babe",156);
		SetPlayerWalk(playerid,"Humans_Militia.mds");
		SetPlayerScale(playerid,1,1,1);
		
	elseif cmdtext == "/meat" then
	
		local x,y,z = GetPlayerPos(playerid);
		local n = CreateNPC("Chrz¹szcz");
		SetPlayerInstance(n,"scavenger");
		SpawnPlayer(n);
		SetPlayerPos(n,x,y + 100,z);
		SetPlayerMaxHealth(n,500);
		SetPlayerHealth(n,500);
		
	elseif cmdtext == "/scale" then
	
		SetPlayerScale(playerid,2,2,2);
		
	elseif cmdtext == "/dragon" then
	
		SetPlayerInstance(playerid,"orcwarrior_roam");
		
		--SetPlayerScale(playerid,0.2,0.2,0.2);
		
	elseif cmdtext == "/tr" then
	
		SetPlayerScale(398,2,4,2);
		
	elseif cmdtext == "/obiekt" then
	
		gVob = Vob.Create("NW_HARBOUR_CANON_01.3DS","NEWWORLD\\NEWWORLD.ZEN",0,10,0);
		
	elseif cmdtext == "/prosto" then
	
		local x,y,z = gVob:GetPosition();
		local rx,ry,rz = gVob:GetRotation();
		
		x = x + math.sin(ry * 3.14 / 180.0) * 50;
		z = z + math.cos(ry * 3.14 / 180.0) * 50;
		
		gVob:SetPosition(x,y,z);
		
	elseif cmdtext == "/obrot" then
	
		local rx,ry,rz = gVob:GetRotation();
		gVob:SetRotation(rx,ry + 20,rz);
		
	elseif cmdtext == "/dajtrol" then
	
		local x,y,z = GetPlayerPos(playerid);
		
		local n = CreateNPC("Sraka");
		SetPlayerInstance(n,"TROLL_BLACK");
		SpawnPlayer(n);
		SetPlayerPos(n,x,y + 100,z);
		
	elseif cmdtext == "/fat" then
	
		SetPlayerFatness(playerid,5);
		
	elseif cmdtext == "/dn" then
	
		DestroyNPC(397);
		
	elseif cmdtext == "/showick" then
		EnableNickname(1);
	
	elseif cmdtext == "/hidenick" then
		EnableNickname(0);
		
	elseif cmdtext == "/showid" then
		EnableNicknameID(1);
	
	elseif cmdtext == "/hideid" then
		EnableNicknameID(0);
		
	elseif cmdtext == "/font" then
		SetNicknameFont("Font_Old_20_White.TGA");
		
	elseif cmdtext == "/grabie" then
	
		GiveItem(playerid,"ITMI_RAKE",1);
		
	elseif cmdtext == "/joint" then
	
		GiveItem(playerid,"ITMI_JOINT",5);
		
	elseif cmdtext == "/magnat" then
	
		GiveItem(playerid,"ITAR_OreBaron_Addon",1);
		
	elseif cmdtext == "/open" then
	
		OpenLocks(1);
		
	elseif cmdtext == "/gold" then
	
		SetPlayerGold(playerid,67);
		
	elseif cmdtext == "/zycie" then
	
		GiveItem(playerid,"ItPo_Health_Addon_04",5);
		
	elseif cmdtext == "/remove" then
	
		RemoveItem(playerid,"ItPo_Health_Addon_04",15);
		
	elseif cmdtext == "/miecz" then
	
		GiveItem(playerid,"ITMW_SCHWERT2",1);
		
	elseif cmdtext == "/ammo" then
		
		GiveItem(playerid,"ITRW_ARROW",1);
		GiveItem(playerid,"ITRW_BOLT",1);
		SetPlayerDexterity(playerid,500);
		
	elseif cmdtext == "/luk" then
	
		GiveItem(playerid,"ITRW_BOW_M_04",1);
		
	elseif cmdtext == "/amulet" then
	
		GiveItem(playerid,"ItAm_Addon_Franco",1);
		
	elseif cmdtext == "/h" then	
	
		SetPlayerStrength(playerid,160);
		SetPlayerMaxHealth(playerid,5000);
		SetPlayerHealth(playerid,5000);
		
		SetPlayerSkillWeapon(playerid,SKILL_2H,70);
		
		GiveItem(playerid,"ITAR_OreBaron_Addon",1);
		GiveItem(playerid,"ITMW_2H_SPECIAL_04",1);
		
	elseif cmdtext == "/slot" then
	
		RemoveItemBySlot(playerid,0,3);
		
	elseif cmdtext == "/upadek" then
		
		SetPlayerHealth(playerid,1);
		
	elseif cmdtext == "/hit" then
	
		HitPlayer(399,0);
		
	elseif cmdtext == "/hero" then
	
		SetPlayerInstance(playerid,"PC_HERO");
		
	elseif cmdtext == "/rock" then
	
		SetPlayerInstance(playerid,"PC_ROCKEFELLER");
	end
end

function OnPlayerKey(playerid, keyDown, keyUp)

	--[[if keydown == KEY_NUMPAD8 then
	
		local x,y,z = gVob:GetPosition();
		gVob:SetPosition(x + 10,y,z);
		
	elseif keydown == KEY_NUMPAD2 then

		local x,y,z = gVob:GetPosition();
		gVob:SetPosition(x - 10,y,z);
		
	elseif keydown == KEY_NUMPAD4 then
	
		local x,y,z = gVob:GetPosition();
		gVob:SetPosition(x,y,z + 10);
		
	elseif keydown == KEY_NUMPAD6 then
	
		local x,y,z = gVob:GetPosition();
		gVob:SetPosition(x,y,z - 10);
		
	elseif keydown == KEY_NUMPAD7 then
	
		local x,y,z = gVob:GetPosition();
		gVob:SetPosition(x,y + 10,z);
		
	elseif keydown == KEY_NUMPAD1 then
	
		local x,y,z = gVob:GetPosition();
		gVob:SetPosition(x,y - 10,z);
		
	elseif keydown == KEY_NUMPAD9 then
		
		local x,y,z = gVob:GetRotation();
		gVob:SetRotation(x,y + 5,z);
		
	elseif keydown == KEY_NUMPAD3 then
		
		local x,y,z = gVob:GetRotation();
		gVob:SetRotation(x,y - 5,z);
	end]]--
end

function OnPlayerUnconscious(playerid, p_classid, killerid, k_classid)

	--SetPlayerHealth(playerid,0);
end

function OnPlayerUseItem(playerid, itemInstance, amount, hand)
	
	SendMessageToAll(255,255,0,"OnPlayerUseItem");
end