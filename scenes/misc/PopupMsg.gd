extends Label

var _pos:Vector2
var _t:float

func init(text:String, pos:Vector2, t := 1.0, color := Color.white):
	set_text(text)
	_pos = pos
	_t = t
	self_modulate = color
	return self

func _ready() -> void:
	yield(get_tree(), "idle_frame")
	rect_global_position = _pos - rect_size / 2
	$Tween.interpolate_property(self, "rect_position", null, rect_position - Vector2(0.0, 100.0), _t)
	$Tween.interpolate_property(self, "modulate", null, Color.transparent, _t / 2, Tween.TRANS_LINEAR, Tween.EASE_IN, _t / 2)
	$Tween.interpolate_callback(self, _t, "queue_free")
	$Tween.start()
