extends HBoxContainer

onready var clip = $Clip
onready var label = $Clip/RichTextLabel
onready var scroll = $VScrollBar

func _ready() -> void:
	scroll.hide()
	if label.get_minimum_size().y >= clip.rect_size.y:
		scroll.show()
		scroll.page = 100.0 * clip.rect_size.y / label.get_minimum_size().y 

func _on_VScrollBar_value_changed(value: float) -> void:
	label.rect_position.y = -range_lerp(value, 0.0, 100.0 - scroll.page, 0.0, label.get_minimum_size().y - clip.rect_size.y)

var increment = 0.0
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		increment = -40.0
	if Input.is_action_pressed("ui_down"):
		increment = 40.0

	scroll.value += delta * increment
	increment *= 0.8
