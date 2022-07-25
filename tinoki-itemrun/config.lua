Config = {}

Config.Zones = {
	StartCollect = {coords = vector3(504.11727905273,2628.1865234375,42.458324432373)}, -- Coordinate for Start Collect
	CollectCoords_1 = {coords = vector3(480.67459106445,2624.9423828125,43.147895812988)}, -- Coordinate for Collect 1
	CollectCoords_2 = {coords = vector3(369.80157470703,2608.6162109375,43.707202911377)}, -- Coordinate for Collect 2
	CollectCoords_3 = {coords = vector3(322.26400756836,2656.5556640625,44.408561706543)}, -- Coordinate for Collect 3
	CollectCoords_4 = {coords = vector3(472.96502685547,2670.7185058594,43.195499420166)}, -- Coordinate for Collect 4
	CollectCoords_5 = {coords = vector3(571.39569091797,2701.0051269531,41.884845733643)}, -- Coordinate for Collect 5
}

Config.CollectTime = 5000 -- Time in ms 1000 = 1 second

Config.Notification1 = "[E] Start Collect" 
Config.Notification2 = "You start the Collect Progress, go to the collect Area!"
Config.Notification3 = "You already have collect in progress, go to the collect Area!" 
Config.Notification4 = "You successfuly collect the items, go to the next area"
Config.Notification5 = "You successfuly collect all the items!"
Config.Notification6 = "You stop the Collect Progress!"
Config.Notification7 = "[E] Collect"
Config.Notification8 = "You can only do this at 21:00 - 00:00"

Config.BlipName_1 = "Collect Area 1"
Config.BlipName_2 = "Collect Area 2"
Config.BlipName_3 = "Collect Area 3"
Config.BlipName_4 = "Collect Area 4"
Config.BlipName_5 = "Collect Area 5"

Config.RandomAmount = true -- Do you want to random the amount? 
Config.MinAmount = 1 -- Value must be Lower than MaxAmount 
Config.MaxAmount = 5 -- Value must be Lower than MinAmount 

Config.Items = {
	--Item Spawn Name - Amount
	{item = "water_bottle", amount = 3},
	{item = "coffee", amount = 5},
}

