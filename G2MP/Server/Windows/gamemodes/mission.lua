local Player = {};

--Global draws, textures
local g_draw;
local g_background;

--Vasilij
local vasilij = -1;

local VAS_SOUND = 15;
local Vasilij_Sound;

local VAS_DRAW = 17;
local Vasilij_Draw;

function NPC_Vasilij()
    
	vasilij = CreateNPC("Vasilij");
	SpawnPlayer(vasilij);
	SetPlayerAdditionalVisual(vasilij,"Hum_Body_Naked0",2,"Hum_Head_Pony",29);
	SetPlayerPos(vasilij,1074.059,-96.45,-1414.107);
	SetPlayerAngle(vasilij,225);
	EquipArmor(vasilij,"ITAR_VLK_M");
	EquipMeleeWeapon(vasilij,"ITMW_KRIEGSKEULE");
	PlayAnimation(vasilij,"S_LGUARD");
	
	--Sound
	Vasilij_Sound = {};
	for i = 0, VAS_SOUND - 1 do
	    Vasilij_Sound[i] = -1;
	end
	
	Vasilij_Sound[0] = CreateSound("DIA_RAOUL_TROLL_01_00.WAV"); --spojrzcie na niego
	Vasilij_Sound[1] = CreateSound("DIA_RAOUL_TROLL_RECHNUNG_15_00.WAV"); -- w czym problem
	Vasilij_Sound[2] = CreateSound("DIA_RAOUL_TROLL_RECHNUNG_01_02.WAV"); --gardze ludzmi, ktorzy...
	Vasilij_Sound[3] = CreateSound("DIA_RAOUL_TROLL_RECHNUNG_15_04.WAV"); -- i co w tym dziwnego
	Vasilij_Sound[4] = CreateSound("DIA_RAOUL_TROLL_RECHNUNG_01_01.WAV"); --znam ja takich jak ty
	Vasilij_Sound[5] = CreateSound("DIA_RAOUL_TROLL_RECHNUNG_01_03.WAV"); --nie dalej jak wczoraj...
	Vasilij_Sound[6] = CreateSound("DIA_RAOUL_TROLL_RECHNUNG_B_RAOUL_BLAME_01_05.WAV"); --powiedzmy ze jesli przyniesiesz mi...
	Vasilij_Sound[7] = CreateSound("DIA_RAOUL_TROLL_RECHNUNG_NOPROB_15_00.WAV"); --czarnego trola? zaden problem
	Vasilij_Sound[8] = CreateSound("DIA_RAOUL_TROLL_RECHNUNG_01_06.WAV"); --czys ty kiedys widzial czarnego trola
	Vasilij_Sound[9] = CreateSound("DIA_RAOUL_TROLL_WEG_15_00.WAV"); --musze juz isc
	Vasilij_Sound[10] = CreateSound("DIA_RAOUL_TROLL_WEG_01_01.WAV"); --tak.. spadaj
	Vasilij_Sound[11] = CreateSound("DIA_RAOUL_TROLLFELL_15_00.WAV"); --mam skore czarnego trola
	Vasilij_Sound[12] = CreateSound("DIA_RAOUL_TROLLFELL_01_02.WAV"); --nieprawdopodobne. co za nia chcesz
	Vasilij_Sound[13] = CreateSound("DIA_RAOUL_TROLLFELL_15_03.WAV"); --dawaj wszystko co masz
	Vasilij_Sound[14] = CreateSound("DIA_RAOUL_TROLLFELL_JA_01_01.WAV"); --interesy z toba to sama przyjemnosc
	
	--Draw
	Vasilij_Draw = {};
	for i = 0, VAS_DRAW - 1 do
	    Vasilij_Draw[i] = -1;
	end
	
	Vasilij_Draw[0] = CreateDraw(3200,6000,"Vasilij: Spójrzcie na niego..","Font_Old_10_White_Hi.TGA",255,255,0);
	Vasilij_Draw[1] = CreateDraw(3500,6500,"Ja: W czym problem?","Font_Old_10_White_Hi.TGA",255,255,255);
	Vasilij_Draw[2] = CreateDraw(600,6000,"Vasilij: Gardzê ludŸmi, którzy stroj¹ siê jak pawie. I chwal¹ siê swoimi bohaterskimi czynami.","Font_Old_10_White_Hi.TGA",255,255,0);
	Vasilij_Draw[3] = CreateDraw(3200,6500,"Ja: I co w tym dziwnego?","Font_Old_10_White_Hi.TGA",255,255,255);
	Vasilij_Draw[4] = CreateDraw(2500,6000,"Vasilij: Znam ja takich jak ty. Mocni tylko w gêbie..","Font_Old_10_White_Hi.TGA",255,255,0);
	
	Vasilij_Draw[5] = CreateDraw(500,6000,"Vasilij: Nie dalej ni¿ wczoraj musia³em zdzieliæ w pysk jednego z ch³opaków, bo przechwala³ siê,","Font_Old_10_White_Hi.TGA",255,255,0);
	Vasilij_Draw[6] = CreateDraw(1500,6200,"¿e nawet z jedn¹ rek¹ uwi¹zan¹ za plecami mo¿e powaliæ czarnego trola.","Font_Old_10_White_Hi.TGA",255,255,0);
	
	Vasilij_Draw[7] = CreateDraw(500,6000,"Vasilij: Hmmm, emm.. Powiedzmy, ¿e jeœli przyniesiesz mi skórê czarnego trola obsypie ciê z³otem.","Font_Old_10_White_Hi.TGA",255,255,0);
	Vasilij_Draw[8] = CreateDraw(3600,6200,"Co ty na to?","Font_Old_10_White_Hi.TGA",255,255,0);
	
	Vasilij_Draw[9] = CreateDraw(2700,6500,"Ja: Czarnego trola? ¯aden problem.","Font_Old_10_White_Hi.TGA",255,255,255);
	Vasilij_Draw[10] = CreateDraw(100,6000,"Czyœ ty kiedyœ widzia³ czarnego trola m¹dralo? Nie masz nawet pojêcia jakie to wielkie i groŸne bestie.","Font_Old_10_White_Hi.TGA",255,255,0);
	Vasilij_Draw[11] = CreateDraw(3500,6500,"Muszê ju¿ iœæ.","Font_Old_10_White_Hi.TGA",255,255,255);
	Vasilij_Draw[12] = CreateDraw(3500,6000,"Vasilij: Tak.. Spadaj.","Font_Old_10_White_Hi.TGA",255,255,0);
	Vasilij_Draw[13] = CreateDraw(3000,6500,"Ja: Mam skórê czarnego trola.","Font_Old_10_White_Hi.TGA",255,255,255);
	Vasilij_Draw[14] = CreateDraw(2500,6000,"Vasilij: Nieprawdopodobne. Co za ni¹ chcesz?","Font_Old_10_White_Hi.TGA",255,255,0);
	Vasilij_Draw[15] = CreateDraw(3000,6500,"Ja: Dawaj wszystko co masz.","Font_Old_10_White_Hi.TGA",255,255,255);
	Vasilij_Draw[16] = CreateDraw(2500,6000,"Vasilij: Interesy z tob¹ to sama przyjemnoœæ.","Font_Old_10_White_Hi.TGA",255,255,0);
end
--End vasilij

--Troll
local MIN_TROLL_DISTANCE  = 400;
local MAX_TROLL_DISTANCE = 2000;

local troll_timer;
local troll;

local troll_tid = -1; --target
local troll_stop = true;

local troll_hittimer;
local troll_instancehit = false;

function NPC_Troll()

	troll = CreateNPC("Czarny trol");
	SpawnPlayer(troll);
	SetPlayerInstance(troll,"TROLL_BLACK");
	SetPlayerMaxHealth(troll,2000);
	SetPlayerHealth(troll,2000);
	SetPlayerStrength(troll,100);
	SetPlayerPos(troll,51335.53,8000.31,36147.78);
	SetPlayerAngle(troll,160);
	
	troll_timer = SetTimer("Troll_AI",500,1);
end
--End troll

function CreateStructurePlayers()

    for i = 0, GetMaxSlots() - 1 do
	  
	    Player[i] = {};
		
		Player[i].talking = false;
	    Player[i].talk_timer = -1;
		   
	     --Vasilij mission
	    Player[i].vas_finished = false;
		Player[i].vas_missionstart = false;
	    Player[i].vas_talk = false;
		Player[i].vas_dialog = -1;
		Player[i].vas_killedbytroll = false;
		Player[i].vas_trollskin = false;
	end
end

function CreateGlobalView()

	 g_draw = CreateDraw(2700,6500,"Nacisnij CTRL aby porozmawiac z NPC.","Font_Old_10_White_Hi.TGA",255,100,0);
	 g_texture = CreateTexture(2500,6300,5900,7000,"Frame_GMPA.TGA");
end

--Clear player if is disconnected
function ClearPlayer(playerid)

     Player[playerid].talking = false;
     Player[playerid].talk_timer = -1;
	 
	 --Vasilij mission
	  Player[playerid].vas_finished = false;
	  Player[playerid].vas_missionstart = false;
	  Player[playerid].vas_talk = false;
	  Player[playerid].vas_dialog = -1;
	  Player[playerid].vas_killedbytroll = false;
	  Player[playerid].vas_trollskin = false;
end

function DestroyAllNPC()

	DestroyNPC(vasilij);
	DestroyNPC(troll);
end

function OnGamemodeInit()
	
	print("--------------------");
	print("MMORPG mission");
	print("--------------------");
	
	SetServerDescription("Vasilij zleca nam zadanie zdobycia skóry czarnego trola, który powinien znajdowaæ siê w okolicy jaskini. Spróbuj go pokonaæ! W nagrodê mo¿na otrzymaæ z³oto i inne ciekawe przedmioty. Powodzenia!");
	SetGamemodeName("MMORPG mission");
	SetRespawnTime(10 * 1000); --10 seconds
	
	CreateStructurePlayers();
	CreateGlobalView();
	
	--NPC
	NPC_Vasilij();
	NPC_Troll();
	
	AddPlayerClass("PC_HERO",50616,7859,36823,120,0.0,0.0,0.0,90);
	AddPlayerClass("PC_HERO",50616,7859,36823,120,0.0,0.0,0.0,90);
	AddPlayerClass("PC_HERO",50616,7859,36823,120,0.0,0.0,0.0,90);
end

function OnGamemodeExit()

	print("-------------------");
	print("MMORPG mission exited.");
	print("-------------------");

	--Destroy
	DestroyAllNPC();
end

function Talking(playerid)

    if Player[playerid].vas_talk == true then
	
	    if Player[playerid].vas_dialog == 0 then --spojrzcie na niego
		
		    Player[playerid].vas_dialog = 1;
			Player[playerid].talk_timer = SetTimerEx("Talking",1000,0,playerid);
					
			PlayPlayerSound(playerid,Vasilij_Sound[1]);
			
			HideDraw(playerid,Vasilij_Draw[0]);
			ShowDraw(playerid,Vasilij_Draw[1]);
			
			PlayGesticulation(playerid);
			
		elseif Player[playerid].vas_dialog == 1 then -- w czym problem
		
		    Player[playerid].vas_dialog = 2;
			Player[playerid].talk_timer = SetTimerEx("Talking",7300,0,playerid);
					
			PlayPlayerSound(playerid,Vasilij_Sound[2]);
			
			HideDraw(playerid,Vasilij_Draw[1]);
			ShowDraw(playerid,Vasilij_Draw[2]);
			
			PlayGesticulation(vasilij);
			
		elseif Player[playerid].vas_dialog == 2 then --gardze ludzmi, ktorzy...
		
		    Player[playerid].vas_dialog = 3;
			Player[playerid].talk_timer = SetTimerEx("Talking",1300,0,playerid);
					
			PlayPlayerSound(playerid,Vasilij_Sound[3]);
			
			HideDraw(playerid,Vasilij_Draw[2]);
			ShowDraw(playerid,Vasilij_Draw[3]);
			
			PlayGesticulation(playerid);
			
		elseif Player[playerid].vas_dialog == 3 then --i co w tym dziwnego
		
		    Player[playerid].vas_dialog = 4;
			Player[playerid].talk_timer = SetTimerEx("Talking",4000,0,playerid);
					
			PlayPlayerSound(playerid,Vasilij_Sound[4]);
			
			HideDraw(playerid,Vasilij_Draw[3]);
			ShowDraw(playerid,Vasilij_Draw[4]);
			
			PlayGesticulation(vasilij);
			
		elseif Player[playerid].vas_dialog == 4 then --znam ja takich jak ty
		
		    Player[playerid].vas_dialog = 5;
			Player[playerid].talk_timer = SetTimerEx("Talking",12500,0,playerid);
					
			PlayPlayerSound(playerid,Vasilij_Sound[5]);
			
			HideDraw(playerid,Vasilij_Draw[4]);
			ShowDraw(playerid,Vasilij_Draw[5]);
			ShowDraw(playerid,Vasilij_Draw[6]);
			
			PlayGesticulation(vasilij);
			
		elseif Player[playerid].vas_dialog == 5 then --nie dalej jak wczoraj...
		
		    Player[playerid].vas_dialog = 6;
			Player[playerid].talk_timer = SetTimerEx("Talking",8500,0,playerid);
					
			PlayPlayerSound(playerid,Vasilij_Sound[6]);
			
			HideDraw(playerid,Vasilij_Draw[5]);
			HideDraw(playerid,Vasilij_Draw[6]);
			
			ShowDraw(playerid,Vasilij_Draw[7]);
			ShowDraw(playerid,Vasilij_Draw[8]);
			
			PlayGesticulation(vasilij);
			
		elseif Player[playerid].vas_dialog == 6 then --powiedzmy ze jesli przyniesiesz mi...
		
		    Player[playerid].vas_dialog = 7;
			Player[playerid].talk_timer = SetTimerEx("Talking",2500,0,playerid);
					
			PlayPlayerSound(playerid,Vasilij_Sound[7]);
			
			HideDraw(playerid,Vasilij_Draw[7]);
			HideDraw(playerid,Vasilij_Draw[8]);
			
			ShowDraw(playerid,Vasilij_Draw[9]);
			
			PlayGesticulation(playerid);
			
		elseif Player[playerid].vas_dialog == 7 then --czarnego trola? zaden problem
		
		    Player[playerid].vas_dialog = 8;
			Player[playerid].talk_timer = SetTimerEx("Talking",8500,0,playerid);
					
			PlayPlayerSound(playerid,Vasilij_Sound[8]);
			
			HideDraw(playerid,Vasilij_Draw[9]);
			ShowDraw(playerid,Vasilij_Draw[10]);
			
			PlayGesticulation(vasilij);
			
		elseif Player[playerid].vas_dialog == 8 then --czys ty kiedys widzial czarnego trola
		
			Player[playerid].vas_dialog = 9;
			Player[playerid].talk_timer = SetTimerEx("Talking",1000,0,playerid);
					
			PlayPlayerSound(playerid,Vasilij_Sound[9]);
			
			HideDraw(playerid,Vasilij_Draw[10]);
			ShowDraw(playerid,Vasilij_Draw[11]);
			
			PlayGesticulation(playerid);
		
		elseif Player[playerid].vas_dialog == 9 then --musze juz isc
		
		    Player[playerid].vas_dialog = 10;
			Player[playerid].talk_timer = SetTimerEx("Talking",2500,0,playerid);
					
			PlayPlayerSound(playerid,Vasilij_Sound[10]);
			
			HideDraw(playerid,Vasilij_Draw[11]);
			ShowDraw(playerid,Vasilij_Draw[12]);
			
			PlayGesticulation(vasilij);
			
		elseif Player[playerid].vas_dialog == 10 then --tak.. spadaj
		
		    Player[playerid].talking = false;
            Player[playerid].talk_timer = -1;
	 
	        Player[playerid].vas_talk = false;
			Player[playerid].vas_dialog = 9; --musze juz isc (petla dopoki nie zdobedziemy skory czarnego trola)
		
			FreezePlayer(playerid,0);
		    HideDraw(playerid,Vasilij_Draw[12]);
			
			if Player[playerid].vas_missionstart == false and Player[playerid].vas_finished == false then
			
				GameTextForPlayer(playerid,200,3500,"Nowa misja: Zdob¹dŸ dla Vasilija skórê czarnego trola w zamian za co mo¿esz otrzymaæ trochê z³ota.","Font_Old_10_White_Hi.TGA",255,255,0,8000);
				Player[playerid].vas_missionstart = true; --idziemy zabic trola
				GiveItem(playerid,"ITWR_MAP_NEWWORLD",1);
			elseif Player[playerid].vas_missionstart == true and Player[playerid].vas_finished == false then
			
				GameTextForPlayer(playerid,1500,3500,"Zdob¹dŸ dla Vasilija skórê czarnego trola zanim z nim porozmawiasz!","Font_Old_10_White_Hi.TGA",255,150,0,5000);
			end
			
		--Kontynuacja, rozmowa o oddawaniu skory
		elseif Player[playerid].vas_dialog == 11 then --mam skore czarnego trola
		
			Player[playerid].vas_dialog = 12;
			Player[playerid].talk_timer = SetTimerEx("Talking",3200,0,playerid);
			
			PlayPlayerSound(playerid,Vasilij_Sound[12]);
		
			ShowDraw(playerid,Vasilij_Draw[14]);
			HideDraw(playerid,Vasilij_Draw[13]);
			
			PlayGesticulation(vasilij);
			
		elseif Player[playerid].vas_dialog == 12 then --nieprawdopodone. co za nia chcesz
		
			Player[playerid].vas_dialog = 13;
			Player[playerid].talk_timer = SetTimerEx("Talking",1800,0,playerid);
			
			PlayPlayerSound(playerid,Vasilij_Sound[13]);
		
			ShowDraw(playerid,Vasilij_Draw[15]);
			HideDraw(playerid,Vasilij_Draw[14]);
			
			PlayGesticulation(playerid);
			
		elseif Player[playerid].vas_dialog == 13 then --dawaj wszystko co masz
		
			Player[playerid].vas_dialog = 14;
			Player[playerid].talk_timer = SetTimerEx("Talking",3500,0,playerid);
			
			PlayPlayerSound(playerid,Vasilij_Sound[14]);
		
			ShowDraw(playerid,Vasilij_Draw[16]);
			HideDraw(playerid,Vasilij_Draw[15]);
			
			PlayGesticulation(vasilij);
			
		elseif Player[playerid].vas_dialog == 14 then --interesy z toba to sama przyjemnosc
		
		    Player[playerid].talking = false;
            Player[playerid].talk_timer = -1;
	 
	        Player[playerid].vas_talk = false;
			Player[playerid].vas_finished = true;
			Player[playerid].vas_dialog = 9; --musze juz isc (petla dopoki nie zdobedziemy skory czarnego trola)
			
			FreezePlayer(playerid,0);
			HideDraw(playerid,Vasilij_Draw[16]);
			
			GameTextForPlayer(playerid,500,3500,"Otrzyma³eœ 500 sztuk z³ota, 20 mikstur leczniczych, ostrze, pancerz, 50 kie³bas oraz 45 piw.","Font_Old_10_White_Hi.TGA",0,255,0,8000);
			
			SetPlayerStrength(playerid,160);
			SetPlayerSkillWeapon(playerid,1,70);
			
			RemoveItem(playerid,"ITAT_TROLLBLACKFUR",1);
			GiveItem(playerid,"ITMI_GOLD",500);
			GiveItem(playerid,"ItPo_Health_Addon_04",20);
			EquipMeleeWeapon(playerid,"ITMW_2H_SPECIAL_04");
			EquipArmor(playerid,"ITAR_OreBaron_Addon");
			GiveItem(playerid,"ITFO_SAUSAGE",50);
			GiveItem(playerid,"ITFO_BEER",45);
		end
	end
end

function OnPlayerKey(playerid, keydown)

     if keydown == KEY_LCONTROL then
	 
	     if GetFocus(playerid) == vasilij then
		 
		    if Player[playerid].talking == false then  --if not talking with anyone
			
			     if Player[playerid].vas_talk == false and Player[playerid].vas_dialog == -1 then --vasilij mission 
					
				    Player[playerid].talking = true; --begin talk
					Player[playerid].vas_talk = true; --begin talk with Vasilij
					Player[playerid].vas_dialog = 0;
					
					SetPlayerAngle(playerid,GetAngleToPlayer(playerid,vasilij));
					FreezePlayer(playerid,1);
					SetPlayerAngle(vasilij,GetAngleToPlayer(vasilij,playerid));
					
					Player[playerid].talk_timer = SetTimerEx("Talking",2500,0,playerid);
					
					PlayPlayerSound(playerid,Vasilij_Sound[0]);
					ShowDraw(playerid,Vasilij_Draw[0]);
					HideDraw(playerid,g_draw); --global draw (npc area info)
					HideTexture(playerid,g_texture);
					
					PlayGesticulation(vasilij);
					
				 elseif Player[playerid].vas_talk == false and Player[playerid].vas_dialog == 9 then
				 
				    Player[playerid].talking = true; --begin talk
					Player[playerid].vas_talk = true; --begin talk with Vasilij
					
					SetPlayerAngle(playerid,GetAngleToPlayer(playerid,vasilij));
					FreezePlayer(playerid,1);
					SetPlayerAngle(vasilij,GetAngleToPlayer(vasilij,playerid));
					
					HideDraw(playerid,g_draw); --global draw (npc area info)
					HideTexture(playerid,g_texture);
					
					if Player[playerid].vas_finished == false then
					
						HasItem(playerid,"ITAT_TROLLBLACKFUR",123);
						SetTimerEx("CheckTrollSkin",500,0,playerid);
					else
					
						Player[playerid].talk_timer = SetTimerEx("Talking",1000,0,playerid);
			
						PlayPlayerSound(playerid,Vasilij_Sound[9]);			
						ShowDraw(playerid,Vasilij_Draw[11]);
		
						PlayGesticulation(playerid);
					end
				 end
			 end
		 end
	 end
end

function OnPlayerHasItem(playerid, item_instance, amount, equipped, checkid)

	if checkid == 123 then
	
		if item_instance == "ITAT_TROLLBLACKFUR" then --mamy skore czarnego trola
		
			Player[playerid].vas_trollskin = true;
		end
	end
end

function CheckTrollSkin(playerid)

	HideDraw(playerid,g_draw); --global draw (npc area info)
	HideTexture(playerid,g_texture);

	if Player[playerid].vas_trollskin == true then --jezeli mamy skore trola
	
		Player[playerid].vas_dialog = 11;
		Player[playerid].talk_timer = SetTimerEx("Talking",2000,0,playerid);
	
		PlayPlayerSound(playerid,Vasilij_Sound[11]);	
		ShowDraw(playerid,Vasilij_Draw[13]);
		
		PlayGesticulation(playerid);
		
	else --jezeli nie mamy skory trola
	
		Player[playerid].talk_timer = SetTimerEx("Talking",1000,0,playerid);
			
		PlayPlayerSound(playerid,Vasilij_Sound[9]);			
		ShowDraw(playerid,Vasilij_Draw[11]);
		
		PlayGesticulation(playerid);
	end
end

function OnPlayerFocus(playerid, focusid)

	if focusid == vasilij then
		ShowTexture(playerid,g_texture);
		ShowDraw(playerid,g_draw);
		
		SetPlayerEnable_OnPlayerKey(playerid,1);
	else
		HideDraw(playerid,g_draw);
		HideTexture(playerid,g_texture);
		
	    SetPlayerEnable_OnPlayerKey(playerid,0);
	end
end

function Troll_AI()
	
	if troll_tid == -1 then
	
		for i = 0, GetMaxSlots() - 1 do
		
			if IsPlayerConnected(i) == 1 and IsNPC(i) == 0 and GetPlayerHealth(i) > 0 and GetPlayerHealth(troll) > 0 then
			
				if GetDistancePlayers(troll,i) <= MAX_TROLL_DISTANCE then
				
					troll_tid = i;
					troll_stop = false;
					PlayAnimation(troll,"S_FISTRUNL");
					break;
				end
			end
		end
	else
		
		if IsPlayerConnected(troll_tid) == 1 then
		
			local angle = GetAngleToPlayer(troll,troll_tid);
			
			if angle ~= GetPlayerAngle(troll) then
				SetPlayerAngle(troll,angle);
			end
			
			local distance = GetDistancePlayers(troll,troll_tid);
			
			if distance <= MAX_TROLL_DISTANCE then --jezeli cel jest w zasiegu trola
		
				if troll_stop == false then --jezeli biegnie
			
					if distance <= MIN_TROLL_DISTANCE then --jezeli trol znajduje sie blisko celu to zatrzymujemy go
				
						troll_stop = true; --stop
						PlayAnimation(troll,"S_FISTRUN");
					end
				
				else --jezeli stoi
				
					if distance > MIN_TROLL_DISTANCE then --jezeli trol znajduje sie daleko od celu to poruszamy go
				
						troll_stop = false; --poruszamy
						PlayAnimation(troll,"S_FISTRUNL");
					end
				end
				
				--Instancja hitu
				if troll_stop == true and troll_instancehit == false then --jezeli trol stoi obok celu i nie zaczal uderzac, zaczyna uderzac
				
					troll_instancehit = true;
					SetTimer("Troll_Hit",1000,0);
					PlayAnimation(troll,"S_FISTATTACK");
				end
				
			else --jezeli cel nie jest w zasiegu trola, resetujemy cel
				
				troll_tid = -1;
				troll_stop = true; --stop
				PlayAnimation(troll,"S_FISTRUN");
			end
			
		else --brak gracza, gracz jest martwy lub trol jest martwy
		
			if troll_stop == false then --jezeli biegnie
			
				troll_tid = -1;
				troll_stop = true;
				PlayAnimation(troll,"S_FISTRUN");
			end
		end
	end
end

function Troll_Hit()

	if troll_tid ~= -1 then --jezeli cel istnieje
	
		if IsPlayerConnected(troll_tid) == 1 then --jezeli cel jest polaczony
		
			local distance = GetDistancePlayers(troll,troll_tid);
			
			if distance <= MIN_TROLL_DISTANCE then --jezeli trol znajduje sie obok celu
				
				HitPlayer(troll,troll_tid);
				PlayAnimation(troll,"S_FISTRUN");
			end
		end
	end
	
	troll_instancehit = false
end

--Klasy graczy
function Tank(playerid)
           
    SetPlayerInstance(playerid,"PC_HERO");
    SetPlayerAdditionalVisual(playerid,"Hum_Body_Naked0",3,"Hum_Head_Psionic",59);
	SetPlayerWalk(playerid,"HumanS_Arrogance.mds");
    SetPlayerMaxHealth(playerid,3800);
    SetPlayerHealth(playerid,3800);
    SetPlayerStrength(playerid,100);
    SetPlayerSkillWeapon(playerid,0,50);
    EquipArmor(playerid,"ITAR_DJG_H");
    EquipMeleeWeapon(playerid,"ITMW_SCHWERT2");
    GiveItem(playerid,"ItPo_Health_Addon_04",10);
end
     
function Fighter(playerid)
           
    SetPlayerInstance(playerid,"PC_HERO");
    SetPlayerAdditionalVisual(playerid,"Hum_Body_Naked0",2,"Hum_Head_Fighter",120);
	SetPlayerWalk(playerid,"HumanS_Relaxed.mds");
    SetPlayerMaxHealth(playerid,2800);
    SetPlayerHealth(playerid,2800);
    SetPlayerStrength(playerid,120);
    SetPlayerDexterity(playerid,70);
    SetPlayerSkillWeapon(playerid,0,50);
    EquipArmor(playerid,"ITAR_SLD_H");
    EquipMeleeWeapon(playerid,"ITMW_SCHWERT5");
    GiveItem(playerid,"ItPo_Health_Addon_04",10);
end
     
function Archer(playerid)
     
    SetPlayerInstance(playerid,"PC_HERO");
    SetPlayerAdditionalVisual(playerid,"Hum_Body_Naked0",1,"Hum_Head_FatBald",32);
	SetPlayerWalk(playerid,"HumanS_Militia.mds");
    SetPlayerMaxHealth(playerid,2200);
    SetPlayerHealth(playerid,2200);
    SetPlayerStrength(playerid,100);
    SetPlayerDexterity(playerid,120);
    SetPlayerSkillWeapon(playerid,0,70);
    SetPlayerSkillWeapon(playerid,2,60);
    EquipArmor(playerid,"ITAR_BDT_H");
    EquipMeleeWeapon(playerid,"ITMW_SCHWERT1");
    EquipRangedWeapon(playerid,"ITRW_BOW_H_01");
    GiveItem(playerid,"ITRW_ARROW",100);
    GiveItem(playerid,"ItPo_Health_Addon_04",10);
 end


function OnPlayerChangeClass(playerid, classid)
 
	if IsNPC(playerid) == 0 then
	
		if classid == 0 then
			Tank(playerid);
		
		elseif classid == 1 then
			Fighter(playerid);
		
		elseif classid == 2 then
			Archer(playerid);
		end
	end
end

function OnPlayerSelectClass(playerid, classid)
 
end

function OnPlayerConnect(playerid)
 
end

function OnPlayerDisconnect(playerid, reason)

     ClearPlayer(playerid); --czyscimy wlasciwosci gracza
end

function OnPlayerSpawn(playerid, classid)
 
	if playerid == troll then --respawn dla trola
	
		SetPlayerMaxHealth(troll,2000);
		SetPlayerHealth(troll,2000);
		SetPlayerPos(troll,51335.53,8000.31,36147.78);
		SetPlayerAngle(troll,160);
	end
	
	if IsNPC(playerid) == 0 and playerid ~= troll then
	
		SetPlayerInstance(playerid,"PC_HERO");
		
		if classid == 0 then
		
			Tank(playerid);
			
			if Player[playerid].vas_killedbytroll == false then
				SetPlayerPos(playerid,1791,-87,-890);
				SetPlayerAngle(playerid,183);
			else
				SetPlayerPos(playerid,52161,7805,32576);
				SetPlayerAngle(playerid,327);
			end
		
		elseif classid == 1 then
		
			Fighter(playerid);
			
			if Player[playerid].vas_killedbytroll == false then
				SetPlayerPos(playerid,-364,-82,-858);
				SetPlayerAngle(playerid,90);
			else
				SetPlayerPos(playerid,52161,7805,32576);
				SetPlayerAngle(playerid,327);
			end
		
		elseif classid == 2 then
		
			Archer(playerid);
			
			if Player[playerid].vas_killedbytroll == false then
				SetPlayerPos(playerid,1390,-89,331);
				SetPlayerAngle(playerid,274);
			else
				SetPlayerPos(playerid,52161,7805,32576);
				SetPlayerAngle(playerid,327);
			end
		end
		
		if Player[playerid].vas_finished == true then
		
			SetPlayerStrength(playerid,160);
			SetPlayerSkillWeapon(playerid,1,70);
			EquipMeleeWeapon(playerid,"ITMW_2H_SPECIAL_04");
			EquipArmor(playerid,"ITAR_OreBaron_Addon");
		end
	end
end

function OnPlayerDeath(playerid, p_classid, killerid, k_classid)
 
	if playerid == troll_tid then --jezeli padniemy, trol nas juz nie bije
	
		troll_tid = -1;
		troll_stop = true;
		troll_instancehit = false;
		Player[playerid].vas_killedbytroll = true; --spawn nie daleko trola
		PlayAnimation(troll,"S_FISTRUN");
	end
	
	if playerid == troll then --jezeli trol zdechnie nalezy jego AI wylaczyc
	
		troll_tid = -1;
		troll_stop = true;
		troll_instancehit = false;
		
		local x,y,z = GetPlayerPos(troll);
		
		--Drop z trola
		for i = 0, 4 do
		
			local rand = random(15);
			
			if rand == 0 then
				CreateItem("ITMI_GOLD",500,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 1 then
				CreateItem("ITFO_CHEESE",80,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 2 then
				CreateItem("ITMW_1H_BLESSED_03",1,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 3 then
				CreateItem("ItBe_Addon_Prot_EdgPoi",1,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 4 then
				CreateItem("ITAR_FireArmor_Addon",1,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 5 then
				CreateItem("ITAR_PAL_M",1,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 6 then
				CreateItem("ITMI_PAN",1,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 7 then
				CreateItem("ITMI_LUTE",1,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 8 then
				CreateItem("ITSC_TRFSHADOWBEAST",10,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 9 then
				CreateItem("ITFO_BREAD",50,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 10 then
				CreateItem("ItRi_Addon_Health_02",1,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 11 then
				CreateItem("ItPo_Mana_Addon_04",10,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 12 then
				CreateItem("ITMW_2H_ORCSWORD_02",1,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 13 then
				CreateItem("ItAm_Addon_STR",1,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			elseif rand == 14 then
				CreateItem("ITMI_JOINT",30,x + random(200),y,z + random(200),GetPlayerWorld(troll));
			end
		end
		
		if killerid ~= -1 then
		
			Player[killerid].vas_killedbytroll = false; --normalny spawn
			GameTextForPlayer(killerid,2500,3500,"Zdoby³eœ skórê czarnego trola! Wracaj do Vasilija, aby oddaæ skorê.","Font_Old_10_White_Hi.TGA",255,255,0,8000);
			GiveItem(killerid,"ITAT_TROLLBLACKFUR",1);
		
			local message = string.format("%s %s",GetPlayerName(killerid),"zdoby³ skórê czarnego trola!");
			for i = 0, GetMaxSlots() - 1 do
		
				if IsPlayerConnected(i) == 1 and IsNPC(i) == 0 and i ~= killerid then
					GameTextForPlayer(i,2500,3500,message,"Font_Old_10_White_Hi.TGA",255,255,0,8000);
				end
			end
		end
	end
end	
	
function OnPlayerHit(playerid, killerid)
 
	if playerid == vasilij then --jezeli vasilij zostal uderzony
	
		HitPlayer(killerid,killerid);
		SetPlayerHealth(killerid,0);
		GameTextForPlayer(killerid,3000,3500,"Nie uderzaj Vasilija!","Font_Old_10_White_Hi.TGA",255,0,0,5000);
		
		SetPlayerHealth(vasilij,GetPlayerMaxHealth(vasilij));
	end
end

function OnPlayerUnconscious(playerid, p_classid, killerid, k_classid)

end

function OnPlayerText(playerid, text)

end

function OnPlayerCommandText(playerid, cmdtext)

end

function OnPlayerChangeWorld(playerid, world)

end

function OnPlayerEnterWorld(playerid, world)

end

function OnPlayerDropItem(playerid, itemid, item_instance, amount, x, y, z)

end

function OnPlayerTakeItem(playerid, itemid, item_instance, amount, x, y, z)

end