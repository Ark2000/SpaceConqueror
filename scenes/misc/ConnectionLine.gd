extends Line2D

var start:BaseShip
var end:BaseShip

func _ready() -> void:
	assert(start.connect("died", self, "_on_ship_die") == OK)
	assert(end.connect("died", self, "_on_ship_die") == OK)

func _physics_process(_delta: float) -> void:
	set_point_position(0, start.global_position)
	set_point_position(1, end.global_position)

func _on_ship_die(_e):
	queue_free()
