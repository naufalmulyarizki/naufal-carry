carryingBackInProgress = false
carryAnimNamePlaying = ""
carryAnimDictPlaying = ""
carryControlFlagPlaying = 0

RegisterNetEvent('naufal-carry:client:syncTarget')
AddEventHandler('naufal-carry:client:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation2
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('naufal-carry:client:syncMe')
AddEventHandler('naufal-carry:client:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('naufal-carry:client:cl_stop')
AddEventHandler('naufal-carry:client:cl_stop', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

CreateThread(function()
	while true do
		if carryingBackInProgress then 
			while not IsEntityPlayingAnim(PlayerPedId(), carryAnimDictPlaying, carryAnimNamePlaying, 3) do
				TaskPlayAnim(PlayerPedId(), carryAnimDictPlaying, carryAnimNamePlaying, 8.0, -8.0, 100000, carryControlFlagPlaying, 0, false, false, false)
				Wait(0)
			end
		else
			Wait(500)
		end
		Wait(0)
	end
end)