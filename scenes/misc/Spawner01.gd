extends PathFollow2D

func _on_Timer_timeout() -> void:
	var a = rotation-PI/2 + rand_range(-0.5, 0.5)
	Butler.summon_asteroid(global_position, Vector2.RIGHT.rotated(a)*300.0, 20.0)

func _physics_process(delta: float) -> void:
	unit_offset += delta * 0.01
