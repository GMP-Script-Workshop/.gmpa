local tim;

function OnFilterscriptInit()
	print("-------------------------------------------");
	print("Description filterscript");
	print("-------------------------------------------");

	tim = SetTimerEx("Lolek",5000,0,0);

        Enable_OnPlayerKey(1);
end

function OnFilterscriptExit()
	print("------------------------");
	print("Removing filterscript...");
	print("------------------------");
end

function Lolek()

	SetServerHostname("Z czym do ludzi, panie...");
	SetGamemodeName("This is SPARTAKUS");
	SetServerDescription("To jest opis mojego serwera niocho");
end

function OnPlayerChangeClass(playerid, classid)
 
end

function OnPlayerSelectClass(playerid, classid)
 
end

function OnPlayerConnect(playerid)
 
end

function OnPlayerDisconnect(playerid, reason)

end

function OnPlayerSpawn(playerid, classid)
 
end

function OnPlayerDeath(playerid, p_classid, killerid, k_classid)
 
end

function OnPlayerHit(playerid, killerid)
 
end

function OnPlayerUnconscious(playerid, p_classid, killerid, k_classid)

end

function OnPlayerText(playerid, text)

end

function OnPlayerCommandText(playerid, cmdtext)

    if cmdtext == "/ice" then

         SetPlayerInstance(playerid,"DRAGON_ICE");

    elseif cmdtext == "/fire" then

         SetPlayerInstance(playerid,"DRAGON_FIRE");

    elseif cmdtext == "/hero" then

         SetPlayerInstance(playerid,"PC_HERO");
    
    elseif cmdtext == "/get" then

         local x,y,z = GetPlayerPos(playerid);
         local angle = GetPlayerAngle(playerid);

         local msg = string.format("%f %f %f %f",x,y,z,angle);
         SendPlayerMessage(playerid,255,255,0,msg);

    elseif cmdtext == "/khorinis" then

         SetPlayerWorld(playerid,"NEWWORLD\\NEWWORLD.ZEN","START_OW_ORETRAIL");

    elseif cmdtext == "/gd" then

         SetPlayerWorld(playerid,"OLDWORLD\\OLDWORLD.ZEN","START"); --"WP_INTRO13");

    elseif cmdtext == "/ir" then

         SetPlayerWorld(playerid,"NEWWORLD\\DRAGONISLAND.ZEN","START");

    elseif cmdtext == "/tpgd" then
         SetPlayerPos(playerid,1786.0162,247.9422,-163.0392);

    elseif cmdtext == "/fat" then
         SetPlayerFatness(playerid,5.0);

    elseif cmdtext == "/scaler" then
	SetPlayerScale(playerid,1.0,1.0,1.0);

    elseif cmdtext == "/scalen" then
	SetPlayerScale(playerid,1.1,1.1,1.1);

    elseif cmdtext == "/armor" then
	EquipArmor(playerid,"ITAR_KDF_L");
    end
end

function OnPlayerChangeWorld(playerid, world)

end

function OnPlayerEnterWorld(playerid, world)

end

function OnPlayerDropItem(playerid, itemid, item_instance, amount, x, y, z)

end

function OnPlayerTakeItem(playerid, itemid, item_instance, amount, x, y, z)

end

function OnPlayerKey(playerid, kX, kY)

    if kX == KEY_Y then
       local x,y,z = GetPlayerPos(playerid);
       SetPlayerPos(playerid,x, y + 300,z);
    end
end