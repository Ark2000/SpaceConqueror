tool
extends Sprite

export var radius = 2560 setget set_radius


func set_radius(val:float):
	radius = clamp(val, 0.0, 12800)
	material.set("shader_param/radius", radius / 12800)
