local Config = require 'shared.config'

for k,v in pairs(Config.Command) do
    RegisterCommand(k, function(source, args)   
        local coords = GetEntityCoords(cache.ped)
        local closestPlayer = lib.getNearbyPlayers(coords, 3.0)
        local target = GetPlayerServerId(closestPlayer[1].id)
        
        if not LocalPlayer.state.isLoggedIn then return end
        if not carryingBackInProgress then
            TriggerServerEvent('naufal-carry:server:sendRequest', target, closestPlayer, v.libanim1, v.anim1, v.libanim2, v.anim2, v.distans, v.distans2, v.height, v.spin, v.length, v.controlFlagMe, v.controlFlagTarget, v.animFlagTarget)
        else
            carryingBackInProgress = false
            ClearPedSecondaryTask(PlayerPedId())
            DetachEntity(PlayerPedId(), true, false)
            if target ~= 0 then 
                TriggerServerEvent("naufal-carry:server:stop",target)
            end
        end
    end)
end

RegisterNetEvent('naufal-carry:client:receiveRequest', function(fromId, closestPlayer, libanim1, anim1, libanim2, anim2, distans, distans2, height, spin, length, controlFlagMe, controlFlagTarget, animFlagTarget)
    if not LocalPlayer.state.isLoggedIn then return end

    local result = lib.alertDialog({
        header = 'Request Carry',
        content = 'Seseorang meminta kamu untuk menggendong kamu, apakah kamu ingin berikan?',
        centered = true,
        cancel = true,
        labels = {
            confirm = 'Berikan',
            cancel = 'Tolak'
        }
    })

    if result == 'confirm' then
        TriggerServerEvent('naufal-carry:server:accept', fromId, closestPlayer, libanim1, anim1, libanim2, anim2, distans, distans2, height, spin, length, controlFlagMe, controlFlagTarget, animFlagTarget)
    end
end)

RegisterNetEvent("naufal-carry:client:receivedcarry",function(target, closestPlayer, libanim1, anim1, libanim2, anim2, distans, distans2, height, spin, length, controlFlagMe, controlFlagTarget, animFlagTarget)
    if not LocalPlayer.state.isLoggedIn then return end
	if IsEntityPlayingAnim(cache.ped, 'missfbi3_sniping', 'prone_dave', 3) then return end
    
    if not IsPedInAnyVehicle(cache.ped) or IsPedJumping(cache.ped) or IsPedFalling(cache.ped) or IsPedDeadOrDying(cache.ped) then
        local player = PlayerPedId()	
        carryingBackInProgress = true
        TriggerServerEvent('naufal-carry:server:sync', closestPlayer, libanim1,libanim2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
    else
        lib.notify({
            title = 'Carry',
            description = 'Kamu tidak bisa melakukan itu',
            type = 'error'
        })
    end
end,false)