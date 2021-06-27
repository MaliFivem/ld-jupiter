PantCore = nil
local coreLoaded = false
Citizen.CreateThread(function() 
    while PantCore == nil do
        TriggerEvent("PantCore:GetObject", function(obj) PantCore = obj end)    
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

local maviSihir = vector3(2484.6938476562, 2602.7473144531, 51.444345092773)
local sihir = vector3(1390.91, 3605.62, 38.94)

Citizen.CreateThread(function()
    while true do 
        local time = 250
        if coreLoaded then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local maviSihirDistance = #(playerCoords - maviSihir)
            local sihirDistance = #(playerCoords - sihir)
            if maviSihirDistance < 10 then 
                time = 1
                DrawMarker(20, maviSihir.x, maviSihir.y, maviSihir.z-0.4, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)	
                if maviSihirDistance < 2 then
                    PantCore.Functions.DrawText3D(maviSihir.x, maviSihir.y, maviSihir.z, "[E] Fill")
                    if IsControlJustReleased(0, 38) then
                        PantCore.Functions.Progressbar("mavi_sihir", "Trying to Fill", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Done
                            TriggerServerEvent("ld-jupiter:mavi-control")
                        end, function() -- Cancel
                        end)
                    end
                end
            end

            if sihirDistance < 10 then 
                time = 1
                if sihirDistance < 2 then 
                    PantCore.Functions.DrawText3D(sihir.x, sihir.y, sihir.z, "[E] Combine and boil necessary ingredients")
                    if IsControlJustReleased(0, 38) then
                        PantCore.Functions.TriggerCallback("ld-jupiter:item-check", function(result)
                            if result then
                                maviHeat()
                            end
                        end)
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)

RegisterNetEvent("ld-jupiter:client:start-fire")
AddEventHandler("ld-jupiter:client:start-fire", function(time)
    if #(GetEntityCoords(PlayerPedId()) - vector3(sihir.x, sihir.y, sihir.z)) < 50 then
        Citizen.Wait(500)
        StartScriptFire(sihir.x,sihir.y, sihir.z-0.1, 2, false)
        Citizen.Wait(20000)
        StopFireInRange(sihir.x,sihir.y, sihir.z, 20.0)
    end
end)

function maviHeat()
    PantCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sihir_yap', {
        title = "Mavi Sihiri Isıt/Kaynat (Derece 1-100)"
    }, function(data, menu)
        menu.close()
        local temperature = tonumber(data.value)
        TriggerServerEvent("ld-jupiter:server:smoke", "mavisihir",15000)
        PantCore.Functions.Progressbar("sihir_yap", "Melting", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },{
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        }, {}, {}, function() -- Done
            if temperature >= 14 and temperature <= 19 then
                menu.close()
                kirmiziHeat()
            else
                TriggerServerEvent("ld-jupiter:start-fire")
            end
        end, function() -- Cancel
        end)
    end, function(data, menu)
        menu.close()
    end)
end

function kirmiziHeat()
    PantCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sihir_yap', {
        title = "Tirium'u Isıt/Kaynat (Derece 1-100)"
    }, function(data, menu)
        menu.close()
        local temperature = tonumber(data.value)
        TriggerServerEvent("ld-jupiter:server:smoke", "kirmizisihir", 55000)
        PantCore.Functions.Progressbar("sihir_yap", "Melting", 55000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },{
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        }, {}, {}, function() -- Done
            if temperature >= 61 and temperature <= 64 then
                menu.close()
                tutunHeat()
            else
                TriggerServerEvent("ld-jupiter:start-fire")
            end
        end, function() -- Cancel
        end)
    end, function(data, menu)
        menu.close()
    end)
end

function tutunHeat()
    PantCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sihir_yap', {
        title = "Alkolu Isıt/Kaynat (Derece 1-100)"
    }, function(data, menu)
        menu.close()
        local temperature = tonumber(data.value)
        TriggerServerEvent("ld-jupiter:server:smoke", "tutun", 45000)
        PantCore.Functions.Progressbar("sihir_yap", "Melting", 45000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },{
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        }, {}, {}, function() -- Done
            if temperature >= 30 and temperature <= 40 then
                menu.close()
                sutHeat()
            else
                TriggerServerEvent("ld-jupiter:start-fire")
            end
        end, function() -- Cancel
        end)
    end, function(data, menu)
        menu.close()
    end)
end

function sutHeat()
    PantCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sihir_yap', {
        title = "Tütün Isıt/Kaynat (Derece 1-100)"
    }, function(data, menu)
        menu.close()
        local temperature = tonumber(data.value)
        TriggerServerEvent("ld-jupiter:server:smoke", "sut", 10000)
        PantCore.Functions.Progressbar("sihir_yap", "Melting", 10000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },{
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        }, {}, {}, function() -- Done
            if temperature >= 20 and temperature <= 24 then
                menu.close()
                sekerHeat()
            else
                TriggerServerEvent("ld-jupiter:start-fire")
            end
        end, function() -- Cancel
        end)
    end, function(data, menu)
        menu.close()
    end)
end

function sekerHeat()
    PantCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sihir_yap', {
        title = "Şekeri Isıt/Kaynat (Derece 1-100)"
    }, function(data, menu)
        menu.close()
        local temperature = tonumber(data.value)
        TriggerServerEvent("ld-jupiter:server:smoke", "seker", 50000)
        PantCore.Functions.Progressbar("sihir_yap", "Melting", 50000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },{
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        }, {}, {}, function() -- Done
            if temperature >= 56 and temperature <= 63 then
                PantCore.Functions.Progressbar("sihir_yap", "You Combine All the Items", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                    anim = "machinic_loop_mechandplayer",
                    flags = 49,
                }, {}, {}, function() -- Done
                    TriggerServerEvent("ld-jupiter:give-jupiter", PantCore.Key)
                end, function() -- Cancel
                end)
            else
                TriggerServerEvent("ld-jupiter:start-fire")
            end
        end, function() -- Cancel
        end)
    end, function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent("ld-jupiter:client:smoke")
AddEventHandler("ld-jupiter:client:smoke", function(time)
    RequestNamedPtfxAsset("core")
	while not HasNamedPtfxAssetLoaded("core") do
		Citizen.Wait(10)
	end
    SetPtfxAssetNextCall("core")
    local Smoke = StartParticleFxLoopedAtCoord("proj_grenade_smoke", sihir.x,sihir.y, sihir.z+0.5, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    SetParticleFxLoopedAlpha(Smoke, 1.0)
    SetParticleFxLoopedColour(Smoke, 255.0, 255.0, 255.0, 0)
    Citizen.Wait(time)
    StopParticleFxLooped(Smoke, 0)
end)

local busy = false
RegisterNetEvent("ld-jupiter:use-item")
AddEventHandler("ld-jupiter:use-item", function(saniye)
    if not busy then
        busy = true
        PantCore.Functions.Progressbar("animasyon_name", "Useing", 15000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "mp_player_int_uppersmoke",
            anim = "mp_player_int_smoke",
            flags = 49,
        }, {}, {}, function() -- Done
            TriggerServerEvent("ld-jupiter:sihirsil")
            exports["gamz-skillsystem"]:UpdateSkillRemove("Kondisyon", 0.025)
            exports["ld-levelsistemi"]:expVer("uyusturucu-icme", PantCore.Key)  
            uyusturucuEtkisi = 0
            local rastgeleEfekt = math.random(1,2)
            if rastgeleEfekt == 1 then
                StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
            else
                StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
            end
            
            Citizen.Wait(1500)   
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.4)
            uyusturucuEtkisi = saniye
            if rastgeleEfekt == 1 then
                StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
            else
                StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
            end
    
            while uyusturucuEtkisi > 0 do
                Citizen.Wait(1000)
                local playerPed = PlayerPedId()
                TriggerEvent("ld-stres:stres-dusur", 600)

                if GetEntityHealth(PlayerPedId()) <= 200 then
                    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 2)
                end

                if GetPedArmour(PlayerPedId()) <= 200 then
                    AddArmourToPed(PlayerPedId(), GetPedArmour(PlayerPedId()) + 2 )
                end
                
                RestorePlayerStamina(PlayerId(), 1.0)
                uyusturucuEtkisi = uyusturucuEtkisi - 1 
            end
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
            if rastgeleEfekt == 1 then
                StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
                StopScreenEffect("DrugsMichaelAliensFightIn")
                StopScreenEffect("DrugsMichaelAliensFight")
                StopScreenEffect("DrugsMichaelAliensFightOut")
            else
                StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
                StopScreenEffect("DrugsTrevorClownsFight")
                StopScreenEffect("DrugsTrevorClownsFightIn")
                StopScreenEffect("DrugsTrevorClownsFightOut")
            end
            uyusturucuEtkisi = 0
            busy = false
        end, function() -- Cancel
            TriggerServerEvent("ld-jupiter:sihirsil")
            busy = false
        end)
        
    end
end)
