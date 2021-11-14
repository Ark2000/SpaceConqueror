extends Node

signal player_exited
signal player_entered
var player_inside := true

func _physics_process(_delta: float) -> void:
	var player = get_node("../Player")
	var radius = get_node("../RestrictedZone").radius

	if player and !player.is_dead():
		var d = player.position.length_squared()
		if d > radius * radius and player_inside:
			player_inside = false
			emit_signal("player_exited")
		elif d < radius * radius and !player_inside:
			player_inside = true
			emit_signal("player_entered")
