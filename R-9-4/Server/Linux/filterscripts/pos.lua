function OnFilterscriptInit()
	print("-------------------------------------------");
	print("Pozycje");
	print("-------------------------------------------");
end

function OnFilterscriptExit()
	print("--------------------------------------");
	print("Pozycje off...");
	print("--------------------------------------");
end


function OnPlayerCommandText(playerid, cmdtext)

    local cmd,params = GetCommand(cmdtext);
	if cmd == "/spawn" then
		Pos(params, playerid);
	end
end

function Pos(params, playerid)
	local result, mob, amount = sscanf(params, "sd");
	if result == 1 then
		local x, y, z = GetPlayerPos(playerid);

		local File = io.open("Pozycje.txt","a+");
		File:write(mob.." "..amount..": "..x..", "..y..", "..z.." "..GetPlayerAngle(playerid).."\n");
		File:close();
	end
end
