-- IF YOU HAVE ANY PROBLEM OR DO YOU NEED HELP PLS COME TO MY DISCORD SERVER AND CREATE A TICKET
-- IF YOU DONT HAVE ANY PROBLEM YET AGAIN COME TO MY DISCORD :)
-- https://discord.gg/NCHub

NCHub = {}

NCHub.Framework = "safw" -- safw / oldsafw | safw = export system | oldsafw = triggerevent system
NCHub.Mysql = "oxmysql" -- Check fxmanifest.lua when you change it! | ghmattimysql / oxmysql / mysql-async
NCHub.OpenCommand = "gscoin"
NCHub.DefaultGarage = "motelgarage" -- purchased vehicles will be sent to this garage
NCHub.RewardCoin = 10
NCHub.NeededPlayTime = 60 -- Minutes

NCHub.Language = {
    title1 = "GS",
    title2 = "Playtime",
    coin = "COIN",
    nextReward = "FOR THE NEXT COIN REWARD",
    exit = "EXIT",
    reward = "REWARD :",
    title3 = "TOP",
    title4 = "PLAYERS",
    title5 = "PLAYTIME",
    title6 = "SHOP",
    cancel = "CANCEL",
    buy = "BUY",
    accept = "ACCEPT",
    realCurrency = "$",
    nextPage = "NEXT PAGE",
    previousPage = "PRIVIOUS PAGE",
    succesfully = "SUCCESSFULLY",
    purchased = "PURCHASED",
    invalidCode = "INVALID CODE!",
    thxForPurch = "Thanks for purchasing!",
    top = "TOP",
    youDntHvEngMoney = "YOU DONT HAVE ENOUGH MONEY!",
    text6 = "6",
}

NCHub.Categories = {
    { category = "items", icon = "fa-solid fa-cookie-bite", items = {} }, -- do not touch items section..
    { category = "weapons", icon = "fa-solid fa-gun", items = {} }, -- do not touch items section..
    { category = "vehicles", icon = "fa-solid fa-car", items = {} }, -- do not touch items section..
}

-- itemType : vehicle, weapon, item, money
NCHub.Items = {
    { id = 1, itemName = "weapon_heavypistol", label = "HEAVY PISTOL", price = 500, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_heavypistol.png" },
    { id = 2, itemName = "weapon_combatpistol", label = "COMBAT PISTOL", price = 200, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_combatpistol.png" },
    -- { id = 3, itemName = "weapon_appistol", label = "AP PISTOL", price = 150, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_appistol.png" },
    -- { id = 4, itemName = "weapon_advancedrifle", label = "ADVANCED RIFLE", price = 60, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_advancedrifle.png" },
    -- { id = 5, itemName = "weapon_smg", label = "SMG", price = 100, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_smg.png" },
    -- { id = 6, itemName = "weapon_specialcarbine", label = "SPECIAL CARBINE", price = 40, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_specialcarbine.png" },
    -- { id = 7, itemName = "weapon_specialcarbine_mk2", label = "SPECIAL CARBINE MK2", price = 35, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_specialcarbine_mk2.png" },
    -- { id = 8, itemName = "weapon_heavyshotgun", label = "HEAVY SHOTGUN", price = 65, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_heavyshotgun.png" },
    -- { id = 9, itemName = "weapon_combatpdw", label = "COMBAT PDW", price = 85, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_combatpdw.png" },
    -- { id = 10, itemName = "weapon_assaultrifle", label = "ASSAULT RIFLE", price = 110, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_assaultrifle.png" },
    -- { id = 11, itemName = "weapon_carbinerifle", label = "CARBINE RIFLE", price = 135, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_carbinerifle.png" },
    -- { id = 12, itemName = "weapon_bullpuprifle", label = "BULLPUP RIFLE", price = 125, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_bullpuprifle.png" },
    -- { id = 13, itemName = "weapon_crowbar", label = "CROWBAR", price = 70, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_crowbar.png" },
    -- { id = 14, itemName = "weapon_knife", label = "KNIFE", price = 95, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_knife.png" },
    -- { id = 15, itemName = "weapon_knuckle", label = "KNUCKLE", price = 65, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_knuckle.png" },
    -- { id = 16, itemName = "weapon_grenade", label = "GRENADE", price = 45, count = 1, itemType = "weapon", category = "weapons", image = "./images/weapon_grenade.png" },

    { id = 17, itemName = "advancedkit", label = "ADVANCED KIT", price = 25, count = 1, itemType = "item", category = "items", image = "./images/advancedkit.png" },
    { id = 18, itemName = "advancedlockpick", label = "ADVANCED LOCKPICK", price = 45, count = 1, itemType = "item", category = "items", image = "./images/advancedlockpick.png" },
    { id = 19, itemName = "armor", label = "ARMOR", price = 35, count = 1, itemType = "item", category = "items", image = "./images/armor.png" },
    { id = 20, itemName = "greenphon", label = "Greenphon", price = 70, count = 1, itemType = "item", category = "items", image = "./images/greenphon.png" },
    -- { id = 21, itemName = "visacard", label = "VISA CARD", price = 95, count = 1, itemType = "item", category = "items", image = "./images/visacard.png" },
    -- { id = 22, itemName = "mastercard", label = "MASTER CARD", price = 75, count = 1, itemType = "item", category = "items", image = "./images/mastercard.png" },
    -- { id = 23, itemName = "usb_device", label = "USB DEVICE", price = 35, count = 1, itemType = "item", category = "items", image = "./images/usb_device.png" },
    -- { id = 24, itemName = "casinochips", label = "CASINO CHIPS", price = 15, count = 1, itemType = "item", category = "items", image = "./images/casinochips.png" },
    -- { id = 25, itemName = "firework3", label = "FIREWORK", price = 70, count = 1, itemType = "item", category = "items", image = "./images/firework3.png" },
    -- { id = 26, itemName = "cocaine_baggy", label = "COCAINE BAGGY", price = 35, count = 1, itemType = "item", category = "items", image = "./images/cocaine_baggy.png" },
    -- { id = 27, itemName = "pistol_ammo", label = "PISTOL AMMO", price = 15, count = 1, itemType = "item", category = "items", image = "./images/pistol_ammo.png" },
    -- { id = 28, itemName = "pistol_suppressor", label = "PISTOL SUPPRESSOR", price = 65, count = 1, itemType = "item", category = "items", image = "./images/pistol_suppressor.png" },
    -- { id = 29, itemName = "radio", label = "RADIO", price = 95, count = 1, itemType = "item", category = "items", image = "./images/radio.png" },

    { id = 30, itemName = "tezeract", label = "WELCOME", price = 30, count = 1, itemType = "vehicle", category = "vehicles", image = "./images/Tezeract.png" },
    -- { id = 31, itemName = "rmodbolide", label = "Bugatti_Bolide", price = 1300, count = 1, itemType = "vehicle", category = "vehicles", image = "./images/Bugatti_Bolide.png" },
    { id = 32, itemName = "bmci", label = "BMW M4", price = 1200, count = 1, itemType = "vehicle", category = "vehicles", image = "./images/bmwm4.png" },
    { id = 33, itemName = "mxthar21", label = "Mahindra_Thar", price = 1000, count = 1, itemType = "vehicle", category = "vehicles", image = "./images/Thar.png" },
}

NCHub.CoinList = {
    { coinCount = 100, realPrice = 0, link = "https://sites.google.com/view/goldenstateroleplaybd/home", image = "./images/coin.png" },
    { coinCount = 300, realPrice = 0, link = "https://sites.google.com/view/goldenstateroleplaybd/home", image = "./images/coin.png" },
    { coinCount = 500, realPrice = 0, link = "https://sites.google.com/view/goldenstateroleplaybd/home", image = "./images/coin.png" },
    { coinCount = 800, realPrice = 0, link = "https://sites.google.com/view/goldenstateroleplaybd/home", image = "./images/coin.png" },
    { coinCount = 1000, realPrice = 0, link = "https://sites.google.com/view/goldenstateroleplaybd/home", image = "./images/coin.png" },
    { coinCount = 1500, realPrice = 0, link = "https://sites.google.com/view/goldenstateroleplaybd/home", image = "./images/coin.png" },
}