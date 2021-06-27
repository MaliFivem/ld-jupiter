PantCore = nil
TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

PantCore.Functions.CreateCallback('ld-jupiter:item-check', function(source, cb)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    local item = xPlayer.Functions.GetItemByName("mavisihir")
    if item ~= nil then
    if item.amount >= 1 then
        cb(true)
    else
        cb(false) 
    end
end
end)

RegisterServerEvent('ld-jupiter:server:smoke')
AddEventHandler('ld-jupiter:server:smoke', function(type, time)
    local timedeneme = time
    TriggerClientEvent('ld-jupiter:client:smoke', -1, timedeneme)
end)

RegisterServerEvent('ld-jupiter:start-fire')
AddEventHandler('ld-jupiter:start-fire', function()
    TriggerClientEvent('ld-jupiter:client:start-fire', -1)
end)

RegisterServerEvent('ld-jupiter:give-jupiter')
AddEventHandler('ld-jupiter:give-jupiter', function()
    local xPlayer = PantCore.Functions.GetPlayer(source)
    local miktar = math.random(1,3)
    if xPlayer then
        xPlayer.Functions.AddItem('sihir', miktar)
        TriggerClientEvent("inventory:client:ItemBox", xPlayer.PlayerData.source, PantCore.Shared.Items["sihir"], "add", miktar)
        xPlayer.Functions.RemoveItem('mavisihir', 1)
        TriggerClientEvent("inventory:client:ItemBox", xPlayer.PlayerData.source, PantCore.Shared.Items["mavisihir"], "remove", 1)
        xPlayer.Functions.RemoveItem('kirmizisihir', 1)
        TriggerClientEvent("inventory:client:ItemBox", xPlayer.PlayerData.source, PantCore.Shared.Items["kirmizisihir"], "remove", 1)
    end
end)

RegisterServerEvent('ld-jupiter:mavi-control')
AddEventHandler('ld-jupiter:mavi-control', function()
    local src = source
    local xPlayer = PantCore.Functions.GetPlayer(src)
    local item = xPlayer.Functions.GetItemByName('mavisihir')
    if item ~= nil then
    if item.amount >= 1 then
        xPlayer.Functions.AddItem('kirmizisihir', 1)
        TriggerClientEvent("inventory:client:ItemBox", xPlayer.PlayerData.source, PantCore.Shared.Items["kirmizisihir"], "add", 1)
    else
        TriggerClientEvent('PantCore:Notify', xPlayer.PlayerData.source,  "'You do not have the required item", "error")
    end
else
    TriggerClientEvent('PantCore:Notify', xPlayer.PlayerData.source,  "You do not have the required item", "error")
end
end)

PantCore.Functions.CreateUseableItem("sihir", function(source, uyusturucuEtkisi)
    TriggerClientEvent('ld-jupiter:use-item', source, 30)
end)

RegisterServerEvent('ld-jupiter:sihirsil')
AddEventHandler('ld-jupiter:sihirsil', function()
    local xPlayer = PantCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem('sihir', 1) 
    TriggerClientEvent("inventory:client:ItemBox", xPlayer.PlayerData.source, PantCore.Shared.Items["sihir"], "remove", 1)
end)
