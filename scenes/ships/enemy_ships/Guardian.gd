extends EnemyBaseShip

var ward :BaseShip = null

var guard_radius:float

func _ready() -> void:
	guard_radius = 200.0 + rand_range(-50.0, 50.0)

func idle(_delta:float) -> void:
	if linear_velocity.length_squared() > 100.0:
		shift_and_accelerate(-linear_velocity)
	if get_first_enemy():
		self.current_state = "battle"
		return
	if ward and !ward.is_dead():
		self.current_state = "guard"

var g := 0.0
func guard(delta:float) -> void:
	if ward.is_dead():
		self.current_state = "idle"
		return
	if get_first_enemy():
		self.current_state = "battle"
		print(get_first_enemy(), "what???")
		return
	g += max_linear_speed / (TAU * guard_radius) * delta * 6.0
	var p = ward.global_position + Vector2.RIGHT.rotated(g) * guard_radius
	shift_and_accelerate(p - global_position)

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
