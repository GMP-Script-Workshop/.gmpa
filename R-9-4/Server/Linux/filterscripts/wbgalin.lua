    wb =
    {
            filename = "Default",
            builders = {},
            vobs =  {
                    all = { name = "All"},
                    oth = { name = "Other"}, -- unassigned
                    cat1 = {name = "Category 1"},
                    cat2 = {name = "Category 2"},
                    cat3 = {name = "Category 3"},
                    cat4 = {name = "Category 4"},
                    cat5 = {name = "Category 5"},
                    cat6 = {name = "Category 6"},
                    cat7 = {name = "Category 7"},
                    cat8 = {name = "Category 8"},
                    cat9 = {name = "Category 9"}
            },
            set = {}
    }
     
    builder = {} -- players using WB
    keypush = {} -- IsKeyPushed
     
    function OnFilterscriptInit()
            LOAD_VOBS_TO_TAB();
    end
     
    function OnPlayerDisconnect(id, reason)
            if builder[id] ~= nil then
                    WB_End(id);
                    builder[id] = nil;
                    keypush[id] = nil;
            end
    end
     
    function OnPlayerCommandText(id, cmdtext)
        local cmd,params = GetCommand(cmdtext);
     
            if cmd == "/wb" then  if builder[id]==nil or builder[id].start == false then WB_Start(id) else WB_End(id) end
            elseif cmd == "/save" then if wb.filename ~= "Default" then WB_SaveAllVobs(id) else SendPlayerMessage(id, 255, 0, 0, "Set name of file to save ") end
            elseif cmd == "/load" then WB_LoadVobs(id,params)
            elseif cmd == "/filename" then WB_SetFileName(id,params)
            elseif cmd == "/catname" then WB_SetCategoryName(id,params)
            elseif cmd == "/n" then WB_SetVobName(id,params)
            elseif cmd == "/catsave" then WB_SaveCategories(id)
            end
    end
     
    function OnPlayerKey(id, keyDown, keyUp)
            PushKey(id, keyDown, keyUp)
     
            if builder[id].start == true then
                   
                    -- Rotate
                    if keyDown == KEY_NUMPAD7 or keyDown == KEY_NUMPAD9 or keyDown == KEY_NUMPAD4 or keyDown == KEY_NUMPAD6 or keyDown == KEY_NUMPAD1 or keyDown == KEY_NUMPAD3 then
                            if builder[id].t_rot == nil or IsTimerActive(builder[id].t_rot) == 0 then builder[id].t_rot = SetTimerEx("WB_SetVobRot",40,1,id) end
                            -- Rotate x
                            if keyDown == KEY_NUMPAD7 then builder[id].rot_x = 1 
                            elseif keyDown == KEY_NUMPAD9 then builder[id].rot_x = 2
                            -- Rotate y
                            elseif keyDown == KEY_NUMPAD4 then builder[id].rot_y = 1
                            elseif keyDown == KEY_NUMPAD6 then builder[id].rot_y = 2
                            -- Rotate z
                            elseif keyDown == KEY_NUMPAD1 then builder[id].rot_z = 1
                            elseif keyDown == KEY_NUMPAD3 then builder[id].rot_z = 2
                            end
                    elseif keyUp == KEY_NUMPAD7 or keyUp == KEY_NUMPAD9 or keyUp == KEY_NUMPAD4 or keyUp == KEY_NUMPAD6 or keyUp == KEY_NUMPAD1 or keyUp == KEY_NUMPAD3 then
                            if keyUp == KEY_NUMPAD7 and builder[id].rot_x == 1         then  if IsKeyPushed(id,KEY_NUMPAD9) == 1 then builder[id].rot_x = 2; else builder[id].rot_x = 0; end
                            elseif keyUp == KEY_NUMPAD9 and builder[id].rot_x == 2 then  if IsKeyPushed(id,KEY_NUMPAD7) == 1 then builder[id].rot_x = 1; else builder[id].rot_x = 0; end
                            -- obrot y
                            elseif keyUp == KEY_NUMPAD4 and builder[id].rot_y == 1 then  if IsKeyPushed(id,KEY_NUMPAD6) == 1 then builder[id].rot_y = 2; else builder[id].rot_y = 0; end
                            elseif keyUp == KEY_NUMPAD6 and builder[id].rot_y == 2 then  if IsKeyPushed(id,KEY_NUMPAD4) == 1 then builder[id].rot_y = 1; else builder[id].rot_y = 0; end
                            -- obrot z
                            elseif keyUp == KEY_NUMPAD1 and builder[id].rot_z == 1 then  if IsKeyPushed(id,KEY_NUMPAD3) == 1 then builder[id].rot_z = 2; else builder[id].rot_z = 0; end
                            elseif keyUp == KEY_NUMPAD3 and builder[id].rot_z == 2 then  if IsKeyPushed(id,KEY_NUMPAD1) == 1 then builder[id].rot_z = 1; else builder[id].rot_z = 0; end
                            end          
                            if builder[id].t_rot ~= nil and IsTimerActive(builder[id].t_rot) == 1 and builder[id].rot_z == 0 and builder[id].rot_x == 0 and builder[id].rot_y == 0 then KillTimer(builder[id].t_rot); builder[id].t_rot = nil; end
                    end     
                   
                    -- move
                    if keyDown == KEY_W  or  keyDown == KEY_S  or  keyDown == KEY_A  or  keyDown == KEY_D  or  keyDown == KEY_Q  or  keyDown == KEY_E  then
                            if  builder[id].t_move == nil or IsTimerActive(builder[id].t_move) == 0 then builder[id].t_move = SetTimerEx("WB_SetVobMove",20,1,id) end
                            -- front
                            if keyDown == KEY_W then builder[id].dir_f = 1 
                            elseif keyDown == KEY_S then builder[id].dir_f = 2
                            -- turn
                            elseif keyDown == KEY_D then builder[id].dir_t = 1
                            elseif keyDown == KEY_A then builder[id].dir_t = 2
                            -- up/down
                            elseif keyDown == KEY_E then builder[id].dir_u = 1      
                            elseif keyDown == KEY_Q then builder[id].dir_u = 2
                            end
                    elseif keyUp == KEY_W  or  keyUp == KEY_S  or  keyUp == KEY_A  or  keyUp == KEY_D  or  keyUp == KEY_Q  or  keyUp == KEY_E  then
                            -- front
                            if keyUp == KEY_W and builder[id].dir_f == 1     then if IsKeyPushed(id,KEY_S) == 1 then builder[id].dir_f = 2; else builder[id].dir_f = 0; end
                            elseif keyUp == KEY_S and builder[id].dir_f == 2 then if IsKeyPushed(id,KEY_W) == 1 then builder[id].dir_f = 1; else builder[id].dir_f = 0; end
                            -- side
                            elseif keyUp == KEY_D and builder[id].dir_t == 1 then if IsKeyPushed(id,KEY_A) == 1 then builder[id].dir_t = 2; else builder[id].dir_t = 0; end
                            elseif keyUp == KEY_A and builder[id].dir_t == 2 then if IsKeyPushed(id,KEY_D) == 1 then builder[id].dir_t = 1; else builder[id].dir_t = 0; end
                            -- up/down
                            elseif keyUp == KEY_E and builder[id].dir_u == 1 then if IsKeyPushed(id,KEY_Q) == 1 then builder[id].dir_u = 2; else builder[id].dir_u = 0; end
                            elseif keyUp == KEY_Q and builder[id].dir_u == 2 then if IsKeyPushed(id,KEY_E) == 1 then builder[id].dir_u = 1; else builder[id].dir_u = 0; end
                            end
                            if builder[id].t_move ~= nil and IsTimerActive(builder[id].t_move) == 1 and builder[id].dir_f == 0 and builder[id].dir_t == 0 and builder[id].dir_u == 0 then KillTimer(builder[id].t_move); builder[id].t_move = nil end
                    end
                   
                    -- Change Rotation speed
                    if keyDown == KEY_NUMPAD8 then WB_SetSpeedRot(id,2);
                    elseif keyDown == KEY_NUMPAD2 then WB_SetSpeedRot(id,1);
                    -- Centring Vob
                    elseif keyDown == KEY_NUMPAD5 then  WB_SetVobCenter(id);
                    -- Change Move speed
                    elseif keyDown == KEY_LEFT then WB_SetSpeedMove(id,1);
                    elseif keyDown == KEY_RIGHT then WB_SetSpeedMove(id,2);
                    -- Change vob
                    elseif keyDown == KEY_UP then WB_ChangeVob(id,2);
                    elseif keyDown == KEY_DOWN then  WB_ChangeVob(id,1);
                    -- put vob(only if edit mode is off)
                    elseif keyDown == KEY_LCONTROL and builder[id].edit == false then WB_SetNewVob(id);
                    -- delete vob (On edit mode)
                    elseif keyDown == KEY_DELETE and builder[id].edit == true then WB_DestroyVob(id);
                    -- Browse placed vobs
                    elseif keyDown == KEY_PRIOR then WB_EditVob(id,1);
                    elseif keyDown == KEY_NEXT and builder[id].edit == true then  WB_EditVob(id,2);
                    elseif keyDown == KEY_END and builder[id].edit == true then builder[id].edit = false; WB_SetNewVob(id,1)
                    -- Teleport Player to vob
                    elseif keyDown == KEY_H then WB_TpToVob(id);
                    -- Change category "All"
                    elseif keyDown == KEY_F11  then  WB_ChangeCategory(id, "all");
                    -- assign vob to category
                    elseif IsKeyPushed(id,KEY_RCONTROL) == 1 then
                            if keyDown == KEY_1 then WB_SetVobCategory(id, "cat1");
                            elseif keyDown == KEY_2 then WB_SetVobCategory(id, "cat2");
                            elseif keyDown == KEY_3 then WB_SetVobCategory(id, "cat3");
                            elseif keyDown == KEY_4 then WB_SetVobCategory(id, "cat4");
                            elseif keyDown == KEY_5 then WB_SetVobCategory(id, "cat5");
                            elseif keyDown == KEY_6 then WB_SetVobCategory(id, "cat6");
                            elseif keyDown == KEY_7 then WB_SetVobCategory(id, "cat7");
                            elseif keyDown == KEY_8 then WB_SetVobCategory(id, "cat8");
                            elseif keyDown == KEY_9 then WB_SetVobCategory(id, "cat9");
                            -- all vobs not assigned
                            elseif keyDown == KEY_0 then  WB_SetVobCategory(id, "oth");
                            end
                    -- change category
                    elseif IsKeyPushed(id,KEY_RCONTROL) == 0 or IsKeyPushed(id,KEY_RCONTROL) == nil then
                            if keyDown == KEY_1 then WB_ChangeCategory(id, "cat1");
                            elseif keyDown == KEY_2 then WB_ChangeCategory(id, "cat2");
                            elseif keyDown == KEY_3 then WB_ChangeCategory(id, "cat3");
                            elseif keyDown == KEY_4 then WB_ChangeCategory(id, "cat4");
                            elseif keyDown == KEY_5 then WB_ChangeCategory(id, "cat5");
                            elseif keyDown == KEY_6 then WB_ChangeCategory(id, "cat6");
                            elseif keyDown == KEY_7 then WB_ChangeCategory(id, "cat7");
                            elseif keyDown == KEY_8 then WB_ChangeCategory(id, "cat8");
                            elseif keyDown == KEY_9 then WB_ChangeCategory(id, "cat9");
                            -- all vobs not assigned
                            elseif keyDown == KEY_0 then  WB_ChangeCategory(id, "oth");
                            end
                    end
            end
    end
     
    function PushKey(id,keyDown,keyUp)
            if keyDown<255 then
                    keypush[id][keyDown] = 1;
            elseif keyUp<255 then
                    keypush[id][keyUp] = 0;
            end
    end
     
    function IsKeyPushed(id,key)
            return keypush[id][key]
    end
     
    function LOAD_VOBS_TO_TAB()
     
            local file_all = io.open ("vobs//all.txt","r+")
            for line in io.lines("vobs//all.txt") do
                    vob = file_all:read("*l")
                    local result,ins,name = sscanf(vob,"ss")
                    if result == 1
                    then
                            table.insert(wb.vobs.all,{name = name , ins = ins})
                    else
                            table.insert(wb.vobs.all,{name = vob , ins = vob})
                    end
            end
            file_all:close();
           
            local file_other = io.open ("vobs//other.txt","r+")
            for line in io.lines("vobs//other.txt") do
                    vob = file_other:read("*l")
                    local result,ins,name = sscanf(vob,"ss")
                    if result == 1
                    then
                            table.insert(wb.vobs.oth,{name = name , ins = ins})
                    else
                            table.insert(wb.vobs.oth,{name = vob , ins = vob})
                    end
            end
            file_other:close();
           
            for i=1 , 9 do
                    local cat = string.format("%s%d","cat",i)
                    local nameline = false;
                   
                    local file = io.open (string.format("%s %s%s","vobs//category",i,".txt"),"r+")
                                   
                    for line in io.lines(string.format("%s %s%s","vobs//category",i,".txt")) do
                            if nameline == true then
                                    local vob = line
                                    local result,ins,name = sscanf(vob,"ss")
                                    if result == 1
                                    then
                                            table.insert(wb.vobs[cat],{name = name , ins = ins})
                                    else
                                            table.insert(wb.vobs[cat],{name = vob , ins = vob})
                                    end
                            else
                                    nameline = true;
                                    wb.vobs[cat].name = line;
                            end
                    end
                    file:close();
            end
    end
     
     
    function WB_Start(id)
            FreezePlayer(id, 1);
            SetPlayerEnable_OnPlayerKey(id, 1)
            if builder[id] == nil then
                    -- cat = category, nr = actualy nr, ps = position speed, rs = rotation speed, use = id vob acctually using, dir_ = direction move , rot = rotation
                    builder[id] = { start = false, edit = false; cat = "all", nr = 1, rs = 1, ps = 4, use = 0, dir_f = 0, dir_t = 0, dir_u = 0, rot_x = 0, rot_y = 0, rot_z = 0,
                            d_x =    CreatePlayerDraw(id, 5500, 2000, "Position x: ", "Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_y =    CreatePlayerDraw(id, 5500, 2200, "Position y: ", "Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_z =    CreatePlayerDraw(id, 5500, 2400, "Position z: ", "Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_rx =   CreatePlayerDraw(id, 5500, 2600, "Angle x: ", "Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_ry =   CreatePlayerDraw(id, 5500, 2800, "Angle y: ", "Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_rz =   CreatePlayerDraw(id, 5500, 3000, "Angle x: ", "Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_ps =   CreatePlayerDraw(id, 5500, 3200, "Speed move: ", "Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_rs =   CreatePlayerDraw(id, 5500, 3400, "Speed rotate ", "Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_n =    CreatePlayerDraw(id, 5500, 3600, "Name: " , "Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_c =    CreatePlayerDraw(id, 5500, 3800, "Category: ","Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_h =    CreatePlayerDraw(id, 5500, 4000, "Number/All: ","Font_Old_10_White_Hi.TGA", 223,231,223),
                            d_w =    CreatePlayerDraw(id, 5500, 4200, "Who set: ","Font_Old_10_White_Hi.TGA", 223,231,223),
                            };
                    keypush[id] = {};
            end
           
            builder[id].start = true;
            table.insert(wb.builders, id)
            builder[id].use = Vob.Create(wb.vobs[builder[id].cat][builder[id].nr].ins,GetPlayerWorld(id), GetPlayerPos(id))
            SetCameraBehindVob(id, builder[id].use )
           
            for i=1,6 do WB_UpdatePlayerDraws(id,i) end
           
            ShowPlayerDraw(id, builder[id].d_x)
            ShowPlayerDraw(id, builder[id].d_y)
            ShowPlayerDraw(id, builder[id].d_z)
            ShowPlayerDraw(id, builder[id].d_rx)
            ShowPlayerDraw(id, builder[id].d_ry)
            ShowPlayerDraw(id, builder[id].d_rz)
            ShowPlayerDraw(id, builder[id].d_ps)
            ShowPlayerDraw(id, builder[id].d_rs)
            ShowPlayerDraw(id, builder[id].d_n)
            ShowPlayerDraw(id, builder[id].d_n)
            ShowPlayerDraw(id, builder[id].d_c)
            ShowPlayerDraw(id, builder[id].d_h)
    end
     
    function WB_End(id)
           
           
            for i=1, #wb.builders do if id == wb.builders[i] then table.remove(wb.builders,i); end end
            FreezePlayer(id, 0);
            SetDefaultCamera(id)
            SetPlayerEnable_OnPlayerKey(id, 0)
            if builder[id].t_rot ~= nil then
                    if IsTimerActive(builder[id].t_rot) == 1 then KillTimer(builder[id].t_rot); builder[id].t_rot = nil;  end
            end
            if builder[id].t_move ~= nil then
                    if IsTimerActive(builder[id].t_move) == 1 then KillTimer(builder[id].t_move); builder[id].t_move = nil;  end
            end
            if builder[id].edit == false then builder[id].use:Destroy()     end 
           
            builder[id].start = false;
            HidePlayerDraw(id, builder[id].d_x)
            HidePlayerDraw(id, builder[id].d_y)
            HidePlayerDraw(id, builder[id].d_z)
            HidePlayerDraw(id, builder[id].d_rx)
            HidePlayerDraw(id, builder[id].d_ry)
            HidePlayerDraw(id, builder[id].d_rz)
            HidePlayerDraw(id, builder[id].d_ps)
            HidePlayerDraw(id, builder[id].d_rs)
            HidePlayerDraw(id, builder[id].d_n)
            HidePlayerDraw(id, builder[id].d_c)
            HidePlayerDraw(id, builder[id].d_h)
            HidePlayerDraw(id, builder[id].d_w)
            
    end
     
    function WB_SetNewVob(id,c)
            c = c or 0;
            if c == 0 then
                    table.insert(wb.set,
                    {   id = builder[id].use,
                            ins   = wb.vobs[builder[id].cat][builder[id].nr].ins,
                            name  = wb.vobs[builder[id].cat][builder[id].nr].name,
                            world = GetPlayerWorld(id),
                            who = GetPlayerName(id)
                    })
            end
            rx,ry,rz = builder[id].use:GetRotation()
            builder[id].use = Vob.Create(wb.vobs[builder[id].cat][builder[id].nr].ins,GetPlayerWorld(id), builder[id].use:GetPosition())
            builder[id].use:SetRotation(rx,ry,rz)
            SetCameraBehindVob(id, builder[id].use)
            if c == 1 then WB_UpdatePlayerDraws(id,6) end
     
    end
     
    function WB_DestroyVob(id)
            local x;
            for i=1, #wb.set do if wb.set[i].id == builder[id].use then x = i end end 
            table.remove(wb.set,x);
            local des = builder[id].use;
            if #wb.set == 0 then
                    builder[id].edit = false;
                    HidePlayerDraw(id, builder[id].d_w)
                    WB_SetNewVob(id,1)
            elseif x>#wb.set then
                    WB_EditVob(id,1)
            elseif x<=#wb.set then
                   
                    local b={}
                    local c;               
                    for i=1, #wb.builders do if wb.builders[i] ~= id then b[i] = builder[wb.builders[i]].use end end
     
                    local n = -1
                    repeat
                            n = n + 1
                            c = true;
                            for i=1, #b do if wb.set[x - n].id == b[i] then c = false end end
                    until c ==  true or n >= #wb.set - x + 1 ;
                           
                    if c == true then
                            builder[id].use = wb.set[x+n].id;
                            SetCameraBehindVob(id, builder[id].use)
                            WB_UpdatePlayerDraws(id,1)
                            WB_UpdatePlayerDraws(id,2)
                            WB_UpdatePlayerDraws(id,7,x)
                    else
                            WB_EditVob(id,1)
                            if des == builder[id].use then
                                    builder[id].edit = false;
                                    HidePlayerDraw(id, builder[id].d_w)
                                    WB_SetNewVob(id,1)
                            end
                    end
            end
            des:Destroy();
    end
    -- Change position / rotation
     
    function WB_SetVobMove(id)
            local vob = builder[id].use
            local x,y,z = vob:GetPosition()
            local ps = math.pow(2,builder[id].ps)/2;
            if builder[id].dir_f == 1 then
                    if builder[id].dir_t == 1 then WB_SetVobPos(id,45)
                    elseif builder[id].dir_t == 2 then WB_SetVobPos(id,315)
                    else WB_SetVobPos(id,0)
                    end
            elseif builder[id].dir_f == 2 then
                    if builder[id].dir_t == 1 then WB_SetVobPos(id,135)
                    elseif builder[id].dir_t == 2 then WB_SetVobPos(id,225)
                    else WB_SetVobPos(id,180)
                    end
            elseif builder[id].dir_t == 1 then WB_SetVobPos(id,90)
            elseif builder[id].dir_t == 2 then WB_SetVobPos(id,270)
            end
           
            if builder[id].dir_u == 1 then
                    local vob = builder[id].use
                    local x,y,z = vob:GetPosition()
                    vob:SetPosition(x,y+ps,z)
            elseif builder[id].dir_u == 2 then
                    local vob = builder[id].use
                    local x,y,z = vob:GetPosition()
                    vob:SetPosition(x,y-ps,z)
            end
    end
     
    function WB_SetVobPos(id,ang)
            local vob = builder[id].use
            local x,y,z = vob:GetPosition()
            local rx,ry,rz = vob:GetRotation()
            local dis = math.pow(2,builder[id].ps);
            if ry<0 then ry = ry + ((math.ceil(math.abs(ry)/360))*360) else ry = ry - ((math.floor(ry/360))*360) end
            local rot = ry + ang;
            rot =rot - math.floor(rot/360) * 360
     
            if rot%90==0 then
                    if rot == 0 then vob:SetPosition(x,y,z+dis)
                    elseif rot == 90 then  vob:SetPosition(x+dis,y,z)
                    elseif rot == 180 then vob:SetPosition(x,y,z-dis)
                    elseif rot == 270 then vob:SetPosition(x-dis,y,z)
                    end
            else
                    local mrot = (math.floor(rot/90))*90
                    local a = math.cos(math.rad(rot-mrot)) * dis;
                    local b = math.sin(math.rad(rot-mrot)) * dis;
                    if rot > 0 and rot < 90 then vob:SetPosition(x+b,y,z+a) 
                    elseif rot > 90 and rot < 180 then vob:SetPosition(x+a,y,z-b)
                    elseif rot > 180 and rot < 270 then vob:SetPosition(x-b,y,z-a)
                    elseif rot > 270 then vob:SetPosition(x-a,y,z+b)
                    end
            end
           
            WB_UpdatePlayerDraws(id,1);
    end
     
    function WB_SetVobRot(id)
           
            local vob = builder[id].use;
            local x,y,z = vob:GetRotation();
            local rs = builder[id].rs;
           
            if builder[id].rot_x == 1 then
                    if builder[id].rot_y == 1 then
                            if builder[id].rot_z == 1 then  vob:SetRotation(x-rs,y-rs, z-rs);       
                            elseif builder[id].rot_z == 2 then vob:SetRotation(x-rs,y-rs, z+rs);
                            elseif builder[id].rot_z == 0 then vob:SetRotation(x-rs,y-rs, z);
                            end
                    elseif builder[id].rot_y == 2 then
                            if builder[id].rot_z == 1 then vob:SetRotation(x-rs,y+rs, z-rs);
                            elseif builder[id].rot_z == 2 then vob:SetRotation(x-rs,y+rs, z+rs);
                            elseif builder[id].rot_z == 0 then vob:SetRotation(x-rs,y+rs, z);
                            end
                    elseif builder[id].rot_y == 0 then
                            if builder[id].rot_z == 1 then   vob:SetRotation(x-rs,y, z-rs);
                            elseif builder[id].rot_z == 2 then vob:SetRotation(x-rs,y, z+rs);
                            elseif builder[id].rot_z == 0 then vob:SetRotation(x-rs,y, z);
                            end
                    end
            elseif builder[id].rot_x == 2 then
                    if builder[id].rot_y == 1 then
                            if builder[id].rot_z == 1 then  vob:SetRotation(x+rs,y-rs, z-rs);       
                            elseif builder[id].rot_z == 2 then vob:SetRotation(x+rs,y-rs, z+rs);
                            elseif builder[id].rot_z == 0 then vob:SetRotation(x+rs,y-rs, z);
                            end
                    elseif builder[id].rot_y == 2 then
                            if builder[id].rot_z == 1 then vob:SetRotation(x+rs,y+rs, z-rs);
                            elseif builder[id].rot_z == 2 then vob:SetRotation(x+rs,y+rs, z+rs);
                            elseif builder[id].rot_z == 0 then vob:SetRotation(x+rs,y+rs, z);
                            end
                    elseif builder[id].rot_y == 0 then
                            if builder[id].rot_z == 1 then   vob:SetRotation(x+rs,y, z-rs);
                            elseif builder[id].rot_z == 2 then vob:SetRotation(x+rs,y, z+rs);
                            elseif builder[id].rot_z == 0 then vob:SetRotation(x+rs,y, z);
                            end
                    end
            elseif builder[id].rot_x == 0 then
                    if builder[id].rot_y == 1 then
                            if builder[id].rot_z == 1 then  vob:SetRotation(x,y-rs, z-rs); 
                            elseif builder[id].rot_z == 2 then vob:SetRotation(x,y-rs, z+rs);
                            elseif builder[id].rot_z == 0 then vob:SetRotation(x,y-rs, z);
                            end
                    elseif builder[id].rot_y == 2 then
                            if builder[id].rot_z == 1 then vob:SetRotation(x,y+rs, z-rs);
                            elseif builder[id].rot_z == 2 then vob:SetRotation(x,y+rs, z+rs);
                            elseif builder[id].rot_z == 0 then vob:SetRotation(x,y+rs, z);
                            end
                    elseif builder[id].rot_y == 0 then
                            if builder[id].rot_z == 1 then   vob:SetRotation(x,y, z-rs);
                            elseif builder[id].rot_z == 2 then vob:SetRotation(x,y, z+rs);
                            end
                    end
            end
           
            WB_UpdatePlayerDraws(id,2)
    end
     
    function WB_SetVobCenter(id)
            builder[id].use:SetRotation(0,0,0);
            WB_UpdatePlayerDraws(id,2)
    end
     
    function WB_EditVob(id,x)
     
            local b={}
            local c;               
     
            for i=1, #wb.builders do if wb.builders[i] ~= id then b[i] = builder[wb.builders[i]].use end end
           
            local vob = builder[id].use;
            local t = -1;
            for i=1,#wb.set do if wb.set[i].id == vob then t = i end end
           
            if x==1 and #wb.set >0 and ( t>1 or t==-1 ) then
                    if t == -1 then
                            local n = - 1
                            repeat
                                    n = n + 1
                                    c = true;
                                    for i=1, #b do if wb.set[#wb.set - n].id == b[i] then c = false end end
                            until c == true or n >= #wb.set;
                           
                            if c == true then
                                    builder[id].edit = true;
                                    ShowPlayerDraw(id, builder[id].d_w)
                                    vob:Destroy();
                                    builder[id].use = wb.set[#wb.set - n].id;
                                    SetCameraBehindVob(id, builder[id].use)
                                   
                                    WB_UpdatePlayerDraws(id,1)
                                    WB_UpdatePlayerDraws(id,2)
                                    WB_UpdatePlayerDraws(id,7,#wb.set)
                            end
                    elseif t>1 then
                            local n = 0
                            repeat
                                    n = n + 1
                                    c = true;
                                    for i=1, #b do if wb.set[t - n].id == b[i] then c = false end end
                            until c ==  true or n >= #wb.set - t + 1 ;
                            if c == true then
                                    builder[id].use = wb.set[t-n].id;
                                    SetCameraBehindVob(id, builder[id].use)
                                    WB_UpdatePlayerDraws(id,1)
                                    WB_UpdatePlayerDraws(id,2)
                                    WB_UpdatePlayerDraws(id,7,t-n)
                            end
                    end
            elseif x == 2 and t ~= -1 then
                    if t == #wb.set then
                            builder[id].edit = false;
                            HidePlayerDraw(id, builder[id].d_w)
                            WB_SetNewVob(id,1)
                    elseif t<#wb.set then
                            local n = 0
                            repeat
                                    n = n + 1
                                    c = true;
                                    for i=1, #b do if wb.set[t + n].id == b[i] then c = false end end
                            until c ==  true or wb.set[t] + n > #wb.set ;
                   
                            if c == true then
                                    if #wb.set - t + n > #wb.set then
                                            builder[id].edit = false;
                                            HidePlayerDraw(id, builder[id].d_w)
                                            WB_SetNewVob(id,1)
                                    else
                                            builder[id].use = wb.set[t+n].id;
                                            SetCameraBehindVob(id, builder[id].use)
                           
                                            WB_UpdatePlayerDraws(id,1)
                                            WB_UpdatePlayerDraws(id,2)
                                            WB_UpdatePlayerDraws(id,7,t+n)
                                    end     
                            end
                    end
            end     
    end
     
    --Change Speed
     
    function WB_SetSpeedRot(id,c)
           
            if c == 1 then if  builder[id].rs >= 2 then builder[id].rs =  builder[id].rs - 1; end
            elseif c == 2 then if  builder[id].rs <= 9 then builder[id].rs =  builder[id].rs + 1; end
            end
            WB_UpdatePlayerDraws(id,4)
    end
     
    function WB_SetSpeedMove(id,c)
           
            if c == 1 then if  builder[id].ps >= 2 then builder[id].ps =  builder[id].ps - 1; end
            elseif c == 2 then if  builder[id].ps <= 5 then builder[id].ps =  builder[id].ps + 1; end
            end
            WB_UpdatePlayerDraws(id,3)
    end
     
     
    function  WB_ChangeVob(id,c)
            local vob = builder[id].use
            local x,y,z = vob:GetPosition()
     
            if c == 1 then
                    if builder[id].nr > 1 then      builder[id].nr = builder[id].nr - 1; else builder[id].nr = #wb.vobs[builder[id].cat] end
            elseif c == 2 then
                    if builder[id].nr < #wb.vobs[builder[id].cat] then builder[id].nr = builder[id].nr + 1; else builder[id].nr = 1; end
            elseif c == 3 then      -- only for change category
                    if builder[id].nr > #wb.vobs[builder[id].cat] then builder[id].nr = 1; end
            end
           
            vob:Destroy()
            builder[id].use = Vob.Create(wb.vobs[builder[id].cat][builder[id].nr].ins, GetPlayerWorld(id), x,y,z)
            SetCameraBehindVob(id, builder[id].use)
           
            if builder[id].edit == true then
                    for i=1, #wb.set do
                            if wb.set[i].id == vob then
                                    wb.set[i].id = builder[id].use;
                                    wb.set[i].ins = wb.vobs[builder[id].cat][builder[id].nr].ins;
                                    wb.set[i].name = wb.vobs[builder[id].cat][builder[id].nr].name;
                            end
                    end
            end
            WB_UpdatePlayerDraws(id,5)
    end
     
    function WB_ChangeCategory(id, cat)
            if cat ~= builder[id].cat then
                    if #wb.vobs[cat] > 0 then
                            builder[id].cat = cat;
                            builder[id].nr = 1;
                            WB_ChangeVob(id,3)
                             WB_UpdatePlayerDraws(id,6)
                    else
                            SendPlayerMessage(id, 255, 0, 0, "No vobs on this category")
                    end
            end
    end
     
    function WB_SetVobCategory(id, cat)
            if builder[id].cat ~= "all" and builder[id].edit == false and builder[id].cat ~= cat then
                    local vob = builder[id].use;
                    local t = wb.vobs[builder[id].cat][builder[id].nr]
                    table.remove(wb.vobs[builder[id].cat],builder[id].nr)
                    table.insert(wb.vobs[cat],t)
                    if  #wb.vobs[builder[id].cat]>0 then
                            WB_ChangeVob(id,3)
                    else
                            WB_ChangeCategory(id,"all")
                    end
                     WB_UpdatePlayerDraws(id,6)
            end
    end
     
    function WB_SetCategoryName(id, params)
            if builder[id].edit == false then
                    local result,catname = sscanf(params,"s")
                    if result == 1 then
                            wb.vobs[builder[id].cat].name = catname
                            WB_UpdatePlayerDraws(id,6)
                    end
            end
    end
     
    function WB_SetVobName(id, params)
            if builder[id].edit == false then
                    local result,vobname = sscanf(params,"s")
                    if result == 1 then
                            wb.vobs[builder[id].cat][builder[id].nr].name = vobname
                            WB_UpdatePlayerDraws(id,5)
                    end
            end
    end
     
    function WB_SaveCategories()
            local s_oth;
            if #wb.vobs.oth > 0 then
                    s_oth =  string.format("%s %s",wb.vobs.oth[1].ins,wb.vobs.oth[1].name);
                    if #wb.vobs.oth > 1 then
                            for i=2,#wb.vobs.oth do s_oth = string.format("%s\n%s %s",s_oth,wb.vobs.oth[i].ins,wb.vobs.oth[i].name); end
                    end
            end
            local file_other = io.open ("vobs//other.txt","w")
            file_other:write(s_oth);
            file_other:close();
           
           
            local s_cat = {}
            for i=1 , 9 do
                    local cat = string.format("%s%d","cat",i)
                    s_cat[i] = wb.vobs[cat].name;
                    print(cat);
                    for j=1,#wb.vobs[cat] do
                            s_cat[i] = string.format("%s\n%s %s",s_cat[i],wb.vobs[cat][j].ins,wb.vobs[cat][j].name);
                    end
                    local file = io.open (string.format("%s %s%s","vobs//category",i,".txt"),"w")
                    file:write(s_cat[i]);
                    file:close();
            end
            SendPlayerMessage(id, 192, 168, 0, "All categories was saved")
    end
     
    function WB_SaveAllVobs(id)
           
            if #wb.set > 0 then
                    local allvobs = "";
                    for i=1,#wb.set do
                            local vob = wb.set[i].id
                            local x,y,z = vob:GetPosition()
                            local rx,ry,rz = vob:GetRotation()
                            allvobs = string.format("%s%s %s %s %s %d %d %d %d %d %d\n",allvobs, wb.set[i].ins, wb.set[i].name, wb.set[i].world, wb.set[i].who, x, y, z, rx, ry, rz)
                    end
                    local file = io.open(string.format("%s%s%s","WB//",wb.filename,".txt"), "w");
                    if file~= nil then
                            file:write(allvobs);
                            file:close()
                            SendPlayerMessage(id, 192, 168, 0, "Save success")
                    end
            end
    end
     
    function WB_LoadVobs(id,params)
            local result,fname = sscanf(params,"s");
            if result == 1 then
                    local file = io.open(string.format("%s%s%s","WB//",fname,".txt"), "r");
                    if file ~= nil then
                            local l = 0;
                            for line in file:lines() do
                                    l = l + 1;
                                    local res,ins,vname,world,who,x,y,z,rx,ry,rz = sscanf(line,"ssssdddddd")
                                    if res == 1 then
                                            table.insert(wb.set,{id = Vob.Create(ins,world,x,y,z),ins = ins, name = vname, world = world, who = who});
                                            wb.set[#wb.set].id:SetRotation(rx,ry,rz);                     
                                    else
                                            SendPlayerMessage(id, 255, 0, 0, string.format("%d %s %s %s",l,"from",fname,"was not readed"))
                                            LogString("WB//ERROR",string.format("%d %s %s %s",l,"from",fname,"was not readed"))
                                    end
                            end
                            SendPlayerMessage(id, 192, 168, 0, "Load success")
                    else
                            SendPlayerMessage(id, 255, 0, 0, "File not exist")
                    end
            end
    end
     
    function WB_SetFileName(id,params)
            local result,fname = sscanf(params,"s");
            if result == 1 then
                    if string.lower(fname) ~= "default" then               
                            wb.filename = fname
                            SendPlayerMessage(id, 192, 168, 0, string.format("%s \"%s\"","You change file name to ",wb.filename))
                    else
                            SendPlayerMessage(id, 255, 0, 0, "Enter a name other than \"Default\"")
                    end
            end
    end
     
    function WB_TpToVob(id)
            local vob = builder[id].use;
            local x,y,z = vob:GetPosition()
            SetPlayerPos(id,x,y+150,z)
    end
     
    function WB_UpdatePlayerDraws(id,nr,s)
                    s = s or 0;
     
            --1 Pos,2 Rot,3 ps, 4 rs, 5 Name,6 Cat and name,7 editmode
            local vob = builder[id].use
            if nr == 1 then
                    local x,y,z = vob:GetPosition()
                    local t1 = string.format("%s %d","Pos x:",x);
                    local t2 = string.format("%s %d","Pos y:",y);
                    local t3 = string.format("%s %d","Pos z:",z);
                   
                    UpdatePlayerDraw(id, builder[id].d_x,5500, 2000, t1, "Font_Old_10_White_Hi.TGA", 223,231,223)
                    UpdatePlayerDraw(id, builder[id].d_y,5500, 2200, t2, "Font_Old_10_White_Hi.TGA", 223,231,223)
                    UpdatePlayerDraw(id, builder[id].d_z,5500, 2400, t3, "Font_Old_10_White_Hi.TGA", 223,231,223)
                   
                   
            elseif nr == 2 then
                    local rx,ry,rz = vob:GetRotation()     
                    local t1 = string.format("%s %d","Rot x:",rx);
                    local t2 = string.format("%s %d","Rot y:",ry);
                    local t3 = string.format("%s %d","Rot z:",rz);
                   
                    UpdatePlayerDraw(id, builder[id].d_rx,5500, 2600, t1, "Font_Old_10_White_Hi.TGA", 223,231,223)
                    UpdatePlayerDraw(id, builder[id].d_ry,5500, 2800, t2, "Font_Old_10_White_Hi.TGA", 223,231,223)
                    UpdatePlayerDraw(id, builder[id].d_rz,5500, 3000, t3, "Font_Old_10_White_Hi.TGA", 223,231,223)
            elseif nr == 3 then
                    local t = string.format("%s %s","Speed move:",builder[id].ps);
                    UpdatePlayerDraw(id, builder[id].d_ps,5500, 3200, t, "Font_Old_10_White_Hi.TGA", 223,231,223)
            elseif nr == 4 then
                    local t = string.format("%s %s","Speed rotate:",builder[id].rs);
                    UpdatePlayerDraw(id, builder[id].d_rs,5500, 3400, t, "Font_Old_10_White_Hi.TGA", 223,231,223)
            elseif nr == 5 then
                    local t1 = string.format("%s %s","Name:",wb.vobs[builder[id].cat][builder[id].nr].name);
                    local t2 = string.format("%s %s/%s","Nr:",builder[id].nr,#wb.vobs[builder[id].cat]);
                    UpdatePlayerDraw(id, builder[id].d_n,5500, 3600, t1, "Font_Old_10_White_Hi.TGA", 223,231,223)
                    UpdatePlayerDraw(id, builder[id].d_h,5500, 4000, t2, "Font_Old_10_White_Hi.TGA", 223,231,223)
            elseif nr == 6 then    
                    local t1 = string.format("%s %s","Name:",wb.vobs[builder[id].cat][builder[id].nr].name);
                    local t2 = string.format("%s %s","Category:",wb.vobs[builder[id].cat].name);
                    local t3 = string.format("%s %s/%s","Nr:",builder[id].nr,#wb.vobs[builder[id].cat]);
                    UpdatePlayerDraw(id, builder[id].d_n,5500, 3600, t1, "Font_Old_10_White_Hi.TGA", 223,231,223)
                    UpdatePlayerDraw(id, builder[id].d_c,5500, 3800, t2, "Font_Old_10_White_Hi.TGA", 223,231,223)
                    UpdatePlayerDraw(id, builder[id].d_h,5500, 4000, t3, "Font_Old_10_White_Hi.TGA", 223,231,223)      
            elseif nr == 7 then    
                    local t1 = string.format("%s %s","Name:",wb.set[s].name);
                    local t2 = string.format("%s %s","category:","Positioned objects");
                    local t3 = string.format("%s %s","Who set:",wb.set[s].who);
                    local t4 = string.format("%s %s/%s","Nr:",s,#wb.set);
                    UpdatePlayerDraw(id, builder[id].d_n,5500, 3600, t1, "Font_Old_10_White_Hi.TGA", 223,231,223)
                    UpdatePlayerDraw(id, builder[id].d_c,5500, 3800, t2, "Font_Old_10_White_Hi.TGA", 223,231,223)
                    UpdatePlayerDraw(id, builder[id].d_w,5500, 4200, t3, "Font_Old_10_White_Hi.TGA", 223,231,223)
                    UpdatePlayerDraw(id, builder[id].d_h,5500, 4000, t4, "Font_Old_10_White_Hi.TGA", 223,231,223)
            end
    end 
---SetPlayerScale(playerid,1,1,1);