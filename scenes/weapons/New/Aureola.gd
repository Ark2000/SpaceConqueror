extends NWeapon

export var damage = 60.0
export var radius = 60.0
export var max_ammo := 20.0
export var max_cd := 1.0
export var heat := 40.0

var _ammo:float
var _enabled := false
var _cd:float = 0.0

var _targets = []

func set_max_ammo(m:float):
	max_ammo = m

func get_weapon_name():
	return "Aureola"

func setup(ship:BaseShip):
	_ship = ship
	_ammo = max_ammo
	var s = radius / 26.0
	$Area2D.scale = Vector2(s, s)
	$Area2D.collision_mask = (((1 << _ship.team) ^ (-1)) << 20)
	
	$AnimationPlayer.playback_speed = fire_rate_ratio
	max_ammo /= fire_rate_ratio
	_ammo = max_ammo
	heat *= fire_rate_ratio
	max_cd /= fire_rate_ratio
	
func set_triggered(val:bool) -> void:
	_triggered = val
	if val:
		if !_ship.is_overheat() and _ammo >= 0.0 and _cd <= 0.0:
			set_enabled(true)
	else:
		set_enabled(false)

func get_ammo() -> float:
	return _ammo
	
func get_max_ammo() -> float:
	return max_ammo

func get_cd() -> float:
	return _cd

func get_max_cd() -> float:
	return max_cd
	
func update_weapon(delta:float) -> void:
	_cd = max(0.0, _cd - delta)
	if _enabled:
		for t in _targets:
			if !t.has_method("hurt"): continue
			t.hurt(damage * delta, _ship)
		
		_ship.heat += heat * delta
		_ammo -= delta

		if _ship.is_overheat():
			set_enabled(false)
		if _ammo <= 0.0:
			set_enabled(false)
			emit_signal("out_of_ammo")

func set_enabled(val:bool):
	if val == _enabled: return
	_enabled = val
	$AnimationPlayer.play(["end", "start"][val as int])
	if !val: _cd = max_cd
	
func _on_Area2D_body_entered(body: Node) -> void:
	_targets.append(body)

func _on_Area2D_body_exited(body: Node) -> void:
	_targets.remove(_targets.find(body))
