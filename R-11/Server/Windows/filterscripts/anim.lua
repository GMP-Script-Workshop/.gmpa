function OnFilterscriptInit()
	print("-------------------------------------------");
	print("Animations by Xawier");
	print("-------------------------------------------");
end

function OnFilterscriptExit()
	print("------------------------");
	print("Removing animations...");
	print("------------------------");
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

function OnPlayerDeath(playerid, killerid)
 
end

function OnPlayerText(playerid, text)

end

function OnPlayerCommandText(playerid, cmdtext)

	if cmdtext == "/sit" then
	   PlayAnimation(playerid,"T_STAND_2_SIT");
 
	elseif cmdtext == "/bed" then
	   PlayAnimation(playerid,"T_STAND_2_SLEEPGROUND");
		
	elseif cmdtext == "/pee" then
	   PlayAnimation(playerid,"T_STAND_2_PEE");
		
	elseif cmdtext == "/tren1h" then
	   PlayAnimation(playerid,"T_1HSFREE");
		
	elseif cmdtext == "/watch1h" then
	   PlayAnimation(playerid,"T_1HSINSPECT");
		
	elseif cmdtext == "/anihelp" then
        SendPlayerMessage(playerid,255,255,255,"Anims: /sit, /bed, /pee, /tren1h, /watch1h, /pray, /search"); 
        SendPlayerMessage(playerid,255,255,255,"/plunder, /guard, /guard1, /finisher, /dead, /wash, /practicemagic, /practicemagic2, /practicemagic3, /practicemagic4");
		
	elseif cmdtext == "/pray" then
	   PlayAnimation(playerid,"S_PRAY");
	   
	elseif cmdtext == "/search" then
	   PlayAnimation(playerid,"T_SEARCH");
	   
	elseif cmdtext == "/plunder" then
	   PlayAnimation(playerid,"T_PLUNDER");
	   
	elseif cmdtext == "/guard" then
	   PlayAnimation(playerid,"S_LGUARD");
	   
	elseif cmdtext == "/guard1" then
	   PlayAnimation(playerid,"S_HGUARD");

	elseif cmdtext == "/finisher" then
	   PlayAnimation(playerid,"T_1HSFINISH");
	   
	elseif cmdtext == "/dead" then
	   PlayAnimation(playerid,"S_DEAD");   

	elseif cmdtext == "/wash" then
	   PlayAnimation(playerid,"S_WASH");   
	
	elseif cmdtext == "/practicemagic" then
	   PlayAnimation(playerid,"T_PRACTICEMAGIC");    
	 
	elseif cmdtext == "/practicemagic2" then
	   PlayAnimation(playerid,"T_PRACTICEMAGIC2");    

	elseif cmdtext == "/practicemagic3" then
	   PlayAnimation(playerid,"T_PRACTICEMAGIC3");    

	elseif cmdtext == "/practicemagic4" then
	   PlayAnimation(playerid,"T_PRACTICEMAGIC4");   
	end
end

function OnPlayerChangeWorld(playerid, world)

end

function OnPlayerEnterWorld(playerid, world)

end