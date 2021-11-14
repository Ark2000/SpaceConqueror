extends CanvasLayer

#title/highlight/progress1/progress2
onready var w1 = $Control/W1
onready var w2 = $Control/W2
onready var w3 = $Control/W3

#value/max_value
onready var v1 = $Control/V1
onready var v2 = $Control/V2
onready var v3 = $Control/V3

#number
onready var s = $Control/Number

func set_skull_value(v:float):
	var value = range_lerp(v, 0.0, 1.0, 0.954,0.108)
	$Control/TextureRect.material.set("shader_param/p", value)

func set_level(v:int):
	$Control/Label.text = "LV.%d"%v
