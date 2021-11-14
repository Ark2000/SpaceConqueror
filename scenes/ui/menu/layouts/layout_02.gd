extends Layout

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn1"))
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))
	$ListButton3.set_meta("callback", funcref(self, "_btn3"))
	$ListButton4.set_meta("callback", funcref(self, "_btn4"))
	$ListButton5.set_meta("callback", funcref(self, "_btn5"))
	$ListButton6.set_meta("callback", funcref(self, "_btn6"))

func init() -> void:
	$ListButton/HBoxContainer/Left.text = "  " + Butler.get_text("GRAPHICS")
	$ListButton2/HBoxContainer/Left.text = "  " + Butler.get_text("AUDIO")
	$ListButton3/HBoxContainer/Left.text = "  " + Butler.get_text("CONTROLS")
	$ListButton4/HBoxContainer/Left.text = "  " + Butler.get_text("LANGUAGE")
	$ListButton5/HBoxContainer/Left.text = "  " + Butler.get_text("GO_BACK")
	$ListButton6/HBoxContainer/Left.text = "  " + Butler.get_text("MISC")

func _btn1():
	m.load_layout(Res.layout_08.instance())

func _btn2():
	m.load_layout(Res.layout_05.instance())

func _btn3():
	m.load_layout(Res.layout_09.instance())

func _btn4():
	m.load_layout(Res.layout_03.instance())

func _btn5():
	m.go_back()

func _btn6():
	m.load_layout(Res.layout_11.instance())
