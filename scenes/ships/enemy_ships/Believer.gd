extends EnemyBaseShip

var _max_linear_speed:float

func _ready() -> void:
	max_linear_speed -= randf() * 40
	max_torque -= randf() * 20.0
	max_thrust -= randf() * 30.0
	_max_linear_speed = max_linear_speed

func _physics_process(_delta: float) -> void:
	max_linear_speed = min(_max_linear_speed + 20 * nearby_allies.size(), 400)

func idle(_delta:float) -> void:
	if linear_velocity.length_squared() > 100.0:
		shift_and_accelerate(linear_velocity)
	if get_first_enemy():
		self.current_state = "battle"

func before_idle() -> void:
	trigger_weapon(0, false)

func battle(_delta:float) -> void:
	if !get_first_enemy():
		self.current_state = "idle"
		return

	#fire if close enough
	trigger_weapon(0, (get_first_enemy().global_position - global_position).length() < 200.0)

	#chasing player
	var f1 := seek(get_first_enemy().global_position)
	
	#keep allies at a distance
	var f2:Vector2 = seperate(nearby_allies, $Seperate/CollisionShape2D.shape.radius)

	#simple blending
	var f = f1 + f2 * 0.5

	#apply
	shift_and_accelerate(f)
