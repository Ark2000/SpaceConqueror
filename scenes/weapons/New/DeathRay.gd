class_name DeathRay extends NWeapon

export var damage := 160.0
export var heat := 80.0
export var max_ammo := 10.0

onready var _a := $AnimationPlayer

var _damage:float
var _ammo:float
var _state := "_state_idle"

func set_max_ammo(m:float):
	max_ammo = m

func get_weapon_name():
	return "Death Ray"

func setup(ship:BaseShip):
	_ship = ship
	$Area2D.collision_mask = ((1 << _ship.team) ^ (-1)) << 20
	_ammo = max_ammo
	$AnimationPlayer.playback_speed = fire_rate_ratio
	heat *= fire_rate_ratio

func set_triggered(val:bool):
	_triggered = val
	if _state == "_state_idle":
		if _triggered and _ammo > 0.0:
			_state = "_state_charge"
			_a.play("phase1")
	
	if _state == "_state_charge":
		if !_triggered:
			if _a.current_animation == "":
				_state = "_state_discharge"
				Event.emit_signal("exploded", global_position, 0.66, 1000)
				_a.play("phase2")
				$Tween.interpolate_property(self, "_damage", damage, 0.0, 1.1)
				$Tween.start()
				_ammo -= 1.0
				if _ammo <= 0.0:
					emit_signal("out_of_ammo")
			else:
				_state = "_state_idle"
				_a.play("phase1", -1, -2.0)

func get_cd():
	if _a.is_playing() and _a.current_animation == "phase2":
		return _a.current_animation_length - _a.current_animation_position
	else:
		return 0.0

func get_max_cd():
	return _a.get_animation("phase2").length

func get_ammo():
	return _ammo

func get_max_ammo():
	return max_ammo

func update_weapon(delta: float) -> void:
	if has_method(_state):
		call(_state, delta)

func _ready() -> void:
	$_Indicator.queue_free()

func _physics_process(_delta: float) -> void:
	$Label.text = _a.current_animation

func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("hurt"):
		body.hurt(_damage, _ship)

func _state_charge(delta):
	if _a.is_playing():
		_ship.heat += heat * delta
	if _ship.is_overheat():
		_state = "_state_idle"
		_a.play("phase1", -1, -2.0)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "phase2":
		_state = "_state_idle"
