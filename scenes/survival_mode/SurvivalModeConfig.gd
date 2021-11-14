class_name SurvivalModeConfig extends Resource

export var restricted_zone_shrinkage_speed := 14.0
export var restricted_zone_max_radius := 3000.0
export var restricted_zone_initial_radius := 2000.0
export var restricted_zone_expansion_rate := 0.8

export var survival_time_bonus := true
export var survival_time_bonus_interval := 2.0
export var survival_time_bounus_amount := 4

export var weapon_drop_interval := 400
export var weapon_drop_rate := 0.4

export var levelup_exp := [
	0,
	400,
	900,
	1500,
	2200,
	3000,
	3900,
	4900,
	6000,
	7200,
	8500,
	9900,
	11400,
	13000,
	14700,
	16500,
	18400,
	20400,
	1000000000
]

export var scores := {
	"Guardian": 10,
	"Believer": 40,
	"Martyr": 100,
	"Paladin": 150,
	"Missionary": 200,
	"Priest": 300,
	"Cardinal": 500,
}

export var weapons := [
	"Aureola",
	"DeathRay",
	"HeavyBlaster",
	"HeavyMissileSilo",
	"Laser",
	"MiniMissilePod",
	"ProtonImpactor"
]

export var enemies_spawn_rule := [
	["Believer", 1, 12, 1000, "min(8, 2 + 0.2 * n)"],
	["Martyr", 100, 120, 1000, "1"],
	["Paladin", 200, 101, 1000, "1"],
	["Missionary", 300, 40, 1000, "1"],
	["Priest", 400, 150, 1000, "1"],
	["Cardinal", 250, 150, 1000, "1"],
]
