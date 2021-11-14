extends Layout

#need to change this
var config_property_name = "_dummy"

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn1"))
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))
	$ListButton3.set_meta("callback", funcref(self, "_btn3"))
	$ListButton4.set_meta("callback", funcref(self, "_btn4"))
	$ListButton5.set_meta("callback", funcref(self, "_btn5"))
	$ListButton6.set_meta("callback", funcref(self, "_btn6"))
	$ListButton7.set_meta("callback", funcref(self, "_btn7"))
	$ListButton8.set_meta("callback", funcref(self, "_btn8"))
	$ListButton9.set_meta("callback", funcref(self, "_btn9"))
	$ListButton10.set_meta("callback", funcref(self, "_btn10"))
	$ListButton11.set_meta("callback", funcref(self, "_btn11"))
	$ListButton12.set_meta("callback", funcref(self, "_btn12"))

func init():
	$ListButton5/HBoxContainer/Left.text = "  " + Butler.get_text("GO_BACK")

func _btn1():
	Config.c.set(config_property_name, 0)
	m.go_back()

func _btn2():
	Config.c.set(config_property_name, 10)
	m.go_back()

func _btn3():
	Config.c.set(config_property_name, 20)
	m.go_back()

func _btn4():
	Config.c.set(config_property_name, 30)
	m.go_back()

func _btn5():
	m.go_back()

func _btn6():
	Config.c.set(config_property_name, 40)
	m.go_back()

func _btn7():
	Config.c.set(config_property_name, 50)
	m.go_back()

func _btn8():
	Config.c.set(config_property_name, 60)
	m.go_back()

func _btn9():
	Config.c.set(config_property_name, 70)
	m.go_back()

func _btn10():
	Config.c.set(config_property_name, 80)
	m.go_back()

func _btn11():
	Config.c.set(config_property_name, 90)
	m.go_back()

func _btn12():
	Config.c.set(config_property_name, 100)
	m.go_back()
