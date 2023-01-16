QBCore = exports['qb-core']:GetCoreObject()
local cooldown = false

CreateThread(function()
    while true do
        local InRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        for shop, _ in pairs(Config.Locations) do
            local position = Config.Locations[shop]["coords"]
            for _, loc in pairs(position) do
                local dist = #(PlayerPos - vector3(loc["x"], loc["y"], loc["z"]))
                if dist <= 500.0 then
                    if not DoesEntityExist(dealer) then
                        RequestModel('g_m_m_chicold_01')
                        while not HasModelLoaded('g_m_m_chicold_01') do
                            Wait(10)
                        end
                        dealer = CreatePed(26, 'g_m_m_chicold_01', loc["x"], loc["y"], loc["z"] - 1, loc["h"], false,
                            false)
                        SetEntityHeading(dealer, loc["h"])
                        SetBlockingOfNonTemporaryEvents(dealer, true)
                        TaskStartScenarioInPlace(dealer, 'WORLD_HUMAN_AA_SMOKE', 0, false)
                        FreezeEntityPosition(dealer, true)
                        SetEntityInvincible(dealer, true)
                    end
                else
                    Wait(1500)
                end
                if dist <= 10 then
                    InRange = true
                    if dist <= 2 then
                        if IsControlJustPressed(0, 38) then
                            if GetClockHours() >= Config.ShopOpen and GetClockHours() <= Config.ShopClose then
                                TriggerEvent('gifmarket:client:SellMenu2')
                            else
                                QBCore.Functions.Notify("The shop is currently closed, please come back later.", 'error'
                                    , 500)
                            end
                        end
                    end
                end
            end
        end
        if not InRange then
            Wait(5000)
        end
        Wait(5)
    end
end)

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

------ functions

RegisterNetEvent("gifmarket:client:SellItems", function()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    QBCore.Functions.Progressbar("sell_items", "Checking items value", 3000, false, true, {}, {}, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('gifmarket:server:SellItems')
    end, function()
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Canceled...", 'error')
    end)
end)

RegisterNetEvent("gifmarket:openshop", function()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    QBCore.Functions.Progressbar("sell_items", "Checking stock", 3000, false, true, {}, {}, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "illegalshit", Config.Products)
    end, function()
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Canceled...", 'error')
    end)
end)

RegisterNetEvent('gifmarket:client:SellMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Black Market",
            isMenuHeader = true
        },
        {
            header = "I have some items?",
            txt = "Sell your items",
            params = {
                event = 'gifmarket:client:SellItems'

            }
        },
        {
            header = "Open shop",
            txt = "Buy items",
            params = {
                event = 'gifmarket:openshop'

            }
        },
        {
            header = "Close menu",
            txt = "",
            params = {
                event = 'qb-menu:closeMenu'
            }
        },
    })
end)


---------If you dont want to use an item comment out the enire code bellow
RegisterNetEvent("gifmarket:client:SellMenu2", function()
if not cooldown then
    local hasItem = QBCore.Functions.HasItem('YOUR ITEM NAME')
    if hasItem then
        TriggerEvent("gifmarket:client:SellMenu")
        TriggerServerEvent('gifgatmarket:server:startCooldown')
    else
                QBCore.Functions.Notify('you are not trusted to use this', 'error', 3500)
            end
    else
        QBCore.Functions.Notify('you are not trusted to use this', 'error', 3500)
    end
end)

RegisterNetEvent("gifgatmarket:client:setCooldown", function(cd)
    cooldown = cd
end)
