extends Layout

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn1"))
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))
	$ListButton3.set_meta("callback", funcref(self, "_btn3"))
	$ListButton4.set_meta("callback", funcref(self, "_btn4"))

func init():
	$ListButton/HBoxContainer/Left.text = "  " + Butler.get_text("SOUND_EFFECTS_VOLUME") + ":"
	$ListButton2/HBoxContainer/Left.text = "  " + Butler.get_text("MUSIC_VOLUME") + ":"
	$ListButton3/HBoxContainer/Left.text = "  " + Butler.get_text("GO_BACK")
	$ListButton/HBoxContainer/Right.text = Config.c.options_sound_effect_volume as String + "%  "
	$ListButton2/HBoxContainer/Right.text = Config.c.options_music_volume as String + "%  "
	$ListButton4/HBoxContainer/Right.text = Config.c.options_overall_volume as String + "%  "

func _btn1():
	var instance = Res.layout_06.instance()
	instance.config_property_name = "options_sound_effect_volume"
	m.load_layout(instance)

func _btn2():
	var instance = Res.layout_06.instance()
	instance.config_property_name = "options_music_volume"
	m.load_layout(instance)

func _btn4():
	var instance = Res.layout_06.instance()
	instance.config_property_name = "options_overall_volume"
	m.load_layout(instance)

func _btn3():
	m.go_back()
