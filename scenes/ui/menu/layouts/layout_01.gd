extends Layout

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn1"))
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))
	$ListButton3.set_meta("callback", funcref(self, "_btn3"))
	$ListButton4.set_meta("callback", funcref(self, "_btn4"))

func init() -> void:
	$ListButton/HBoxContainer/Left.text = "  " + Butler.get_text("PLAY")
	$ListButton2/HBoxContainer/Left.text = "  " + Butler.get_text("OPTIONS")
	$ListButton3/HBoxContainer/Left.text = "  " + Butler.get_text("CREDITS")
	$ListButton4/HBoxContainer/Left.text = "  " + Butler.get_text("HELP")

func _btn1():
	m.load_layout(Res.layout_10.instance())

func _btn2():
	m.load_layout(Res.layout_02.instance())

func _btn3():
	m.load_layout(Res.layout_07.instance())
	
func _btn4():
	m.load_layout(Res.layout_12.instance())

func _input(_e) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func set_content(score:int):
	$Label2.text = "SCORE : %d" % score
