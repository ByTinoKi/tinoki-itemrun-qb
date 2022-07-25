local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData              = {}
QBCore = exports['qb-core']:GetCoreObject() 

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(31)
    end
	while QBCore.Functions.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(Player)
	QBCore.PlayerData = Player
	PlayerLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
	QBCore.PlayerData.job = job
end)

local isInCollectProgress = false 
local CollectBlip1, CollectBlip2, CollectBlip3, CollectBlip4, CollectBlip5 = false, false, false, false, false

Citizen.CreateThread(function()
	while true do
		waitTime = 1000
		local coords = GetEntityCoords(PlayerPedId())
		local StartCollectCoords = GetDistanceBetweenCoords(coords, Config.Zones.StartCollect.coords.x, Config.Zones.StartCollect.coords.y, Config.Zones.StartCollect.coords.z, true)
		local CollectPoint_1 = GetDistanceBetweenCoords(coords, Config.Zones.CollectCoords_1.coords.x, Config.Zones.CollectCoords_1.coords.y, Config.Zones.CollectCoords_1.coords.z, true)
		local CollectPoint_2 = GetDistanceBetweenCoords(coords, Config.Zones.CollectCoords_2.coords.x, Config.Zones.CollectCoords_2.coords.y, Config.Zones.CollectCoords_2.coords.z, true)
		local CollectPoint_3 = GetDistanceBetweenCoords(coords, Config.Zones.CollectCoords_3.coords.x, Config.Zones.CollectCoords_3.coords.y, Config.Zones.CollectCoords_3.coords.z, true)
		local CollectPoint_4 = GetDistanceBetweenCoords(coords, Config.Zones.CollectCoords_4.coords.x, Config.Zones.CollectCoords_4.coords.y, Config.Zones.CollectCoords_4.coords.z, true)
		local CollectPoint_5 = GetDistanceBetweenCoords(coords, Config.Zones.CollectCoords_5.coords.x, Config.Zones.CollectCoords_5.coords.y, Config.Zones.CollectCoords_5.coords.z, true)
		
		if StartCollectCoords < 10.0 then
			waitTime = 1
			DrawText3Ds(Config.Zones.StartCollect.coords , Config.Notification1 , 0.4)
			if StartCollectCoords < 2.0 then
				if IsControlJustReleased(0, Keys['E']) then
					local hour = GetClockHours() 
					if (hour >= 21 and hour <= 24) or hour == 0 then -- 0 = 00:00 - 24:00
						if not isInCollectProgress then 
							isInCollectProgress = true 
							QBCore.Functions.Notify("You start the Collect Progress, go to the collect Area!", "success")
							CollectBlip1 = true 
							blip = AddBlipForCoord(Config.Zones.CollectCoords_1.coords)
							SetBlipRoute(blip , true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(Config.BlipName_1)
							EndTextCommandSetBlipName(blip)
						else 
							QBCore.Functions.Notify((Config.Notification3), "success")
						end 
					else 
						QBCore.Functions.Notify((Config.Notification8), "success")
					end
				end 
			end 
		end
		
		if isInCollectProgress then 
			local hour = GetClockHours() 
			if (hour >= 21 and hour <= 24) or hour == 0 then 
				if CollectBlip1 then 
					if CollectPoint_1 < 10.0 then 
						waitTime = 1 
						DrawText3Ds(Config.Zones.CollectCoords_1.coords , Config.Notification7 , 0.4)
						if CollectPoint_1 < 2.0 then 
							if IsControlJustReleased(0, Keys['E']) then
								Collect()
								RemoveBlip(blip)
								CollectBlip1 = false 
								CollectBlip2 = true 
								blip = AddBlipForCoord(Config.Zones.CollectCoords_2.coords)
								SetBlipRoute(blip , true)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(Config.BlipName_2)
								EndTextCommandSetBlipName(blip)
								QBCore.Functions.Notify((Config.Notification4), "success")
							end
						end 
					end 
				elseif CollectBlip2 then 
					if CollectPoint_2 < 10.0 then 
						waitTime = 1 
						DrawText3Ds(Config.Zones.CollectCoords_2.coords , Config.Notification7 , 0.4)
						if CollectPoint_2 < 2.0 then 
							if IsControlJustReleased(0, Keys['E']) then
								Collect()
								RemoveBlip(blip)
								CollectBlip2 = false 
								CollectBlip3 = true 
								blip = AddBlipForCoord(Config.Zones.CollectCoords_3.coords)
								SetBlipRoute(blip , true)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(Config.BlipName_3)
								EndTextCommandSetBlipName(blip)
								QBCore.Functions.Notify((Config.Notification4), "success")
							end
						end 
					end 
				elseif CollectBlip3 then 
					if CollectPoint_3 < 10.0 then 
						waitTime = 1 
						DrawText3Ds(Config.Zones.CollectCoords_3.coords , Config.Notification7 , 0.4)
						if CollectPoint_3 < 2.0 then 
							if IsControlJustReleased(0, Keys['E']) then
								Collect()
								RemoveBlip(blip)
								CollectBlip3 = false 
								CollectBlip4 = true 
								blip = AddBlipForCoord(Config.Zones.CollectCoords_4.coords)
								SetBlipRoute(blip , true)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(Config.BlipName_4)
								EndTextCommandSetBlipName(blip)
								QBCore.Functions.Notify((Config.Notification4), "success")
							end
						end 
					end 
				elseif CollectBlip4 then 
					if CollectPoint_4 < 10.0 then 
						waitTime = 1 
						DrawText3Ds(Config.Zones.CollectCoords_4.coords , Config.Notification7 , 0.4)
						if CollectPoint_4 < 2.0 then 
							if IsControlJustReleased(0, Keys['E']) then
								Collect()
								RemoveBlip(blip)
								CollectBlip4 = false 
								CollectBlip5 = true 
								blip = AddBlipForCoord(Config.Zones.CollectCoords_5.coords)
								SetBlipRoute(blip , true)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(Config.BlipName_5)
								EndTextCommandSetBlipName(blip)
								QBCore.Functions.Notify((Config.Notification4), "success")
							end
						end 
					end 
				elseif CollectBlip5 then 
					if CollectPoint_5 < 10.0 then 
						waitTime = 1 
						DrawText3Ds(Config.Zones.CollectCoords_5.coords , Config.Notification7 , 0.4)
						if CollectPoint_5 < 2.0 then 
							if IsControlJustReleased(0, Keys['E']) then
								Collect()
								RemoveBlip(blip)
								CollectBlip5 = false 
								isInCollectProgress = false 
								QBCore.Functions.Notify((Config.Notification5), "success")
							end
						end 
					end 
				end 
			end 
		end 
		Citizen.Wait(waitTime)
	end
end)

DrawText3Ds = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 370

	DrawRect(_x, _y + 0.0140, 0.030 + factor, 0.025, 0, 0, 0, 100)
end

function Collect()
	if not isBusy then 
		isBusy = true 
		TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
		FreezeEntityPosition(PlayerPedId() , true )
		Citizen.Wait(Config.CollectTime)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent("tinoki-items:collect")
		FreezeEntityPosition(PlayerPedId() , false )
		isBusy = false
	end
end

RegisterCommand("stopcollect", function()
	isBusy = false
	RemoveBlip(blip)
	isInCollectProgress, CollectBlip1, CollectBlip2, CollectBlip3, CollectBlip4, CollectBlip5 = false, false, false, false, false, false
	QBCore.Functions.Notify((Config.Notification6), "success")
end)