class_name Upgrades extends Node

const upgrades := {
	"INCREASE_MAX_HP_1": {
		"prerequisites": [],
		"method": "_u_inc_max_hp_1",
		"desc": "INCREASE_MAX_HP_1_DESC"
	},
	"INCREASE_MAX_HP_3": {
		"prerequisites": ["INCREASE_MAX_HP_1"],
		"method": "_u_inc_max_hp_1",
		"desc": "INCREASE_MAX_HP_3_DESC"
	},
	"INCREASE_MAX_SHIELD_1": {
		"prerequisites": [],
		"method": "_u_inc_max_shield_1",
		"desc": "INCREASE_MAX_SHIELD_1_DESC"
	},
	"INCREASE_MAX_SHIELD_3": {
		"prerequisites": ["INCREASE_MAX_SHIELD_1"],
		"method": "_u_inc_max_shield_3",
		"desc": "INCREASE_MAX_SHIELD_3_DESC"
	},
	"INCREASE_SHIELD_RECOVERY_1": {
		"prerequisites": [],
		"method": "_u_inc_shield_recover_1",
		"desc": "INCREASE_SHIELD_RECOVERY_1_DESC"
	},
	"INCREASE_SHIELD_RECOVERY_3": {
		"prerequisites": ["INCREASE_SHIELD_RECOVERY_1"],
		"method": "_u_inc_shield_recover_1",
		"desc": "INCREASE_SHIELD_RECOVERY_3_DESC"
	},
	"INCREASE_MAX_THERMOLYSIS_1": {
		"prerequisites": [],
		"method": "_u_inc_max_thermolysis_1",
		"desc": "INCREASE_MAX_THERMOLYSIS_1_DESC"
	},
	"INCREASE_MAX_THERMOLYSIS_3": {
		"prerequisites": ["INCREASE_MAX_THERMOLYSIS_1"],
		"method": "_u_inc_max_thermolysis_3",
		"desc": "INCREASE_MAX_THERMOLYSIS_3_DESC"
	},
	"INCREASE_COOLING_RATE_1": {
		"prerequisites": [],
		"method": "_u_inc_cooling_rate_1",
		"desc": "INCREASE_COOLING_RATE_1_DESC"
	},
	"INCREASE_COOLING_RATE_3": {
		"prerequisites": ["INCREASE_COOLING_RATE_1"],
		"method": "_u_inc_cooling_rate_3",
		"desc": "INCREASE_COOLING_RATE_3_DESC"
	},
	"SELF_REPAIR_1": {
		"prerequisites": [],
		"method": "_u_self_repair_1",
		"desc": "SELF_REPAIR_1_DESC"
	},
	"SELF_REPAIR_3": {
		"prerequisites": ["SELF_REPAIR_1"],
		"method": "_u_self_repair_3",
		"desc": "SELF_REPAIR_3_DESC"
	},
	"INCREASE_TORQUE_1": {
		"prerequisites": [],
		"method": "_u_inc_max_torque_1",
		"desc": "INCREASE_TORQUE_1_DESC"
	},
	"INCREASE_TORQUE_3": {
		"prerequisites": ["INCREASE_TORQUE_1"],
		"method": "_u_inc_max_torque_3",
		"desc": "INCREASE_TORQUE_3_DESC"
	},
	"INCREASE_THRUST_1": {
		"prerequisites": [],
		"method": "_u_inc_max_thrust_1",
		"desc": "INCREASE_THRUST_1_DESC"
	},
	"INCREASE_THRUST_3": {
		"prerequisites": ["INCREASE_THRUST_1"],
		"method": "_u_inc_max_thrust_3",
		"desc": "INCREASE_THRUST_3_DESC"
	},
	"INCREASE_WEAPON_DROP_CHANCE": {
		"prerequisites": [],
		"method": "_u_inc_weapon_drop_chance",
		"desc": "INCREASE_WEAPON_DROP_CHANCE_DESC"
	},
	"MORE_OPTIONS": {
		"prerequisites": [],
		"method": "_u_more_options",
		"desc": "MORE_OPTIONS_DESC"
	},
	"MORE_AMMO": {
		"prerequisites": [],
		"method": "_u_more_ammo",
		"desc": "MORE_AMMO_DESC"
	},
	"VAMPIRE": {
		"prerequisites": [],
		"method": "_u_vampire",
		"desc": "VAMPIRE_DESC"
	},
	"INFECTIOUS": {
		"prerequisites": [],
		"method": "_u_infectious",
		"desc": "INFECTIOUS_DESC"
	},
	"NECROMANCY": {
		"prerequisites": [],
		"method": "_u_necromancy",
		"desc": "NECROMANCY_DESC"
	},
	"FLASH": {
		"prerequisites": [],
		"method": "_u_flash",
		"desc": "FLASH_DESC"
	}
}

var player: BaseShip
var configs: SurvivalModeConfig

var max_options := 3
var self_repair_rate := 0.0
var hemophagia_rate := 0.0
var infection_rate := 0.0
var weapon_max_ammo_ratio := 1.0
var weapon_fire_rate_ratio := 1.0

var unused_options = {}

func _init() -> void:
	for k in upgrades.keys():
		unused_options[k] = 0
		
func _ready() -> void:
	assert(Event.connect("hurt", self, "_on_ship_hurt") == OK)

func get_available_options() -> Array:
	var availables_options = []
	var all_options = unused_options.keys()
	all_options.shuffle()
	for o in all_options:
		if availables_options.size() == max_options:
			break
		var flag = true
		for p in upgrades[o].prerequisites:
			if unused_options.has(p):
				flag = false
				break
		if !flag: continue
		availables_options.append({
			"title":Butler.get_text(o),
			"text":Butler.get_text(upgrades[o].desc),
			"method":funcref(self, upgrades[o].method)
		})
	return availables_options

func _physics_process(delta: float) -> void:
	player.hp += player.max_hp * self_repair_rate * delta

func _on_ship_hurt(attacker, _sufferer, val:float):
	if attacker is Object and attacker == player:
		player.hp += val * hemophagia_rate

func _u_inc_max_hp_1():
	unused_options.erase("INCREASE_MAX_HP_1")
	player.max_hp = 150
	player.hp = 150

func _u_inc_max_hp_3():
	unused_options.erase("INCREASE_MAX_HP_3")
	player.max_hp = 300
	player.hp = 300

func _u_inc_max_shield_1():
	unused_options.erase("INCREASE_MAX_SHIELD_1")
	player.max_shield = 150
	player.shield = 150

func _u_inc_max_shield_3():
	unused_options.erase("INCREASE_MAX_SHIELD_3")	
	player.max_shield = 300
	player.shield = 300

func _u_inc_shield_recover_1():
	unused_options.erase("INCREASE_SHIELD_RECOVERY_1")
	player.shield_recover_rate = 30

func _u_inc_shield_recover_3():
	unused_options.erase("INCREASE_SHIELD_RECOVERY_3")
	player.shield_recover_rate = 50

func _u_inc_max_thermolysis_1():
	unused_options.erase("INCREASE_MAX_THERMOLYSIS_1")
	player.max_heat = 150

func _u_inc_max_thermolysis_3():
	unused_options.erase("INCREASE_MAX_THERMOLYSIS_3")
	player.max_heat = 300

func _u_inc_cooling_rate_1():
	unused_options.erase("INCREASE_COOLING_RATE_1")
	player.heat_cooldown_rate = 40

func _u_inc_cooling_rate_3():
	unused_options.erase("INCREASE_COOLING_RATE_3")
	player.heat_cooldown_rate = 50

func _u_self_repair_1():
	unused_options.erase("SELF_REPAIR_1")
	self_repair_rate = 0.01

func _u_self_repair_3():
	unused_options.erase("SELF_REPAIR_3")
	self_repair_rate = 0.02

func _u_inc_max_torque_1():
	unused_options.erase("INCREASE_TORQUE_1")
	player.max_torque = 80

func _u_inc_max_torque_3():
	unused_options.erase("INCREASE_TORQUE_3")
	player.max_torque = 120

func _u_inc_max_thrust_1():
	unused_options.erase("INCREASE_THRUST_1")
	player.max_thrust = 320

func _u_inc_max_thrust_3():
	unused_options.erase("INCREASE_THRUST_3")
	player.max_thrust = 480

func _u_inc_weapon_drop_chance():
	unused_options.erase("INCREASE_WEAPON_DROP_CHANCE")
	configs.weapon_drop_rate = 0.7

func _u_more_options():
	unused_options.erase("MORE_OPTIONS")
	max_options = 5
	
func _u_flash():
	unused_options.erase("FLASH")
	weapon_fire_rate_ratio = 1.5

func _u_more_ammo():
	unused_options.erase("MORE_AMMO")
	weapon_max_ammo_ratio = 2.0

func _u_necromancy():
	unused_options.erase("NECROMANCY")
	player.max_wing_drones = 2

func _u_vampire():
	unused_options.erase("VAMPIRE")
	hemophagia_rate = 0.01

func _u_infectious():
	unused_options.erase("INFECTIOUS")
	infection_rate = 0.2
