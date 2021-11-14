extends Node2D

var power := 1.0 setget set_power

var trail = null

const damp = 0.1

onready var au = $AudioStreamPlayer2D

func set_power(val:float):
	if val == power: return
	power = val

	if val > 0.0 and !trail:
		trail = Butler.summon_trail().track(self)
	elif val <= 0.0 and trail:
		trail.track(null)
		trail = null

func _physics_process(_delta: float) -> void:
	var v = clamp(power * 2.0, 0.0, 2.0)
	modulate.r = lerp(modulate.r, v, damp)
	modulate.g = modulate.r
	modulate.b = modulate.r
	modulate.a = modulate.r
	au.volume_db = lerp(au.volume_db, v*25.0-50.0, damp)
	au.pitch_scale = lerp(au.pitch_scale, range_lerp(v, 0.0, 2.0, 0.1, 0.2), damp)
