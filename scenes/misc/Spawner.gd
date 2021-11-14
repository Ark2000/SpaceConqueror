extends Node

export var parent_node:NodePath
export var code_name := "Believer"
export var start_time := 5.0
export var interval_time := 10.0
export var waves := 10
export var formula := "1"

var n := 0

var e := Expression.new()

func set_paused(b:bool):
	if has_node("Timer"):
		$Timer.paused = b
		$Timer2.paused = b

func _ready() -> void:
	Event.connect("stop_spawning", self, "_on_stop_spawning")
	Event.connect("start_spawning", self, "_on_start_spawning")
	$Timer.wait_time = start_time
	$Timer2.wait_time = interval_time
	$Timer.start()
	assert(e.parse(formula, ["n"]) == OK)

func _on_stop_spawning():
	set_paused(true)

func _on_start_spawning():
	set_paused(false)

func _on_Timer_timeout() -> void:
	$Timer2.start()
	_on_Timer2_timeout()
	$Timer.queue_free()

func _on_Timer2_timeout() -> void:
	var t = int(e.execute([n]))
	for i in t:
		Butler.summon_enemy(code_name, Vector2.RIGHT.rotated(randf() * TAU) * 4000.0, null if !parent_node else get_node(parent_node))
		print("SPAWN %s, t = %d"%[code_name, start_time + interval_time * n])
	n += 1
	if n == waves:
		queue_free()
