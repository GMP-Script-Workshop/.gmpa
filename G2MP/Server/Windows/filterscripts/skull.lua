    Skull = {}
    Skull.__index = Skull
     
    Skull.vobHandle = nil
    Skull.isRotating = false
    Skull.owner = -1               
    Skull_rotateTimer = nil
     
    SetTimer("tickTock",75,1)
     
    function OnPlayerConnect(playerid)
            SendPlayerMessage(playerid, 0, 250, 0, "To have fun, type '/kots' !")
    end
     
    function OnPlayerDisconnect(playerid, reason)
            if Skull.owner == playerid then
                    Skull.owner = -1
            end
    end
     
    function OnPlayerDeath(playerid, killerid)
            if Skull.owner == playerid then
                    Skull.owner = -1
            end
    end
     
    function OnPlayerHit(playerid, killerid)
            if playerid == Skull.owner then
                    Skull.owner = killerid
                            SendMessageToAll(0,250,0,"New skull owner: "..GetPlayerName(killerid).." !")
            end
    end
     
    function OnPlayerCommandText(playerid, cmdtext)
            local cmd, params = GetCommand(cmdtext)
                    if cmd == "/kots" then
                            Skull.start(playerid, params)
                                    SendPlayerMessage(playerid, 0, 250, 0, "To stop kots type: '/stop.kots' !")
                    elseif cmd == "/stop.kots" then
                            Skull.stop(playerid, params)
                                    SendPlayerMessage(playerid, 255, 0, 0, "Skull stop.")
                    end
    end
     
    function Skull.start(playerid, params)
            if Skull.vobHandle == nil then
                    local X, Y, Z = GetPlayerPos(playerid)
                            Skull.vobHandle = Vob.Create("SKULL.3DS",GetPlayerWorld(playerid),X, Y, Z + 300)
                                    Skull:startRotation()
            end
    end
     
     
    function Skull.stop(playerid, params)
            Skull.stopRotation()
                    Skull.vobHandle:Destroy()
                            Skull.vobHandle = nil
                                    Skull.owner = -1
     
    end
     
    function Skull.startRotation()
            Skull.isRotating = true
                    Skull_rotateTimer = SetTimer("Skull_rotate",60,1)
    end
     
    function Skull_rotate()
            if Skull.isRotating == false then
                    KillTimer(Skull_rotateTimer)
                            Skull_rotateTimer = nil
            else
                    local rotX, rotY, rotZ = Skull.vobHandle:GetRotation()
                            Skull.vobHandle:SetRotation(rotX, rotY + 4, rotZ)
            end
    end
     
    function Skull.stopRotation()
            Skull.isRotating = false
    end
     
    function tickTock()
    if Skull.vobHandle ~= nil then
            if Skull.owner == -1 then
                    for i = 0, GetMaxSlots() do
                            if IsPlayerConnected(i) then
                                    local pX, pY, pZ = GetPlayerPos(i)
                                    local sX, sY, sZ = Skull.vobHandle:GetPosition()
                                            if GetDistance3D(pX, pY, pZ, sX, sY, sZ) <= 150 then
                                                    Skull.owner = i
                                                    SendMessageToAll(0,250,0,"New skull owner: "..GetPlayerName(i).." !")
                                                            break
                                            end
                            end
                    end
            else
                    local plX, plY, plZ = GetPlayerPos(Skull.owner)
                            Skull.vobHandle:SetPosition(plX, plY + 120 , plZ)
            end
    end
    end