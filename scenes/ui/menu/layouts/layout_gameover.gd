extends Layout

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn1"))

func init() -> void:
	$ListButton/HBoxContainer/Left.text = "  " + Butler.get_text("MAIN_MENU")

func _btn1():
	m.set_process_input(false)
	BackgroundLoad.load_scene("res://scenes/ui/MainMenu.tscn")

func set_content(score:int):
	$Label2.text = "SCORE : %d" % score
