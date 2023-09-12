local peds = {}
local c = Config

local function draw3dText(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text
    SetTextColour(c.color.r, c.color.g, c.color.b, c.color.a)
    SetTextScale(0.0, c.scale * scale)
    SetTextFont(c.font)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

local function launchAnimation(ped, speed) 
    -- Launche random animations
    local randomIndex = math.random(1, #c.animationList)
    randomAnimation = c.animationList[randomIndex]
    RequestAnimDict(randomAnimation.dictionary)
    while not HasAnimDictLoaded(randomAnimation.dictionary) do
        Wait(1)
    end
    TaskPlayAnim(ped, randomAnimation.dictionary, randomAnimation.name, speed, speed, -1, 49, 0, false, false, false)

    return randomAnimation
end

local function displayText(ped, words)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local targetPos = GetEntityCoords(ped)
    local dist = #(playerPos - targetPos)
    local los = HasEntityClearLosToEntity(playerPed, ped, 17)

    if dist <= c.dist and los then
        peds[ped] = {
            interval = GetGameTimer() + c.wordInterval,
            words = words,
            text = ""
        }
        local randomAnimation
        local display = true
        
        for i=1, #peds[ped].words do
            peds[ped].text = peds[ped].text..peds[ped].words[i].." "

            randomAnimation = launchAnimation(ped, c.animationSpeed) 
            
            while display do
                Wait(0)
                local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.2)
                draw3dText(pos, peds[ped].text)
                display = GetGameTimer() <= peds[ped].interval
            end
            StopAnimTask(ped, randomAnimation.dictionary, randomAnimation.name, 8.0)

            peds[ped].interval = GetGameTimer() + c.wordInterval
            display = true
        end

        display = true
        peds[ped].time = GetGameTimer() + c.time

        while display and peds[ped].time ~= nil do
            Wait(0)
            local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.2)
            if peds[ped].time ~= nil then
                draw3dText(pos, peds[ped].text)
                display = GetGameTimer() <= peds[ped].time
            end
        end
        peds[ped] = nil
    end
end

local function displaySign(words, target)
    local player = GetPlayerFromServerId(target)
    if player ~= -1 or target == GetPlayerServerId(PlayerId()) then
        local ped = GetPlayerPed(player)
        displayText(ped, words)
    end
end

-- Register the event
RegisterNetEvent('cham-signlanguage:displaySign', displaySign)

-- Adding chat suggestion
TriggerEvent('chat:addSuggestion', '/' .. "sign", "permet de parler en langue des signes", {{ name = 'Text', help = '"Bonjour, comment tu vas ?"'}})
