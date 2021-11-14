extends Layout

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn1"))
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))

func init() -> void:
	$ListButton/HBoxContainer/Right.text = Butler.get_text(["OFF", "ON"][Config.c.options_skip_opening_animation as int]) + "  "

func _btn1():
	Config.c.options_skip_opening_animation = !Config.c.options_skip_opening_animation
	init()

func _btn2():
	m.go_back()
