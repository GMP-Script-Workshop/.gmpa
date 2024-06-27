local chat_roleplay = false;

function OnFilterscriptInit()
	print("-------------------------------------------");
	print("Roleplay chat test");
	print("-------------------------------------------");
end

function OnFilterscriptExit()
	print("--------------------------------------");
	print("Removing roleplay chat filterscript...");
	print("--------------------------------------");
end

function OnPlayerConnect(playerid)

end

function OnPlayerText(playerid, text)

	if chat_roleplay == true
	then
	    local name = GetPlayerName(playerid);
	
		for i = 0, GetMaxSlots() - 1
		do
			if IsPlayerConnected(i) == 1
			then
			
				if GetDistancePlayers(playerid,i) < 1000
				then
					SendPlayerMessage(i,230,230,230,string.format("%s %s %s.",name,"says:",text));
				end
			end
		end
	end
end

function OnPlayerCommandText(playerid, cmdtext)

	if IsPlayerAdmin(playerid) == 1
	then
		if cmdtext == "/chatenable" then	
			chat_roleplay = true;
			EnableChat(0); --enable rp chat, disable global chat
			SendMessageToAll(0,255,0,"Roleplay chat was enabled.");
		elseif cmdtext == "/chatdisable" then
			chat_roleplay = false;
			EnableChat(1); --disable rp chat, enable global chat
			SendMessageToAll(255,255,0,"Roleplay chat was disabled.");
		end
	end
end