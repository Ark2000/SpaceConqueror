extends Layout

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn"))
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))

func init() -> void:
	$ListButton/HBoxContainer/Left.text = "  " + Butler.get_text("LANGUAGE") + ":"
	$ListButton2/HBoxContainer/Left.text = "  " + Butler.get_text("GO_BACK")
	$ListButton/HBoxContainer/Right.text = Butler.get_current_language_name() + "  "

func _btn():
	m.load_layout(Res.layout_04.instance())
	Event.emit_signal("menu_load_layout", Res.layout_04.instance())

func _btn2():
	m.go_back()
