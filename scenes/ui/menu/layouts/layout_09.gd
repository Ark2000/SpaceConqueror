extends Layout

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn1"))
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))

func init() -> void:
	$ListButton/HBoxContainer/Left.text = "  " + Butler.get_text("VIBRATIONS") + ":"
	$ListButton2/HBoxContainer/Left.text = "  " + Butler.get_text("GO_BACK")
	
	$ListButton/HBoxContainer/Right.text = Butler.get_text(["OFF", "ON"][Config.c.options_vibrations as int]) + "  "

func _btn1():
	Config.c.options_vibrations = not Config.c.options_vibrations
	init()
	
func _btn2():
	m.go_back()
