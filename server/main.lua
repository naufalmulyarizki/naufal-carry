RegisterNetEvent('naufal-carry:server:sendRequest', function(targetId, closestPlayer, libanim1, anim1, libanim2, anim2, distans, distans2, height, spin, length, controlFlagMe, controlFlagTarget, animFlagTarget)
    local src = source
    local target = tonumber(targetId)
    if targetId == -1 then return end
    local srcCoords = GetEntityCoords(GetPlayerPed(src))
    local targetCoords = GetEntityCoords(GetPlayerPed(targetId))

    if #(srcCoords - targetCoords) > 5.0 then return end

    TriggerClientEvent('naufal-carry:client:receiveRequest', target, src, closestPlayer, libanim1, anim1, libanim2, anim2, distans, distans2, height, spin, length, controlFlagMe, controlFlagTarget, animFlagTarget)
end)

RegisterNetEvent('naufal-carry:server:accept', function(fromId, closestPlayer, libanim1, anim1, libanim2, anim2, distans, distans2, height, spin, length, controlFlagMe, controlFlagTarget, animFlagTarget)
    local src = source
    local giver = src
    local receiver = tonumber(fromId)
    if receiver == -1 then return end

    local srcCoords = GetEntityCoords(GetPlayerPed(src))
    local targetCoords = GetEntityCoords(GetPlayerPed(fromId))

    if #(srcCoords - targetCoords) > 5.0 then return end

    TriggerClientEvent('naufal-carry:client:receivedcarry', receiver, src, closestPlayer, libanim1, anim1, libanim2, anim2, distans, distans2, height, spin, length, controlFlagMe, controlFlagTarget, animFlagTarget)
end)

RegisterServerEvent('naufal-carry:server:sync')
AddEventHandler('naufal-carry:server:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
    if target == -1 then return end
    local srcCoords = GetEntityCoords(GetPlayerPed(source))
    local targetCoords = GetEntityCoords(GetPlayerPed(targetSrc))

    if #(srcCoords - targetCoords) > 5.0 then return end
    
    TriggerClientEvent('naufal-carry:client:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
    TriggerClientEvent('naufal-carry:client:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('naufal-carry:server:stop')
AddEventHandler('naufal-carry:server:stop', function(targetSrc)
    if targetSrc == -1 then return end
    local srcCoords = GetEntityCoords(GetPlayerPed(source))
    local targetCoords = GetEntityCoords(GetPlayerPed(targetSrc))

    if #(srcCoords - targetCoords) > 5.0 then return end

	TriggerClientEvent('naufal-carry:client:cl_stop', targetSrc)
end)
