Config = {}

Config.RequiredCopsRob = 3
Config.RequiredCopsSell = 0
Config.Minpetrol = 1 
Config.Maxpetrol = 1
Config.RobberyCooldownTimer = 1800 --30 minutes
Config.MaxpetrolSell = 1
Config.PriceForOnepetrol = 1000

Config.AlarmSound = true

Config.ItemName = 'petrol'

Config.SellPoint = vector3(259.32, 2585.96, 44.95)

Config.RobberyLocations = {
	["petrol"] = {
		location = vector3(597.25, 2928.88, 40.92),      
		label = "olie",
		lastrobbed = 0,
		shoesLocations = {
			{coords = vector3(588.2, 2926.18, 40.91), heading = 15.8, robbed = false},
			{coords = vector3(578.24, 2931.25, 40.9), heading = 90.47, robbed = false},
			{coords = vector3(575.22, 2926.98, 40.8), heading = 222.77, robbed = false},
			{coords = vector3(590.39, 2923.54, 40.88), heading = 232.18, robbed = false},
			{coords = vector3(586.03, 2929.53, 40.91), heading = 157.12, robbed = false},
			{coords = vector3(578.39, 2928.13, 41.44), heading = 258.81, robbed = false},
			{coords = vector3(579.54, 2929.88, 41.44), heading = 254.21, robbed = false},
			{coords = vector3(581.7, 2928.14, 41.44), heading = 93.9, robbed = false},
			{coords = vector3(583.13, 2926.81, 41.44), heading = 158.93, robbed = false},
			{coords = vector3(578.87, 2926.37, 41.44), heading = 254.9, robbed = false},

		}
	}
}

Config.Strings = {
	["robbery_cancelled"] = "De overval is geannuleerd!",
	["shop_robbery"] = "~b~Olie-Plantage (Overval)",
	["press_to_rob"] = "~b~Schiet om de overval te starten",
	["seconds_remaining"] = "~w~ seconden resterend",
	["robbery_cancelled_at"] = "~r~ overval is geannuleerd op: ~b~",
	["robbery_has_cancelled"] = "~r~ de overval is geannuleerd: ~b~",
	["already_robbed"] = "De olie plantage is al beroofd. Wacht: ",
	["seconds"] = "seconden.",
	["rob_in_prog"] = "~b~ overval gaande bij: ~b~",
	["started_to_rob"] = "~b~Je bent met de overval begonnen ",
	["do_not_move"] = ",~b~ pak de olie !",
	["alarm_triggered"] = "het alarm is afgegaan",
	["hold_pos"] = "ren weg als je alle olie hebt verzameld!",
	["robbery_complete"] = "~r~ De overval is geslaagd!~s~ ~h~ Ren weg! ",
	["robbery_complete_at"] = "~r~ De overval is succesvol geweest: ~b~",
	["min_two_police"] = "er moet tenminste zijn ~b~",
	["min_two_police2"] = " ~w~politie in de stad om te beroven.",
	["robbery_already"] = "~r~Er is al een overval aan de gang.",
	["robbery_has_ended"] = "De overval is afgelopen",
	["end"] = "~~r~De olie is beroofd!",
	["notenoughgold"] = "~r~Je hebt niet genoeg olie!",
	["copsforsell"] = "er moet tenminste zijn ~b~",
	["copsforsell2"] = " ~w~politie in de stad om te verkopen.",
	["goldsell"] = "~b~olie~r~ verkoop in uitvoering",
	["field"] = "Druk  ~b~E~b~ om ~o~verzamelen~s~ de olie",
	["collectinprogress"] = "~b~Je bent olie aan het pakken...~r~",
	["lester"] = "~b~Je hebt de olie-plantage beroofd! Ga nu naar de Olie verkoop",
	["shoesblipmap"] = "~r~olie plantage",
	["press_to_collect"] = "~r~om olie te verzamelen",
	["smash_case"] = "~r~Opgepakte olie",
	["press_to_sell"] = "~b~Druk op ~INPUT_PICKUP~ om olie te verkopen",
	["need_bag"] = "Je hebt de tas nodig! Ga naar de dichtstbijzijnde kledingwinkel.",
}
