extends Control

var val := 0.0 setget set_val
var prev_val := 0.0

func set_val(v:float):
	val = v
	$TextureRect.rect_position.y = fposmod(val * -171.0, -1710)

func _physics_process(_delta: float) -> void:
	var diff = abs(prev_val - val)
	prev_val = val
	$TextureRect.material.set("shader_param/Intensity", min(diff * 0.01, 0.2))
