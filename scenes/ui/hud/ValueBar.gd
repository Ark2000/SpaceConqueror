extends PanelContainer

export var flicker := true

var value:int = 0 setget set_value
var max_value:int = 100 setget set_max_value

onready var l = $ProgressBar/HBoxContainer/Label
onready var p = $ProgressBar

func set_value(v:int):
	value = v
	l.text = v as String
	$Tween.stop_all()
	$Tween.interpolate_property(p, "value", null, v * 100.0 / max_value, 0.2, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween.start()
	
	if flicker:
		$AnimationPlayer.play("flicker" if value > max_value else "idle")

func set_max_value(v:int):
	max_value = v
	rect_size.x = v * 2.5
