local tractionModes = {}

RegisterNetEvent('cartraction:setMode', function(plate, mode)
    tractionModes[plate] = mode
    TriggerClientEvent('cartraction:applyMode', -1, plate, mode)
end)

RegisterNetEvent('cartraction:requestSync', function()
    local src = source
    for plate, mode in pairs(tractionModes) do
        TriggerClientEvent('cartraction:applyMode', src, plate, mode)
    end
end)
