if NCHub.Framework == "safw" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif NCHub.Framework == "oldsafw" then 
    QBCore = nil
end

Citizen.CreateThread(function()
    if NCHub.Framework == "oldsafw" then 
        while QBCore == nil do
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
	elseif NCHub.Framework == "safw" then
		while QBCore == nil do
            Citizen.Wait(200)
        end
    end
    playTime = GetGameTimer() + (NCHub.NeededPlayTime * 60000)
	PlayerData = QBCore.Functions.GetPlayerData()
    Wait(1000)
    SendNUIMessage({
        type = 'translate', 
        translate = NCHub.Language,
    })		
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
    playTime = GetGameTimer() + (NCHub.NeededPlayTime * 60000)
    Wait(1000)
    SendNUIMessage({
        type = 'translate', 
        translate = NCHub.Language,
    })	
end)

RegisterCommand(NCHub.OpenCommand, function()
	openMenu()
end)

local openMenuSpamProtect = 0
function openMenu()
    if openMenuSpamProtect < GetGameTimer() then 
        openMenuSpamProtect = GetGameTimer() + 1500
        QBCore.Functions.TriggerCallback("nc-playTimeShop:getPlayerDetails", function(result)
            apiKey = result.steamApiKey
            if result.steamid then
                steamID = "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=" .. apiKey .. "&steamids=" .. result.steamid
            else
                steamID = 'null'
            end
            local checkTime = tonumber(getNeededPlayTime()*60)
            local remainingTime = disp_time(checkTime)
            local firstname = PlayerData.charinfo.firstname
            local lastname = PlayerData.charinfo.lastname
            SetNuiFocus(true,true)
            SendNUIMessage({
                type = 'openui', 
                coin = result.coin,
                categories = NCHub.Categories,
                items = NCHub.Items,
                steamid = steamID,
                firstname = firstname,
                lastname = lastname,
                remaining = remainingTime,
                coinReward = NCHub.RewardCoin,
                coinList = NCHub.CoinList,
                topPlayers = result.topPlayers,
            })	
        end)
    end
end

function disp_time(time)
    local days = math.floor(time/86400)
    local remaining = time % 86400
    local hours = math.floor(remaining/3600)
    remaining = remaining % 3600
    local minutes = math.floor(remaining/60)
    remaining = remaining % 60
    local seconds = remaining
    if (hours < 10) then
        hours = "0" .. tostring(hours)
    end
    if (minutes < 10) then
        minutes = "0" .. tostring(minutes)
    end
    if (seconds < 10) then
        seconds = "0" .. tostring(seconds)
    end
    if hours ~= "00" then 
        answer = hours..'h '..minutes..'m'
    else
        answer = minutes..'m'

    end
    return answer
end

Citizen.CreateThread(function()
    while true do
        Wait(5000)
        local checkTime = tonumber(getNeededPlayTime())
        if checkTime <= 0 then
            playTime = GetGameTimer() + (NCHub.NeededPlayTime * 60000)
            TriggerServerEvent('nc-playTimeShop:addCoin', NCHub.RewardCoin)
        end
    end
end)


getNeededPlayTime = function()
    return math.round((playTime - GetGameTimer()) / 60000, 2)
end

function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local buyItemSpamProtect = 0
RegisterNUICallback('buyItem', function(data, cb)
    if buyItemSpamProtect < GetGameTimer() then 
        buyItemSpamProtect = GetGameTimer() + 1500
        QBCore.Functions.TriggerCallback("nc-playTimeShop:buyItem", function(result)
            cb(result)
        end, data)
    end
end)

local sendInputProtect = 0
RegisterNUICallback('sendInput', function(data, cb)
    if sendInputProtect < GetGameTimer() then 
        sendInputProtect = GetGameTimer() + 1500
        QBCore.Functions.TriggerCallback("nc-playTimeShop:sendInput", function(result)
            cb(result)
        end, data)
    end
end)

RegisterNUICallback('closeMenu', function(data, cb)
	SetNuiFocus(false, false)
end)

CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(1, 199) then
            ExecuteCommand("safwcoin")
        end
    end
  end)
  

RegisterNetEvent('radial:safwcoin')
AddEventHandler('radial:safwcoin', function()

    ExecuteCommand("safwcoin")

end)