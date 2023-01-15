local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('gifmarket:server:BuyItems', function(products)
    local src = source
    local data = Config.Products[products]
    local Player = QBCore.Functions.GetPlayer(src)
    local moneyPlayer = tonumber(Player.PlayerData.money.cash)
    if moneyPlayer > data.buy then
        Player.Functions.RemoveMoney('cash', tonumber(data.buy), 'black-market')
        Player.Functions.AddItem(products, 1, false)
        TriggerClientEvent('QBCore:Notify', src, " You bought " .. data.buy .. " Bits ", 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough money!", 'error')
    end
end)

RegisterServerEvent('gifmarket:server:SellItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 0

    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
        for i = 1, #Player.PlayerData.items do
            if Player.PlayerData.items[i] ~= nil then
                if Config.SellableItems[Player.PlayerData.items[i].name] ~= nil then
                    price = price +
                        (Config.SellableItems[Player.PlayerData.items[i].name] * Player.PlayerData.items[i].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[i].name, Player.PlayerData.items[i].amount)
                    TriggerClientEvent('inventory:client:ItemBox', src,
                        QBCore.Shared.Items[Player.PlayerData.items[i].name], "remove")
                    Player.Functions.AddMoney("cash", price, "sold items")
                    TriggerClientEvent('QBCore:Notify', src, " You Got " .. price .. " ", 'success')
                end
            end
        end
    end
end)

RegisterNetEvent('gifgatmarket:server:startCooldown', function()
    TriggerClientEvent("gifgatmarket:client:setCooldown", -1, true)
    Wait(Config.cooldownTime * 60000)
    TriggerClientEvent("gifgatmarket:client:setCooldown", -1, false)
end)
