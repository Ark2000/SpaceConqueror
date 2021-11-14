extends Camera2D

#0.0 - 1.0
var trauma = 0.0 setget set_trauma

export var focus:NodePath
export var max_offset = 40.0
export var max_angle = 0.2
export var decay = 1.0
export var damp = 0.96

var _noise = OpenSimplexNoise.new()
var _frame = 0
var _t_pos:Vector2

func set_trauma(val:float):
	trauma = clamp(val, 0.0, 1.0)

func _ready() -> void:
	_noise.seed = randi()
	_noise.octaves = 2

func _physics_process(delta: float) -> void:
	var amount = trauma * trauma
	_frame += 1
	_noise.period = 0.067 / delta
	var offsetx = _noise.get_noise_2d(_noise.seed, _frame) * amount * max_offset
	var offsety = _noise.get_noise_2d(_noise.seed * 2, _frame) * amount * max_offset
	var angle = _noise.get_noise_2d(_noise.seed * 3, _frame) * amount * max_angle
	self.trauma -= delta * decay

	_t_pos = lerp(_t_pos, get_node(focus).position, 1.0 - damp)
	position = _t_pos + Vector2(offsetx, offsety)
	rotation = angle
