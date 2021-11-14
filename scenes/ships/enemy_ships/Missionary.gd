extends EnemyBaseShip

func idle(_d):
	if get_first_enemy() != null:
		self.current_state = "harass"

var harass_spot:Vector2
func before_harass():
	var d :Vector2 = global_position - get_first_enemy().global_position
	d = d.rotated(1.0)
	harass_spot = d.normalized() * 600.0 + get_first_enemy().global_position

func harass(_d):
	if get_first_enemy() == null:
		self.current_state = "idle"
		return
	
	var dlen = (global_position - harass_spot).length()
	var d2len = (harass_spot - get_first_enemy().global_position).length()
	
	if d2len > 800.0 or d2len < 400.0 or dlen < 10.0:
		self.current_state = "harass"
		return
	
	var d3len = (global_position - get_first_enemy().global_position).length()
	
	if get_weapon_info(0)[0].cd <= 0.0 and d3len < 1000.0:
		self.current_state = "attack"
		return

	var f1 = seek(harass_spot)
	var f2 = seperate(nearby_allies, $Seperate/CollisionShape2D.shape.radius)

	shift_and_accelerate(f1 + f2)

func attack(_d):
	if get_first_enemy() == null:
		self.current_state = "idle"
		return
	
	#Adjust the fire angle
	var dir := Utils.aim_predict(get_first_enemy().global_position, get_first_enemy().linear_velocity - linear_velocity, global_position, get_weapon_info(0)[0]["projectile_initial_speed"], get_weapon_info(0)[0]["projectile_acceleration"])
	
	if abs(Vector2.RIGHT.rotated(rotation).angle_to(dir)) < 0.05:
		trigger_weapon(0, true)
		self.current_state = "idle"
		$Timer.start()

	shift_and_accelerate(dir.clamped(0.0001))

func _on_Timer_timeout() -> void:
	trigger_weapon(0, false)

func _physics_process(_delta: float) -> void:
#	$Label.text = current_state
	pass
