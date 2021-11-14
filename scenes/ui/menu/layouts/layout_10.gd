extends Layout

func _ready() -> void:
	$Label.text = "HIGHEST SCORE: %d" % Config.c.highest_score
	$ListButton.set_meta("callback", funcref(self, "_btn1"))
	$ListButton5.set_meta("callback", funcref(self, "_btn5"))

func _btn1():
	m.set_process_input(false)
	BackgroundLoad.load_scene("res://scenes/survival_mode/Main.tscn")

func _btn5():
	m.go_back()
