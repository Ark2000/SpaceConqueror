extends EnemyBaseShip

var state = "idle"

func _physics_process(delta: float) -> void:
	update_states(delta)
	call(state, delta)

func idle(_delta:float):
	if get_first_enemy():
		state = "chase"

func chase(_delta:float):
	if !get_first_enemy():
		state = "idle"
		return

	var d2  = (get_first_enemy().global_position - global_position).length_squared()
	if d2 < 60000:
		$AnimationPlayer.play("banzai")
		state = "wait_to_die"
		return

	#chasing player
	var f1 := seek(get_first_enemy().global_position)
	
	#keep allies at a distance
	var f2:Vector2 = seperate(nearby_allies, $Seperate/CollisionShape2D.shape.radius)

	#simple blending
	var f = f1 + f2 * 0.2

	#apply
	shift_and_accelerate(f)

func wait_to_die(_delta:float): pass

func banzai():
	trigger_weapon(0, true)
