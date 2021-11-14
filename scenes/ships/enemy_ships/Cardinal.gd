extends EnemyBaseShip

var current_drones = 0
var max_wing_drones = 3

func _on_Drones_timeout() -> void:
	if current_drones < max_wing_drones:
		current_drones += 1
		var drone = Butler.summon_enemy("Guardian", global_position + Vector2.RIGHT.rotated(randf()*TAU)*100.0)
		drone.ward = self
		var e :Line2D = Butler.summon_conn_line(drone, self)
		e.default_color = Color(1.0, 0.0, 0.0, 0.4)
		drone.team = team
		drone.connect("died", self, "_on_drone_died")

func _on_drone_died(_e) -> void:
	current_drones -= 1

func before_idle():
	trigger_weapon(0, false)

func idle(_d:float):
	if linear_velocity.length_squared() > 100.0:
		shift_and_accelerate(linear_velocity)
	else:
		self.main_engine_power = 0.0
		self.side_engine_power = 0.0

	if get_first_enemy() != null:
		self.current_state = "chase"

func before_chase():
	trigger_weapon(0, false)

func chase(_d:float):
	if get_first_enemy() == null:
		self.current_state = "idle"
		return
	shift_and_accelerate(seek(get_first_enemy().global_position))
	var d = (get_first_enemy().global_position - global_position).length()
	if d < 600.0:
		self.current_state = "try_to_stop"

func try_to_stop(_d:float):
	shift_and_accelerate(stop())
	if linear_velocity.length_squared() < 16.0 and heat == 0.0:
		self.current_state = "attack"

func before_attack():
	trigger_weapon(0, true)
	self.main_engine_power = 0.0
	self.side_engine_power = 0.5

	trigger_weapon(1, true)
	$Timer.wait_time = 1.9;$Timer.start()
	yield($Timer, "timeout")
	if get_first_enemy():
		$Weapons/DeathRay.global_rotation = (get_first_enemy().global_position - global_position).angle()
	$Timer.wait_time = 0.1;$Timer.start()
	yield($Timer, "timeout")
	trigger_weapon(1, false)

func attack(_d:float):
	if is_overheat():
		self.current_state = "idle"

func _physics_process(_delta: float) -> void:
#	$Label.text = "%.0f"%heat
#	$Label2.text = current_state
	pass
