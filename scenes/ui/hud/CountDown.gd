extends Control

signal countdown_is_over

var _number = 3
var is_active = false

func start():
	show()
	is_active = true
	_number = 3
	$Label.text = _number as String
	$Timer.start()
	
func stop():
	hide()
	is_active = false
	$Timer.stop()


func _on_Timer_timeout() -> void:
	_number -= 1
	$Label.text = _number as String
	if _number == 0:
		emit_signal("countdown_is_over")
		$Timer.stop()
