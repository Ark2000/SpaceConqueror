class_name EnemyBaseShip extends BaseShip

var current_state := "idle" setget set_current_state

func _ready() -> void:
	$Seperate.collision_mask = 1 << (team + 20)

func set_current_state(s:String):
	var before_method = "before_%s"%s
	var after_method = "after_%s"%current_state
	if has_method(after_method):
		call(after_method)
	if has_method(before_method):
		call(before_method)

	current_state = s

func idle(_delta:float):
	pass

func _physics_process(delta: float) -> void:
	update_states(delta)
	call(current_state, delta)

var nearby_allies = []

func _on_Seperate_body_entered(body: Node) -> void:
	#exclude itself
	if body == self: return
	nearby_allies.append(body)

func _on_Seperate_body_exited(body: Node) -> void:
	if body == self: return
	nearby_allies.remove(nearby_allies.find(body))
