class_name NWeapon extends Node2D

# warning-ignore:unused_signal
signal out_of_ammo()

export var weapon_id := 0

var fire_rate_ratio := 1.0

var _ship:BaseShip
var _triggered:bool

func setup(ship:BaseShip):
	_ship = ship

func set_triggered(val:bool) -> void:
	_triggered = val

func get_weapon_name() -> String:
	return "???"
	
func get_ammo() -> float:
	return 0.0
	
func get_max_ammo() -> float:
	return 1.0
	
func set_max_ammo(_m:float) -> void:
	return
	
func get_cd() -> float:
	return 0.0
	
func get_max_cd() -> float:
	return 1.0

func update_weapon(_delta:float) -> void:
	pass

func get_weapon_info() -> Dictionary:
	var wi = {}
	wi["weapon_name"] = get_weapon_name()
	wi["ammo"] = get_ammo()
	wi["max_ammo"] = get_max_ammo()
	wi["cd"] = get_cd()
	wi["max_cd"] = get_max_cd()
	return wi
