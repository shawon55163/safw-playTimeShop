if NCHub.Framework == "safw" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif NCHub.Framework == "oldsafw" then 
    QBCore = nil
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
end

local topPlayers = {}
Citizen.CreateThread( function()
    while true do 
        topPlayers = ExecuteSql("SELECT firstName, lastName, coin FROM nc_playtimeshop ORDER BY coin DESC LIMIT 6")
        Wait(5*60000)
    end
end)

QBCore.Functions.CreateCallback('nc-playTimeShop:getPlayerDetails', function(source, cb)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    local steamid = tonumber(identifier:gsub("steam:",""), 16)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local citizenId = xPlayer.PlayerData.citizenid
    local firstName = xPlayer.PlayerData.charinfo.firstname
    local lastName = xPlayer.PlayerData.charinfo.lastname
    local todayRewardDay = todayReward
    local callbackData = {}
    local result = ExecuteSql("SELECT * FROM nc_playtimeshop WHERE citizenid = '"..citizenId.."'")
    if result[1] == nil then    
        ExecuteSql("INSERT INTO nc_playtimeshop SET citizenid = '"..citizenId.."', coin = '0', firstName = '"..firstName.."', lastName = '"..lastName.."'")
        callbackData = {
            coin = 0,
            topPlayers = topPlayers,
            steamid = steamid,
            steamApiKey = steamApiKey,
        }
    else
        callbackData = {
            coin = result[1].coin, 
            topPlayers = topPlayers,
            steamid = steamid,
            steamApiKey = steamApiKey,
        }
    end
    cb(callbackData)
end)

QBCore.Functions.CreateCallback('nc-playTimeShop:buyItem', function(source, cb, data)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local myCart = data.sendCart
    local jsItem = data.itemInfo
    local totalPrice = tonumber(data.totalPrice)
    local result = ExecuteSql("SELECT * FROM nc_playtimeshop WHERE citizenid = '"..citizenId.."'")
    if result[1] == nil then   
        cb(false)
    else
        local selectedItem = nil
        for k, v in pairs(NCHub.Items) do
            if v.id == jsItem.id then 
                selectedItem = v
                break
            end
        end
        if result[1].coin >= selectedItem.price then
            local myItem = selectedItem.itemName
            local count = selectedItem.count
            local itemType = selectedItem.itemType
            ExecuteSql("UPDATE nc_playtimeshop SET coin = coin - '"..selectedItem.price.."' WHERE citizenid = '"..citizenId.."'")
            if itemType == "item" then 
                xPlayer.Functions.AddItem(myItem, count)
            elseif itemType == "weapon" then 
                for i = 1, count, 1 do 
                    xPlayer.Functions.AddItem(myItem, 1)
                end
            elseif itemType == "vehicle" then
                for i = 1, count do 
                    local plate = GeneratePlate()
                    ExecuteSql("INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES ('"..xPlayer.PlayerData.license.."', '"..citizenId.."', '"..myItem.."', '"..GetHashKey(myItem).."', '{}', '"..plate.."', '"..NCHub.DefaultGarage.."', 1)")
                end
            elseif itemType == "money" then 
                xPlayer.Functions.AddMoney('cash', count)
            end
            cb(true)
        else
            cb(false)
        end
    end
end)

QBCore.Functions.CreateCallback('nc-playTimeShop:sendInput', function(source, cb, data)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local inputData = data.input
    local totalPrice = tonumber(data.totalPrice)
    local result = ExecuteSql("SELECT * FROM nc_playtimeshop_codes WHERE code = '"..inputData.."'")
    if result[1] ~= nil then
        ExecuteSql("DELETE FROM nc_playtimeshop_codes WHERE code = '"..inputData.."'")
        ExecuteSql("UPDATE nc_playtimeshop SET coin = coin + '"..result[1].credit.."' WHERE citizenid = '"..citizenId.."'")
        SendToDiscord("CitizenID: ``"..citizenId.."``\nCredit: ``"..result[1].credit.."``\nCode: ``"..inputData.."``\nUsed code!")
        cb(result[1].credit)
    else
        cb(false)
    end
end)

RegisterNetEvent('nc-playTimeShop:addCoin')
AddEventHandler('nc-playTimeShop:addCoin', function(amount)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local deger = tonumber(amount)
    ExecuteSql("UPDATE nc_playtimeshop SET coin = coin + '"..deger.."' WHERE citizenid = '"..citizenId.."'")
end)

RegisterCommand('purchase_playtime_credit', function(source, args)
	local src = source
    if src == 0 then
        local dec = json.decode(args[1])
        local tbxid = dec.transid
        local credit = dec.credit
        while inProgress do
            Wait(1000)
        end
        inProgress = true
        local result = ExecuteSql("SELECT * FROM nc_playtimeshop_codes WHERE code = '"..tbxid.."'")
        if result[1] == nil then
            ExecuteSql("INSERT INTO nc_playtimeshop_codes (code, credit) VALUES ('"..tbxid.."', '"..credit.."')")
            SendToDiscord("Code: ``"..tbxid.."``\nCredit: ``"..credit.."``\nsuccessfuly into your database!")
        end
        inProgress = false  
    end
end)

function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local send = false
    local result = ExecuteSql("SELECT plate FROM player_vehicles WHERE plate = '"..plate.."'")
    if result[1] then
        return GeneratePlate()
    else
        return plate:upper()
    end
end


local DISCORD_NAME = "Golden State RolePlay"
local DISCORD_IMAGE = "https://cdn.discordapp.com/attachments/1127694279465259078/1131925192294273054/gsrp.png"
DiscordWebhook = Discord_Webhook
function SendToDiscord(name, message, color)
	if DiscordWebhook == "CHANGE_WEBHOOK" then
	else
		local connect = {
            {
                ["color"] = color,
                ["title"] = "**".. name .."**",
                ["description"] = message,
                ["footer"] = {
                ["text"] = "NCHub Playtime Shop",
                },
            },
	    }
		PerformHttpRequest(DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatarrl = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
	end
end

function ExecuteSql(query)
    local IsBusy = true
    local result = nil
    if NCHub.Mysql == "oxmysql" then
        if MySQL == nil then
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        else
            MySQL.query(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif NCHub.Mysql == "ghmattimysql" then
        exports.ghmattimysql:execute(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    elseif NCHub.Mysql == "mysql-async" then   
        MySQL.Async.fetchAll(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end