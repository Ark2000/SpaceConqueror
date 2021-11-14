extends Layout

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn1"))
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))
	$ListButton3.set_meta("callback", funcref(self, "_btn3"))
	$ListButton4.set_meta("callback", funcref(self, "_btn4"))
	$ListButton5.set_meta("callback", funcref(self, "_btn5"))

func init():
	$ListButton/HBoxContainer/Left.text = "  " + Butler.get_text("CHROMATIC_ABERRATION") + ":"
	$ListButton2/HBoxContainer/Left.text = "  " + Butler.get_text("DEPTH_OF_FIELD") + ":"
	$ListButton5/HBoxContainer/Left.text = "  " + Butler.get_text("SCREEN_SHAKE") + ":"
	$ListButton4/HBoxContainer/Left.text = "  " + Butler.get_text("MOTION_BLUR") + ":"
	$ListButton3/HBoxContainer/Left.text = "  " + Butler.get_text("GO_BACK")
	
	$ListButton/HBoxContainer/Right.text = Butler.get_text(["OFF", "ON"][Config.c.options_chromatic_aberration as int]) + "  "
	$ListButton2/HBoxContainer/Right.text = Butler.get_text(["OFF", "ON"][Config.c.options_depth_of_field as int]) + "  "
	$ListButton4/HBoxContainer/Right.text = Butler.get_text(["OFF", "ON"][Config.c.options_motion_blur as int]) + "  "
	$ListButton5/HBoxContainer/Right.text = Config.c.options_screen_shake as String + "%  "

func _btn1():
	Config.c.options_chromatic_aberration = not Config.c.options_chromatic_aberration
	init()

func _btn2():
	Config.c.options_depth_of_field = not Config.c.options_depth_of_field
	init()

func _btn3():
	m.go_back()

func _btn4():
	Config.c.options_motion_blur = not Config.c.options_motion_blur
	init()

func _btn5():
	var instance = Res.layout_06.instance()
	instance.config_property_name = "options_screen_shake"
	m.load_layout(instance)

