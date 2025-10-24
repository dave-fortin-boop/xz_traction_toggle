ESX = nil

-- =======================
-- 🔹 INITIALISATION
-- =======================
CreateThread(function()
    -- Attendre ESX
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(200)
    end

    -- Attente de ox_lib (ancienne version)
    while not lib or not lib.addRadialItem do
        Wait(100)
    end

    print('[car_traction_toggle] ox_lib détecté et prêt.')

    -- Synchronisation initiale
    TriggerServerEvent('cartraction:requestSync')

    -- ✅ Ajouter directement les deux boutons dans le menu radial global
    lib.addRadialItem({
        id = 'traction_2x4',
        label = 'Mode 2x4',
        icon = 'car',
        onSelect = function()
            setTractionMode('2x4')
        end
    })

    lib.addRadialItem({
        id = 'traction_4x4',
        label = 'Mode 4x4',
        icon = 'truck',
        onSelect = function()
            setTractionMode('4x4')
        end
    })
end)

-- =======================
-- 🔹 OUTILS DE NOTIFICATION
-- =======================
local function notify(msg, type)
    if lib and lib.notify then
        lib.notify({
            title = 'Traction',
            description = msg,
            type = type or 'inform'
        })
    else
        SetNotificationTextEntry("STRING")
        AddTextComponentString(msg)
        DrawNotification(false, false)
    end
end

-- =======================
-- 🔹 GESTION DE LA TRACTION
-- =======================
function applyTraction(vehicle, mode)
    if DoesEntityExist(vehicle) then
        if mode == '2x4' then
            SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveBiasFront', 0.0) -- propulsion
        elseif mode == '4x4' then
            SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveBiasFront', 0.5) -- 4 roues motrices
        end
    end
end

RegisterNetEvent('cartraction:applyMode', function(plate, mode)
    local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    if playerVeh ~= 0 then
        local vehPlate = GetVehicleNumberPlateText(playerVeh)
        if vehPlate == plate then
            applyTraction(playerVeh, mode)
        end
    end
end)

function setTractionMode(mode)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then
        notify("Vous devez être dans un véhicule.", 'error')
        return
    end

    local class = GetVehicleClass(veh)
    -- 9 = Offroad / 10 = SUV / 11 = Camion / 14 = Industriel
    if class ~= 9 and class ~= 10 and class ~= 11 and class ~= 14 then
        notify("Ce véhicule ne peut pas changer de mode de traction.", 'error')
        return
    end

    local plate = GetVehicleNumberPlateText(veh)
    applyTraction(veh, mode)
    TriggerServerEvent('cartraction:setMode', plate, mode)

    if mode == '2x4' then
        notify("Traction réglée en 2x4 (propulsion).", 'warning')
    else
        notify("Traction réglée en 4x4.", 'success')
    end
end
