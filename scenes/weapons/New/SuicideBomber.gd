extends NWeapon

export var damage := 160.0
export var explosion_scale := 4.0

func get_weapon_name():
	return "Suicide Bomber"

func set_triggered(val:bool) -> void:
	_triggered = val
	if !val: return

	Butler.summon_explosion_02(global_position, _ship.team, explosion_scale, damage, _ship)
	_ship.hurt(4444, self)
