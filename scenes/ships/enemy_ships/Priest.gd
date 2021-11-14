extends EnemyBaseShip

func _physics_process(_delta: float) -> void:
	pass

func before_idle():
	self.main_engine_power = 0.0
	self.side_engine_power = 0.0

func idle(_d):
	if get_first_enemy() != null:
		self.current_state = "approach"

func approach(_d):
	if get_first_enemy() == null:
		self.current_state = "idle"
		return
	var d = (get_first_enemy().global_position - global_position).length()
	if d < 1600.0 and heat == 0.0:
		self.current_state = "rotate_and_stop"
		return

	var spot = (global_position - get_first_enemy().global_position).normalized() * 800 + get_first_enemy().global_position
	var f1 = arrive(spot, 300.0)
	var f2 = seperate(nearby_allies, $Seperate/CollisionShape2D.shape.radius)
	shift_and_accelerate(f1 + f2)
	
func rotate_and_stop(_d):
	if get_first_enemy() == null:
		self.current_state = "idle"
		return
	var d = get_first_enemy().global_position - global_position
	var a = Vector2.RIGHT.rotated(rotation).angle_to(d)
	if abs(a) < 0.2:
		self.current_state = "attack"
		
	var s = linear_velocity.length()
	if s > 10.0:
		shift_and_accelerate(-linear_velocity.normalized() * s * 0.02)
	else:
		shift_and_accelerate(d.clamped(0.0001))

func before_attack():
	trigger_weapon(0, true)

func attack(_d):
	if get_first_enemy() == null or is_overheat():
		self.current_state = "idle"
		return
	var d = get_first_enemy().global_position - global_position
	shift_and_accelerate(d.clamped(0.0001))

func after_attack():
	trigger_weapon(0, false)
