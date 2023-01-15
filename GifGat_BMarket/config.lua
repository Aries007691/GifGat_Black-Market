Config = {}

------ The model of the ped

Config.Model = 'cs_joeminuteman'

Config.cooldownTime = 10 --minutes

------ Shop Times

Config.ShopOpen = 8

Config.ShopClose = 14


------  Shop Items

Config.SellableItems = {
    ['cryptostick'] = math.random(1000, 1000),
    ['var_usb2'] = math.random(250, 300),
    ['var_usb3'] = 500,
    ['var_usb4'] = 400,
    ['var_usb1'] = math.random(900, 1200),
    ['hacking_device'] = math.random(250, 350),
    ['trojan_usb'] = math.random(700, 1000),
    ['tablet1'] = math.random(1000, 1200),
    ['fake_plate'] = math.random(700, 1000),
    ['usb_hack'] = math.random(1000, 1000),
    ['snp_ammo'] = math.random(700, 750),
    ['mg_ammo'] = math.random(200, 250),
    ['shotgun_ammo'] = math.random(200, 250),
    ['smg_ammo'] = math.random(200, 250),
    ['rifle_ammo'] = math.random(200, 250), ----- you can add more items if you wish
}

Config.Products = {
    label = "Blackmarket",
    slots = 10,
    items = {
        [1] = {
            name = "rifle_ammo",
            price = 28000,
            amount = 5,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "var_usb1",
            price = 33000,
            amount = 5,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "weapon_pistol_mk2",
            price = 3800,
            amount = 5,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "weapon_combatpistol",
            price = 15000,
            amount = 5,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "thermite",
            price = 1000,
            amount = 10,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "smg_ammo",
            price = 150,
            amount = 35,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "oxy",
            price = 150,
            amount = 50,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "rifle_ammo",
            price = 250,
            amount = 35,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "trojan_usb",
            price = 2000,
            amount = 5,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "weapon_heavypistol",
            price = 11000,
            amount = 5,
            info = {},
            type = "item",
            slot = 10,
        }
    }
}



local setLoc = math.random(1, 3) -- This code randomly selects a location from Config.SetLocation
--local setLoc = 1 -- this code is if you only use 1 location permenently

Config.SetLocation = { ------add more locations here
    [1] = {
        ["x"] = -1556.84,
        ["y"] = -417.02,
        ["z"] = 38.1,
        ["h"] = 89.15,
    },
    [2] = {
        ["x"] = -1560.51,
        ["y"] = -413.55,
        ["z"] = 38.1,
        ["h"] = 140.8,
    },
    [3] = {
        ["x"] = -1563.43,
        ["y"] = -415.32,
        ["z"] = 38.09,
        ["h"] = 232.84,
    },
}

Config.Locations = {
    ["market"] = {
        ["label"] = "market",
        ["type"] = "mark",
        ["coords"] = {
            [1] = {
                ["x"] = tonumber(Config.SetLocation[setLoc]["x"]),
                ["y"] = tonumber(Config.SetLocation[setLoc]["y"]),
                ["z"] = tonumber(Config.SetLocation[setLoc]["z"]),
                ["h"] = tonumber(Config.SetLocation[setLoc]["h"]),
            },
        },
        ["products"] = Config.Products,
    },
}
