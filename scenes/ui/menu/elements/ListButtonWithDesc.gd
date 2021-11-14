extends Control

signal selected(obj)
signal unselected(obj)

var show_desc := false
var active setget set_active,get_active

func set_active(b:bool):
	$ListButton.set_active(b)
	
func get_active():
	return $ListButton.active

func _ready() -> void:
	set_meta("callback", funcref(self, "switch_desc"))

func set_text(s:String):
	$Desc/Label.text = s
	
func set_title(s:String):
	$ListButton/HBoxContainer/Left.text = "  " + s

func switch_desc():
	var x = $Desc.rect_size.x
	if show_desc:
		$Tween.interpolate_property($Desc, "rect_min_size", null, Vector2(x, 0), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
		emit_signal("unselected", self)
	else:
		$Tween.interpolate_property($Desc, "rect_min_size", null, Vector2(x, $Desc/Label.get_minimum_size().y), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
		emit_signal("selected", self)
	$Tween.start()
	show_desc = !show_desc
