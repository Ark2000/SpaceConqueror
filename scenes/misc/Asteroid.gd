extends RigidBody2D

var impluse:Vector2

func _ready() -> void:
	apply_impulse(Vector2.ZERO, impluse)

func _on_Timer_timeout() -> void:
	queue_free()
