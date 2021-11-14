extends Layout

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn1"))
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))
	$ListButton3.set_meta("callback", funcref(self, "_btn3"))

func init() -> void:
	$ListButton/HBoxContainer/Left.text = "  " + Butler.get_text("BACK_TO_GAME")
	$ListButton2/HBoxContainer/Left.text = "  " + Butler.get_text("OPTIONS")
	$ListButton3/HBoxContainer/Left.text = "  " + Butler.get_text("MAIN_MENU")

func _btn1():
	m.layer = -10
	m.set_process_input(false)
	get_tree().paused = false

func _btn2():
	m.load_layout(Res.layout_02.instance())

func _btn3():
	m.set_process_input(false)
	BackgroundLoad.load_scene("res://scenes/ui/MainMenu.tscn")
