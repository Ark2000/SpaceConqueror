extends EnemyBaseShip

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

	var spot = (global_position - get_first_enemy().global_position).normalized() * 400 + get_first_enemy().global_position
	var f1 = arrive(spot, 200.0)
	var f2 = seperate(nearby_allies, $Seperate/CollisionShape2D.shape.radius)
	shift_and_accelerate(f1 + f2)
	
	var d = (get_first_enemy().global_position - global_position).length()
	if d < 1600.0 and $WaitTimer.is_stopped():
		self.current_state = "charge"


var charge_direction = Vector2.ZERO
func before_charge():
	$Tween.stop_all()
	$Tween.interpolate_property(self, "max_linear_speed", null, max_linear_speed * 3.0, 0.5)
	$Tween.start()
	$ChargeTimer.wait_time = 3.0
	$ChargeTimer.start()
	charge_direction = Utils.aim_predict(get_first_enemy().global_position, get_first_enemy().linear_velocity, global_position, max_linear_speed * 2.8).rotated(rand_range(-0.05, 0.05))
	trigger_weapon(0, true)

func charge(_d):
	shift_and_accelerate(charge_direction)
	if $ChargeTimer.is_stopped() or get_first_enemy() == null:
		self.current_state = "idle"

func after_charge():
	$Tween.stop_all()
	$Tween.interpolate_property(self, "max_linear_speed", null, max_linear_speed / 3.0, 0.5)
	$Tween.start()
	$WaitTimer.wait_time = 5.0
	$WaitTimer.start()
	trigger_weapon(0, false)

func _physics_process(_delta: float) -> void:
	$Label.text = current_state
	$Label2.text = "%.1f"%$WaitTimer.time_left
	$Label3.text = "%.1f"%$ChargeTimer.time_left
