QBCore = exports['qb-core']:GetCoreObject()

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('tinoki-items:collect')
AddEventHandler('tinoki-items:collect', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	for k,v in ipairs(Config.tinoki-items)do
		if Config.RandomAmount then 
			local rAmount = math.random(Config.MinAmount, Config.MaxAmount)
			Player.Functions.AddItem(v.item, rAmount)
		else 
			Player.Functions.AddItem(v.item, v.amount)
		end
	end
end)