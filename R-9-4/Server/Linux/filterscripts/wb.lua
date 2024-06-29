require "Function/GetVobName"
require "Function/GetVobPosRotation"
require "Function/GetVobPosRotationBack"

local MaxVob = -1;
local WB = {};
local gVob = {};
local VobID = {};
local TimerKey = {};
local TimerPos = {};
local X = {};
local Y = {};
local Z = {};
local Xr = {};
local Yr = {};
local Zr = {};
local PlayerSpeed = {};
local VobReady = {};
local VobInstance = {};
local VobActive = {};
-- 1000 vobów limit :)
for i = 0, 1999 do
	VobReady[i] = nil;
	VobInstance[i] = nil;
end

local Speed = {};

Speed[1] = 100;
Speed[2] = 50;
Speed[3] = 10;

function OnFilterscriptInit()

	print("WorldBuilder loaded...");
	Enable_OnPlayerKey(1);
	InitPlayer();
	local FileReadVobs = io.open("VobsAmount.wb","r+");
	if FileReadVobs then
	
		tempvar = FileReadVobs:read("*l");
		local result, maxvobs = sscanf(tempvar,"d");
		if result == 1 then
			MaxVob = maxvobs;
		end
	
		local FileRead = io.open("WorldBuilder.wb","r+");
		
		if FileRead then
			
			for i = MaxVob, 0, -1   do
			
				tempvar = FileRead:read("*l");
				local result, vobname, world, x, y, z = sscanf(tempvar,"ssddd");
				if result == 1 then
					VobReady[i] = Vob.Create(vobname, world, x, y, z);
					VobInstance[i] = vobname;					
				end
		
				tempvar = FileRead:read("*l");
				local result, xr, yr, zr = sscanf(tempvar,"ddd");
				if result == 1 then
					VobReady[i]:SetRotation(xr, yr, zr);
				end
				
			end
				
		end
			
	end	
	
end
	

function InitPlayer()

	for i = 0, GetMaxPlayers() - 1 do

		WB[i] = false;
		gVob[i] = nil;
		VobID[i] = -1;
		TimerKey[i] = -1;
		TimerPos[i] = -1;
		PlayerSpeed[i] = 1;
		
		X[i] = CreateDraw(5500, 800, "X: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		Y[i] = CreateDraw(5500, 1000, "Y: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		Z[i] = CreateDraw(5500, 1200, "Z: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		Xr[i] = CreateDraw(5500, 1500, "X: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		Yr[i] = CreateDraw(5500, 1700, "Y: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		Zr[i] = CreateDraw(5500, 1900, "Z: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		
		VobActive[i] = CreateDraw(5500, 2200, "Vob: ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		
	end

end

function OnPlayerCommandText(playerid, cmdtext)
	
	local cmd, params = GetCommand(cmdtext);
 
	if cmd == "/destroyvob" then
	
		if IsPlayerAdmin(playerid) == 1 then
			if WB[playerid] == false then
				DestroyVob(params, playerid);
			end
		end
		
    end
	
end

function DestroyVob(params, playerid)

	local result, vobsid = sscanf(params,"d");
	if result == 1 then
		
		if MaxVob >= vobsid or vobsid < 0 then
		
			VobReady[vobsid]:Destroy();
			SendPlayerMessage(playerid, 255, 0, 0, "Zniszczono voba: ID ("..vobsid..")");	
			
			MaxVob = MaxVob - 1;
			
			for i = vobsid, MaxVob do
				VobReady[i] = VobReady[i + 1];
			end
		else
		
			SendPlayerMessage(playerid, 255, 0, 0, "Vob o takim ID nie istnieje!");
		
		end
		
	else
	
		SendPlayerMessage(playerid, 255, 0, 0, "Wpisz /destroyvob (id_voba)");
		
	end
	
end

function PosRotVob(playerid)
	
	local x, y, z = gVob[playerid]:GetPosition();
	UpdateDraw(X[playerid],5500, 800, "X: "..x.."", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdateDraw(Y[playerid],5500, 1000, "Y: "..y.."", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdateDraw(Z[playerid],5500, 1200, "Z: "..z.."", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	x, y, z = gVob[playerid]:GetRotation();
	UpdateDraw(Xr[playerid],5500, 1500, "X: "..x.."", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdateDraw(Yr[playerid],5500, 1700, "Y: "..y.."", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdateDraw(Zr[playerid],5500, 1900, "Z: "..z.."", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

end

function ShowWBDraw(playerid)

	ShowDraw(playerid, X[playerid]);
	ShowDraw(playerid, Y[playerid]);
	ShowDraw(playerid, Z[playerid]);
	ShowDraw(playerid, Xr[playerid]);
	ShowDraw(playerid, Yr[playerid]);
	ShowDraw(playerid, Zr[playerid]);
	
end

function HideWBDraw(playerid)

	HideDraw(playerid, X[playerid]);
	HideDraw(playerid, Y[playerid]);
	HideDraw(playerid, Z[playerid]);
	HideDraw(playerid, Xr[playerid]);
	HideDraw(playerid, Yr[playerid]);
	HideDraw(playerid, Zr[playerid]);
	
end

function WorldBuilder(playerid)
	
	if WB[playerid] == false then
	
		local x, y, z = GetPlayerPos(playerid);
		VobID[playerid] = 0;
		gVob[playerid] = Vob.Create(GetVobName(0), GetPlayerWorld(playerid), x + 200, y, z);
		SetCameraBehindVob(playerid, gVob[playerid]);
		FreezePlayer(playerid, 1);
		WB[playerid] = true;
		TimerPos[playerid] = SetTimerEx("PosRotVob", 50, 1, playerid);
		ShowWBDraw(playerid);
		
	else
		if TimerKey[playerid] ~= -1 then
			KillTimer(TimerKey[playerid]);
			TimerKey[playerid] = -1;		
		end
		KillTimer(TimerPos[playerid]);
		HideWBDraw(playerid);
		SetDefaultCamera(playerid);
		FreezePlayer(playerid, 0);
		WB[playerid] = false;
		
		local FileWrite = io.open("WorldBuilder.wb","w+");
		
		for i = 0, MaxVob do
		
			local x, y, z = VobReady[i]:GetPosition();
			local xr, yr, zr = VobReady[i]:GetRotation();
			
			FileWrite:write(VobInstance[i].." "..GetPlayerWorld(playerid).." "..x.." "..y.." "..z.."\n");
			FileWrite:write(xr.." "..yr.." "..zr.."\n"); 
			
		end
		
		FileWrite:close();
		
			
		local FileWriteVobs = io.open("VobsAmount.wb","w+");
		FileWriteVobs:write(MaxVob.."\n");
		FileWriteVobs:close();
		
		gVob[playerid]:Destroy();
		
	end
	
end

function OnPlayerKey(playerid, keydown)


	if keydown == KEY_F12 then
	
		if IsPlayerAdmin(playerid) == 1 then
		
			WorldBuilder(playerid);
			
		end

	end
 
	if WB[playerid] == true then
		
		if keydown == KEY_LEFT then
		
			VobID[playerid] = VobID[playerid] - 1;
		
			if VobID[playerid] < 0 then
				VobID[playerid] = 0;
			else
				local x, y, z = gVob[playerid]:GetPosition();
				gVob[playerid]:Destroy();
				
				gVob[playerid] = Vob.Create(GetVobName(VobID[playerid]), GetPlayerWorld(playerid), x, y, z);
				SetCameraBehindVob(playerid, gVob[playerid]);
			end
		
		elseif keydown == KEY_RIGHT then
	
			VobID[playerid] = VobID[playerid] + 1;
		
			if VobID[playerid] > 838 then
				VobID[playerid] = 838;
			else
				local x, y, z = gVob[playerid]:GetPosition();
				gVob[playerid]:Destroy();
				
				gVob[playerid] = Vob.Create(GetVobName(VobID[playerid]), GetPlayerWorld(playerid), x, y, z);
				SetCameraBehindVob(playerid, gVob[playerid]);
			end
		
		elseif keydown == KEY_UP then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("UpVob", Speed[PlayerSpeed[playerid]], 1,playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
		
		elseif keydown == KEY_DOWN then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("DownVob", Speed[PlayerSpeed[playerid]], 1,playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
			
		elseif keydown == KEY_RETURN then
			
			MaxVob = MaxVob + 1;
			if MaxVob < 1000 then
			
				SendPlayerMessage(playerid, 0, 255, 0, "Stworzono voba: ID ("..MaxVob..")");
				
				local x, y, z = gVob[playerid]:GetPosition();
				VobReady[MaxVob] = Vob.Create(GetVobName(VobID[playerid]), GetPlayerWorld(playerid), x, y, z);
				VobInstance[MaxVob] = GetVobName(VobID[playerid]);

				local xr, yr, zr = gVob[playerid]:GetRotation();
				
				VobReady[MaxVob]:SetRotation(xr, yr, zr);
				
			end
			
		elseif keydown == KEY_I then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("AngleRight_L", Speed[PlayerSpeed[playerid]], 1, playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
			
		elseif keydown == KEY_K then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("AngleRight_R", Speed[PlayerSpeed[playerid]], 1, playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
		
		elseif keydown == KEY_J then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("AngleLeft_L", Speed[PlayerSpeed[playerid]], 1, playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
			
		elseif keydown == KEY_L then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("AngleLeft_R", Speed[PlayerSpeed[playerid]], 1, playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
			
		elseif keydown == KEY_Q then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("AngleTop_R", Speed[PlayerSpeed[playerid]], 1, playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
			
		elseif keydown == KEY_E then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("AngleTop_L", Speed[PlayerSpeed[playerid]], 1, playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
			
		elseif keydown == KEY_W then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("VobGo", Speed[PlayerSpeed[playerid]], 1, playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
			
		elseif keydown == KEY_S then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("VobGoBack", Speed[PlayerSpeed[playerid]], 1, playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
			
		elseif keydown == KEY_A then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("VobGoLeft", Speed[PlayerSpeed[playerid]], 1, playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
			
		elseif keydown == KEY_D then
		
			if TimerKey[playerid] == -1 then
				TimerKey[playerid] = SetTimerEx("VobGoRight", Speed[PlayerSpeed[playerid]], 1, playerid);
			else
				KillTimer(TimerKey[playerid]);
				TimerKey[playerid] = -1;
			end
			
		elseif keydown == KEY_1 then
		
			if TimerKey[playerid] ~= -1 then
				KillTimer(TimerKey[playerid]);
			end
			
			PlayerSpeed[playerid] = 1;
			
		elseif keydown == KEY_2 then
		
			if TimerKey[playerid] ~= -1 then
				KillTimer(TimerKey[playerid]);
			end
			
			PlayerSpeed[playerid] = 2;
		
		elseif keydown == KEY_3 then
		
			if TimerKey[playerid] ~= -1 then
				KillTimer(TimerKey[playerid]);
			end
			
			PlayerSpeed[playerid] = 3;
			
		elseif keydown == KEY_DELETE then
		
			local Min = {};
			local MinValue = 0;
			local ID = -1;
			local Nr = 0;
			local x2, y2, z2 = gVob[playerid]:GetPosition();
		
			for i = 0, MaxVob do
			
				local x, y, z = VobReady[i]:GetPosition();
				
				if GetDistance3D(x,y,z,x2,y2,z2) <= 100 then
					
					Min[Nr] = GetDistance3D(x,y,z,x2,y2,z2);
	
					if Nr > 0 then
					
						if Min[Nr] < Min[Nr - 1] then
							MinValue = Min[Nr];
							ID = i;
						end
						
					else
						MinValue = Min[Nr];
						ID = i;
					end
					
					Nr = Nr + 1;
						
				end
				
			end
			
			if ID ~= -1 then
			
				VobReady[ID]:Destroy();
				SendPlayerMessage(playerid, 255, 0, 0, "Zniszczono voba: ID ("..ID..")");	
				
				MaxVob = MaxVob - 1;
				
				for j = ID, MaxVob do
					VobReady[j] = VobReady[j + 1];
				end
				
			end
		
		end

	end
	
end

function UpVob(playerid)

	local x, y, z = gVob[playerid]:GetPosition();
	gVob[playerid]:SetPosition(x, y + 10, z);
	
end

function DownVob(playerid)

	local x, y, z = gVob[playerid]:GetPosition();
	gVob[playerid]:SetPosition(x, y - 10, z);
	
end

function AngleRight_L(playerid)

	local x, y, z = gVob[playerid]:GetRotation();
	gVob[playerid]:SetRotation(x + 1, y, z);
	
end

function AngleRight_R(playerid)

	local x, y, z = gVob[playerid]:GetRotation();
	gVob[playerid]:SetRotation(x - 1, y, z);
	
end

function AngleLeft_L(playerid)

	local x, y, z = gVob[playerid]:GetRotation();
	gVob[playerid]:SetRotation(x, y, z + 1);
	
end

function AngleLeft_R(playerid)

	local x, y, z = gVob[playerid]:GetRotation();
	gVob[playerid]:SetRotation(x, y, z - 1);
	
end

function AngleTop_L(playerid)

	local x, y, z = gVob[playerid]:GetRotation();
	if y == 359 then
		y = 0;
	end
	gVob[playerid]:SetRotation(x, y + 1, z);
	
end

function AngleTop_R(playerid)

	local x, y, z = gVob[playerid]:GetRotation();
	if y == 0 then
		y = 359;
	end
	gVob[playerid]:SetRotation(x, y - 1, z);
	
end

function VobGo(playerid)

	local x, y, z = GetVobPosRotation(gVob[playerid], 1);
	gVob[playerid]:SetPosition(x, y, z);
	
end

function VobGoBack(playerid)
	
	local x, y, z = GetVobPosRotation(gVob[playerid], 2);
	gVob[playerid]:SetPosition(x, y, z);
	
end

function VobGoRight(playerid)
	
	local x, y, z = GetVobPosRotationBack(gVob[playerid], 1);
	gVob[playerid]:SetPosition(x, y, z);
	
end

function VobGoLeft(playerid)
	
	local x, y, z = GetVobPosRotationBack(gVob[playerid], 2);
	gVob[playerid]:SetPosition(x, y, z);
	
end