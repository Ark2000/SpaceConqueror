extends Control

export var damp = 0.2

var number := 0
var nodes = []

func _ready() -> void:
	for c in get_children():
		if c.has_method("set_val"):
			nodes.append(c)

func _physics_process(_delta: float) -> void:
	for i in nodes.size():
		# warning-ignore:integer_division
		var n := number / int(pow(10, i))
		nodes[i].val = lerp(nodes[i].val, n, damp)
