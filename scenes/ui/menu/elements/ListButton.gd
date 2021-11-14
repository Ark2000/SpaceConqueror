extends Control

var active := false setget set_active

const text = ["OFF  ", "ON  "]

const colors = [Color(0.6, 0.6, 0.6, 0.9), Color(0.0, 0.0, 0.0, 0.9)]
const colors2 = [Color(0.1, 0.1, 0.1, 1.0), Color(0.9, 0.9, 0.9, 0.9)]

func _ready() -> void:
	set_active(false)
	request_ready()

func set_active(b:bool):
	active = b
	$HBoxContainer/Left.set("custom_colors/font_color", colors2[b as int])
	$HBoxContainer/Right.set("custom_colors/font_color", colors2[b as int])
	
	$Tween.stop_all()
	$Tween.interpolate_property($ColorRect2, "anchor_right", null, [0.0, 1.0][b as int], 0.2, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween.interpolate_property($ColorRect3, "margin_right", null, [0.0, 8.0][b as int], 0.2, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween.start()

func _on_ListButton_tree_exiting() -> void:
	pass
