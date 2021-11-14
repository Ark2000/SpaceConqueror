extends Layout

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn1"))
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))
	$ListButton3.set_meta("callback", funcref(self, "_btn3"))
	$ListButton4.set_meta("callback", funcref(self, "_btn4"))
	$ListButton5.set_meta("callback", funcref(self, "_btn5"))
	$ListButton6.set_meta("callback", funcref(self, "_btn6"))

func init():
	$ListButton5/HBoxContainer/Left.text = "  " + Butler.get_text("GO_BACK")

func _btn1():
	Config.c.options_language = "en"
	m.go_back()

func _btn2():
	Config.c.options_language = "ru"
	m.go_back()

func _btn3():
	Config.c.options_language = "zh-CN"
	m.go_back()

func _btn4():
	Config.c.options_language = "zh-HK"
	m.go_back()
	
func _btn5():
	m.go_back()
	
func _btn6():
	Config.c.options_language = "ja"
	m.go_back()
