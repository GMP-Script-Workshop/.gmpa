--[[
*********************************************
* GMP Movements Gates/Doors script by Risen *
* Date: 03-07-2013                          *
*********************************************
]]--

local movementTimer;
MovementList     = {};
MovementType     = {TYPE_GATE = 0, TYPE_DOOR = 1};
MovementStatus   = {STATUS_OPENED = 0, STATUS_CLOSED = 1, STATUS_MOVING_TO_OPEN = 2, STATUS_MOVING_TO_CLOSE = 3};
MovementDistance = {DISTANCE_PLAYER_GATE = 1000, DISTANCE_PLAYER_DOOR = 300, DISTANCE_MOVE_GATE = 5};

--[[
prototype of movement:
	type,
	status,
	vobName,
	worldName,
	
	opened_posX,
	opened_posY,
	opened_posZ,
	opened_rotX,
	opened_rotY,
	opened_rotZ,
	
	closed_posX,
	closed_posY,
	closed_posZ,
	closed_rotX,
	closed_rotY,
	closed_rotZ,
	vobID
]]--

function OnFilterscriptInit()
	print("----------------------------------------");
	print("Movement Gates/Doors script 0.1 by Risen");
	print("----------------------------------------");
	
	movementTimer = SetTimer("MovementProcess",50,1);

	--Gates
	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_CLOSED,"EVT_GATE_LARGE_01.3DS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,5636.732421875,345.82818603516,5498.1176757813,0,-30,0);
	SetMovementCoordinationAsClosed(movement,5636.732421875,750.82818603516,5498.1176757813,0,-30,0);
	
	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_CLOSED,"EVT_GATE_LARGE_01.3DS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,6477.8559570313,348.18676757813,8207.939453125,0,-120,0);
	SetMovementCoordinationAsClosed(movement,6477.8559570313,788.18676757813,8207.939453125,0,-120,0);
	
	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_CLOSED,"EVT_GATE_LARGE_01.3DS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,10377.612304688,-136.71270751953,5739.4677734375,0,56,0);
	SetMovementCoordinationAsClosed(movement,10377.612304688,453.28729248047,5739.4677734375,0,56,0);
	
	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_CLOSED,"EVT_GATE_LARGE_01.3DS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,8019.763671875,-131.72393798828,-6101.6518554688,0,6,0);
	SetMovementCoordinationAsClosed(movement,8019.763671875,458.27606201172,-6101.6518554688,0,6,0);
	
	--Doors
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,3290.3010253906,-114.12633514404,-2104.2019042969,0,-86,0);
	SetMovementCoordinationAsClosed(movement,3230.3010253906,-114.12633514404,-2034.2019042969,0,0,0);
	
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,2898.7084960938,-179.19772338867,-894.05291748047,0,-266,0);
	SetMovementCoordinationAsClosed(movement,2963.7084960938,-179.19772338867,-969.05291748047,0,-180,0);
	
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,3835.0463867188,754.07983398438,6631.34375,0,-26,0);
	SetMovementCoordinationAsClosed(movement,3870.0463867188,749.07983398438,6726.34375,0,60,0);
	
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,3949.1032714844,748.20422363281,6054.6567382813,0,-118,0);
	SetMovementCoordinationAsClosed(movement,3859.1032714844,748.20422363281,6084.6567382813,0,-28,0);
	
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,3532.4943847656,753.21600341797,7502.1528320313,0,64,0);
	SetMovementCoordinationAsClosed(movement,3627.4943847656,753.21600341797,7472.1528320313,0,150,0);
	
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,4966.1533203125,749.06042480469,8311.4375,0,60,0);
	SetMovementCoordinationAsClosed(movement,4936.1533203125,749.06042480469,8216.4375,0,-30,0);
	
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","NEWWORLD\\NEWWORLD.ZEN");
	SetMovementCoordinationAsOpened(movement,5799.4033203125,748.21630859375,7153.6723632813,0,152,0);
	SetMovementCoordinationAsClosed(movement,5704.4033203125,748.21630859375,7178.6723632813,0,62,0);
end

function OnFilterscriptExit()
	print("--------------------------------------");
	print("Closing Movement Gates/Doors script...");
	print("--------------------------------------"); 
	
	KillTimer(movementTimer);
end

function OnPlayerConnect(playerid)

	SendPlayerMessage(playerid,0,255,0,"(ENG) If you are near the new gate or door you can use /open and /close");
	SendPlayerMessage(playerid,0,255,0,"(PL)  Jeœli jesteœ w pobli¿u bramy lub drzwi mo¿esz u¿yæ /open i /close");
end

function CreateMovement(movementType, movementStatus, vobName, worldName)

	if movementType < 2 then
	
		if movementStatus < 2 then -- STATUS_MOVING_TO_OPEN or STATUS_MOVING_TO_CLOSE can not be set as default
			movement = {};
			movement.type      = movementType;
			movement.status    = movementStatus;
			movement.vobName   = vobName;
			movement.worldName = worldName;
			movement.opened_posX = 0;
			movement.opened_posY = 0;
			movement.opened_posZ = 0;
			movement.opened_rotX = 0;
			movement.opened_rotY = 0;
			movement.opened_rotZ = 0;
			movement.closed_posX = 0;
			movement.closed_posY = 0;
			movement.closed_posZ = 0;
			movement.closed_rotX = 0;
			movement.closed_rotY = 0;
			movement.closed_rotZ = 0;
			
			if movement.status == MovementStatus.STATUS_OPENED then --Opened
				movement.vobID = Vob.Create(movement.vobName,movement.worldName,movement.opened_posX,movement.opened_posY,movement.opened_posZ);
				movement.vobID:SetRotation(movement.opened_rotX,movement.opened_rotY,movement.opened_rotZ);
				
			elseif movement.status == MovementStatus.STATUS_CLOSED then --Closed
				movement.vobID = Vob.Create(movement.vobName,movement.worldName,movement.closed_posX,movement.closed_posY,movement.closed_posZ);
				movement.vobID:SetRotation(movement.closed_rotX,movement.closed_rotY,movement.closed_rotZ);
			end
	
			table.insert(MovementList,movement);
			return movement;
		else
			LogString("movement_log.txt","Error CreateMovement(): Incorrent movement status. It can be MovementStatus.STATUS_OPENED or MovementStatus.STATUS_CLOSED.");
		end
		
	else
		LogString("movement_log.txt","Error CreateMovement(): Incorrent movement type. It can be MovementType.TYPE_GATE or MovementType.TYPE_DOOR.");
	end
	
	return nil;
end

function DestroyMovement(movement)
	
	for i = 1, #MovementList do
		if MovementList[i] == movement then
			MovementList[i].vobID:Destroy();
			table.remove(MovementList,i);
			return true;
		end
	end
	return false;
end

function SetMovementCoordinationAsOpened(movement, posX, posY, posZ, rotX, rotY, rotZ)

	if movement.status ~= MovementStatus.STATUS_MOVING_TO_OPEN and movement.status ~= MovementStatus.STATUS_MOVING_TO_CLOSE then
		movement.opened_posX = posX;
		movement.opened_posY = posY;
		movement.opened_posZ = posZ;
		movement.opened_rotX = rotX;
		movement.opened_rotY = rotY;
		movement.opened_rotZ = rotZ;
		
		if movement.status == MovementStatus.STATUS_OPENED then
			movement.vobID:SetPosition(movement.opened_posX,movement.opened_posY,movement.opened_posZ);
			movement.vobID:SetRotation(movement.opened_rotX,movement.opened_rotY,movement.opened_rotZ);
		end
		
		return true;
	end
	
	return false;
end

function SetMovementCoordinationAsClosed(movement, posX, posY, posZ, rotX, rotY, rotZ)
	
	if movement.status ~= MovementStatus.STATUS_MOVING_TO_OPEN and movement.status ~= MovementStatus.STATUS_MOVING_TO_CLOSE then
		movement.closed_posX = posX;
		movement.closed_posY = posY;
		movement.closed_posZ = posZ;
		movement.closed_rotX = rotX;
		movement.closed_rotY = rotY;
		movement.closed_rotZ = rotZ;
		
		if movement.status == MovementStatus.STATUS_CLOSED then
			movement.vobID:SetPosition(movement.closed_posX,movement.closed_posY,movement.closed_posZ);
			movement.vobID:SetRotation(movement.closed_rotX,movement.closed_rotY,movement.closed_rotZ);
		end
		
		return true;
	end
	
	return false;
end

function OpenMovement(movement)

	--Gate
	if movement.type == MovementType.TYPE_GATE then
		if movement.status == MovementStatus.STATUS_CLOSED or movement.status == MovementStatus.STATUS_MOVING_TO_CLOSE then
			movement.status = MovementStatus.STATUS_MOVING_TO_OPEN;
			return true;
		end
	
	--Door
	elseif movement.type == MovementType.TYPE_DOOR then
		if movement.status == MovementStatus.STATUS_CLOSED then -- if closed
			movement.vobID:SetPosition(movement.opened_posX,movement.opened_posY,movement.opened_posZ);
			movement.vobID:SetRotation(movement.opened_rotX,movement.opened_rotY,movement.opened_rotZ);
			
			movement.status = MovementStatus.STATUS_OPENED; -- lets open
			return true;
		end
	end
	
	return false;
end

function CloseMovement(movement)

	--Gate
	if movement.type == MovementType.TYPE_GATE then
		if movement.status == MovementStatus.STATUS_OPENED or movement.status == MovementStatus.STATUS_MOVING_TO_OPEN then
			movement.status = MovementStatus.STATUS_MOVING_TO_CLOSE;
			return true;
		end
		
	
	--Door
	elseif movement.type == MovementType.TYPE_DOOR then
		if movement.status == MovementStatus.STATUS_OPENED then -- if opened
			movement.vobID:SetPosition(movement.closed_posX,movement.closed_posY,movement.closed_posZ);
			movement.vobID:SetRotation(movement.closed_rotX,movement.closed_rotY,movement.closed_rotZ);
			
			movement.status = MovementStatus.STATUS_CLOSED; --lets close
			return true;
		end
	end
	
	return false;
end

function GetNearestGate(playerid)
	
	if IsPlayerConnected(playerid) == 1 then
		local playerX,playerY,playerZ = GetPlayerPos(playerid);
		local playerWorld = GetPlayerWorld(playerid);
		
		if #MovementList > 0 then
			local currDistance = GetDistance3D(playerX,playerY,playerZ,MovementList[1].closed_posX,MovementList[1].closed_posY,MovementList[1].closed_posZ);
			if #MovementList > 1 then
				local currMovement = nil;
			
				for i = 1, #MovementList do
					if MovementList[i].type == MovementType.TYPE_GATE then
						if MovementList[i].worldName == playerWorld then
							local distanceToGate = GetDistance3D(playerX,playerY,playerZ,MovementList[i].closed_posX,MovementList[i].closed_posY,MovementList[i].closed_posZ);
							if distanceToGate <= currDistance then
								currDistance = distanceToGate;
								currMovement = MovementList[i];
							end
						end
					end
				end
				
				if currDistance < MovementDistance.DISTANCE_PLAYER_GATE then
					return currMovement, currDistance;
				end
			end
			
			if MovementList[1].type == MovementType.TYPE_GATE and currDistance < MovementDistance.DISTANCE_PLAYER_GATE then
				return MovementList[1], currDistance;
			end
		end
	end
	return nil;
end

function GetNearestDoor(playerid)

	if IsPlayerConnected(playerid) == 1 then
		local playerX,playerY,playerZ = GetPlayerPos(playerid);
		local playerWorld = GetPlayerWorld(playerid);
		
		if #MovementList > 0 then
			local currDistance = GetDistance3D(playerX,playerY,playerZ,MovementList[1].closed_posX,MovementList[1].closed_posY,MovementList[1].closed_posZ);
			if #MovementList > 1 then
				local currMovement = nil;
				
				for i = 1, #MovementList do
					if MovementList[i].type == MovementType.TYPE_DOOR then
						if MovementList[i].worldName == playerWorld then
							local distanceToDoor = GetDistance3D(playerX,playerY,playerZ,MovementList[i].closed_posX,MovementList[i].closed_posY,MovementList[i].closed_posZ);	
							if distanceToDoor <= currDistance then
								currDistance = distanceToDoor;
								currMovement = MovementList[i];
							end
						end
					end
				end
				
				if currDistance < MovementDistance.DISTANCE_PLAYER_DOOR then
					return currMovement, currDistance;
				end
			end
			
			if MovementList[1].type == MovementType.TYPE_DOOR and currDistance < MovementDistance.DISTANCE_PLAYER_DOOR then
				return MovementList[1], currDistance;
			end
		end
	end
	return nil;
end

function GetNearestMovement(playerid)
	
	local gate,distanceGate = GetNearestGate(playerid);
	local door,distanceDoor = GetNearestDoor(playerid);
	
	if gate ~= nil and door ~= nil then
		if distanceGate < distanceDoor then
			return gate, distanceGate;
		else
			return door, distanceDoor;
		end
	elseif gate == nil and door ~= nil then
		return door, distanceDoor;
	elseif gate ~= nil and door == nil then
		return gate, distanceGate;
	end
	
	return nil;
end

function MovementProcess() --Timer

	for i = 1, #MovementList do
		if MovementList[i].type == MovementType.TYPE_GATE then
		
			local x,y,z = MovementList[i].vobID:GetPosition();
		
			if MovementList[i].status == MovementStatus.STATUS_MOVING_TO_OPEN then --gate is moving to open
			
				local distanceMove = GetDistance3D(x,y,z,MovementList[i].opened_posX,MovementList[i].opened_posY,MovementList[i].opened_posZ); --calculate distance for fixing position
				
				if MovementList[i].opened_posY < MovementList[i].closed_posY then --if opened gate is lower than closed gate (default)
					if y > MovementList[i].opened_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y - MovementDistance.DISTANCE_MOVE_GATE,z); -- destination is far
						else
							MovementList[i].vobID:SetPosition(x,y - distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_OPENED;
					end
				else --if opened gate is higher than closed gate (default)
					if y < MovementList[i].opened_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y + MovementDistance.DISTANCE_MOVE_GATE,z);
						else
							MovementList[i].vobID:SetPosition(x,y + distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_OPENED;
					end
				end
			
			elseif MovementList[i].status == MovementStatus.STATUS_MOVING_TO_CLOSE then --gate is moving to close
				
				local distanceMove = GetDistance3D(x,y,z,MovementList[i].closed_posX,MovementList[i].closed_posY,MovementList[i].closed_posZ); --calculate distance for fixing position
				
				if MovementList[i].opened_posY < MovementList[i].closed_posY then --if opened gate is lower than closed gate (default)
					if y < MovementList[i].closed_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y + MovementDistance.DISTANCE_MOVE_GATE,z); -- destination is far
						else
							MovementList[i].vobID:SetPosition(x,y + distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_CLOSED;
					end
				else --if opened gate is higher than closed gate (default)
					if y > MovementList[i].closed_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y - MovementDistance.DISTANCE_MOVE_GATE,z); -- destination is far
						else
							MovementList[i].vobID:SetPosition(x,y - distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_CLOSED;
					end
				end
			end
		end
	end
end

function OnPlayerCommandText(playerid, cmdtext)

	if cmdtext == "/open" then
	
		local movement = GetNearestMovement(playerid);
		if movement ~= nil then
			OpenMovement(movement);
			GameTextForPlayer(playerid,2500,4000,"Movement opened!","Font_Old_20_White_Hi.TGA",0,255,0,3000);
		end
	
	elseif cmdtext == "/close" then
	
		local movement = GetNearestMovement(playerid);
		if movement ~= nil then
			CloseMovement(movement);
			GameTextForPlayer(playerid,2500,4000,"Movement closed!","Font_Old_20_White_Hi.TGA",255,255,0,3000);
		end
	end
end