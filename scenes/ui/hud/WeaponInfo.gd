extends PanelContainer

var highlight :bool setget set_highlight
var title :String setget set_title
var progress1 :float setget set_progress1
var progress2 :float setget set_progress2

func _ready() -> void:
	set("custom_styles/panel", get("custom_styles/panel").duplicate())

func set_highlight(val:bool):
	highlight = val
	var p = get("custom_styles/panel")
	if val:
		p.set("border_width_left", 2)
	else:
		p.set("border_width_left", 0)

func set_title(s:String):
	title = s
	$VBoxContainer/HBoxContainer/Label.text = s
	
	var v = (s != "NULL")
	$VBoxContainer/ProgressBar.visible = v
	$VBoxContainer/ProgressBar2.visible = v

func set_progress1(v:float):
	progress1 = v
	$VBoxContainer/ProgressBar.value = (1.0 - v) * 100.0
	
func set_progress2(v:float):
	progress2 = v
	$VBoxContainer/ProgressBar2.value = (1.0 - v) * 100.0
