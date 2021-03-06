esx = nil

TriggerEvent('esx:getSharedObject', function(obj) esx = obj end)

local currentlyRobbing = {}
local activeRobbery = false

local function getPolice()
	local police = {}
	local players = GetPlayers()
	for k, v in pairs(players) do
		local id = tonumber(v)
		local xPlayer = esx.GetPlayerFromId(id)
		if xPlayer ~= nil and xPlayer.job ~= nil then
			if xPlayer.job.name == 'police' then
				table.insert(police, id)
			end
		end
	end
	return police
end

esx.RegisterServerCallback('esx_oil_robbery:copsonline', function(source, cb)
	cb(#getPolice())
end)

RegisterServerEvent('esx_oil_robbery:toofar')
AddEventHandler('esx_oil_robbery:toofar', function(robb)
	local src = source
	if activeRobbery and currentlyRobbing[src] then
		activeRobbery = false
		currentlyRobbing[src] = nil
		for k, v in pairs(getPolice()) do
			TriggerClientEvent('esx:showNotification', v, Config.Strings["robbery_cancelled_at"] .. Config.RobberyLocations[robb].label)
			TriggerClientEvent('esx_oil_robbery:killblip', v)
		end
		TriggerClientEvent('esx_oil_robbery:toofarlocal', src)
		if Config.AlarmSound then
			TriggerClientEvent("esx_oil_robbery:stopsound", -1)
		end
		TriggerClientEvent('esx:showNotification', src, Config.Strings["robbery_has_cancelled"] .. Config.RobberyLocations[robb].label)
	end
end)

RegisterServerEvent('esx_oil_robbery:endrob')
AddEventHandler('esx_oil_robbery:endrob', function(robb)
	local src = source
	if activeRobbery and currentlyRobbing[src] then
		activeRobbery = false
		currentlyRobbing[src] = nil
		for k, v in pairs(getPolice()) do
			TriggerClientEvent('esx:showNotification', v, Config.Strings["end"])
			TriggerClientEvent('esx_oil_robbery:killblip', v)
		end
		TriggerClientEvent('esx_oil_robbery:robberycomplete', src)
		if Config.AlarmSound then
			TriggerClientEvent("esx_oil_robbery:stopsound", -1)
		end
		TriggerClientEvent('esx:showNotification', src, Config.Strings["robbery_has_ended"] .. Config.RobberyLocations[robb].label)
	end
end)

RegisterServerEvent('esx_oil_robbery:rob')
AddEventHandler('esx_oil_robbery:rob', function(loc)
	local src = source
	local xPlayer = esx.GetPlayerFromId(src)
	if xPlayer ~= nil then
		if Config.RobberyLocations[loc] then
			local store = Config.RobberyLocations[loc]
			local storeCoords = store.location

			local ped = GetPlayerPed(src)
			local coords = GetEntityCoords(ped)

			local dist = #(coords - storeCoords)

			if dist < 5.0 then
				if (os.time() - store.lastrobbed) < Config.RobberyCooldownTimer and store.lastrobbed ~= 0 then
					TriggerClientEvent('esx:showNotification', src, Config.Strings["already_robbed"] .. (Config.RobberyCooldownTimer - (os.time() - store.lastrobbed)) .. Config.Strings["seconds"])
					return
				end

				if not activeRobbery then
					activeRobbery = true
					currentlyRobbing[src] = true

					for k, v in pairs(getPolice()) do
						TriggerClientEvent('esx:showNotification', v, Config.Strings["rob_in_prog"] .. store.label)
						TriggerClientEvent('esx_oil_robbery:setblip', v, coords)
					end

					TriggerClientEvent('esx:showNotification', src, Config.Strings["started_to_rob"] .. store.label .. Config.Strings["do_not_move"])
					TriggerClientEvent('esx:showNotification', src, Config.Strings["alarm_triggered"])
					TriggerClientEvent('esx:showNotification', src, Config.Strings["hold_pos"])
					TriggerClientEvent('esx_oil_robbery:currentlyrobbing', src)
					if Config.AlarmSound then
						TriggerClientEvent('esx_oil_robbery:alarmsound', -1, coords)
					end
					store.lastrobbed = os.time()
				else
					TriggerClientEvent('esx:showNotification', src, Config.Strings["robbery_already"])
				end
			end
		end
	end
end)

RegisterServerEvent('esx_oil_robbery:recievepetrol')
AddEventHandler('esx_oil_robbery:recievepetrol', function(location)
	local src = source
	local srcName = GetPlayerName(src)
	local xPlayer = esx.GetPlayerFromId(src)
	if xPlayer ~= nil then
		if activeRobbery then
			if currentlyRobbing[src] then
				xPlayer.addInventoryItem(Config.ItemName, math.random(Config.Minpetrol, Config.Maxpetrol))
			else
				--insert kick or ban event here
				--Kick: --DropPlayer(src, "Exploiting")
				print("^1esx_oil_robbery^0: ^4"..srcName.." (ID: "..tonumber(src)..")^0 is attempting to exploit the event: ^4esx_oil_robbery:recievepetrol. This player is attempting to collect petrol but is not currently robbing a jewlery location!")
			end
		else
			--insert kick or ban event here
			--Kick: --DropPlayer(src, "Exploiting")
			print("^1esx_oil_robbery^0: ^4"..srcName.." (ID: "..tonumber(src)..")^0 is attempting to exploit the event: ^4esx_oil_robbery:recievepetrol. This player is attempting to collect petrol but a petrol robbery is not currently active at any location!")
		end
	end
end)

RegisterServerEvent('esx_oil_robbery:sellpetrol')
AddEventHandler('esx_oil_robbery:sellpetrol', function()
	local src = source
	local srcName = GetPlayerName(src)
	local xPlayer = esx.GetPlayerFromId(src)
	if xPlayer ~= nil then
		local itemCount = xPlayer.getInventoryItem(Config.ItemName).count
		if itemCount >= Config.Minpetrol then
			local ped = GetPlayerPed(src)
			local coords = GetEntityCoords(ped)
			local dist = #(coords - Config.SellPoint)
			if dist < 5.0 then
				local reward = math.floor(Config.PriceForOnepetrol * Config.MaxpetrolSell)
				xPlayer.removeInventoryItem(Config.ItemName, Config.MaxpetrolSell)
				xPlayer.addMoney(reward)
			else
				print("^1esx_oil_robbery^0: ^4"..srcName.." (ID: "..tonumber(src)..")^0 is attempting to exploit the event: ^4esx_oil_robbery:sellpetrol. This player is attempting to sell petrol but their distance from the sell location is: ^4"..a..".")
			end
		else
			--insert kick or ban event here
			--Kick: --DropPlayer(src, "Exploiting")
			print("^1esx_oil_robbery^0: ^4"..srcName.." (ID: "..tonumber(src)..")^0 is attempting to exploit the event: ^4esx_oil_robbery:sellpetrol. This player is attempting to sell petrol but does not have the minimum required amount of petrol to be able to sell.")
		end
	end
end)

AddEventHandler('playerDropped', function(reason)
	local src = source
	currentlyRobbing[src] = nil
end)

esx.RegisterServerCallback('esx_oil_robbery:getItemAmount', function(source, cb)
	local src = source
	local xPlayer = esx.GetPlayerFromId(src)
	local quantity = xPlayer.getInventoryItem(Config.ItemName).count
	cb(quantity)
end)