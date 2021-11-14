class_name BaseShip extends RigidBody2D

signal hp_changed(hp, max_hp)
signal shield_changed(shield, max_shield)
signal heat_changed(heat, max_heat)
signal died(obj)

export var code_name := "Unknown"
export var max_hp := 100.0
export var max_shield := 100.0
export var max_heat := 100.0
export var shield_recover_rate := 20.0
export var shield_recover_delay := 2.0
export var heat_cooldown_rate := 30.0
export var max_linear_speed := 300.0
export var max_thrust := 100.0
export var max_torque := 60.0
export var collision_force_threshold := 300.0
export var collision_resistance_multiplier := 1.0
export var collision_damage_multiplier := 1.0
export var team := 0
export var death_bloom_size := 2.0
const team_colors = [Color("#00CC00"), Color("#FF4040"), Color.green]
#var angular_damp = 10.0	#do not change this
#var bounce = 0.2
#var mass = 0.1

var hp :float setget set_hp
var shield :float setget set_shield
var heat := 0.0 setget set_heat

var main_engine_power := 0.0 setget set_main_engine_power
var side_engine_power := 0.0 setget set_side_engine_power

var _detected_enemies = []

var _last_frame_linear_velocity := linear_velocity

var _damage_recorder := {}
var _afterburners = []

class DamageRecord:
	const default_delay = 0.1
	var delay:float
	var dmg:float
	func _to_string(): return "<%f, %f>" % [delay, dmg]

func _ready() -> void:
	self.hp = max_hp
	self.shield = max_shield
	
	assert(team < 12)
	collision_layer = 1 + (1 << (20 + team))
	$EnemyDetector.collision_mask = ((1 << team) ^ (-1)) << 20

	var col = team_colors[team]
	col.a = 0.2
	$SPrite/Chartlet.material.set("shader_param/line_color", col)
	$SPrite/Chartlet.material.set("shader_param/line_multiplier", 1)

	for w in $Weapons.get_children():
		w.setup(self)
		
	Event.emit_signal("spawned", self)
	
func trigger_weapon(id:int, state:bool):
	for w in $Weapons.get_children():
		if w.weapon_id == id:
			w.set_triggered(state)
			
func get_weapon_info(id:int) -> Array:
	var a = []
	for w in $Weapons.get_children():
		if w.weapon_id == id:
			a.append(w.get_weapon_info())
	return a

#0.0 ~ 1.0, basic behavior
func set_main_engine_power(val:float):
	main_engine_power = clamp(val, 0.0, 1.0)
	set_applied_force(Vector2.RIGHT.rotated(rotation) * max_thrust * main_engine_power)
	_update_afterburners(val)

#-1.0 ~ 1.0
func set_side_engine_power(val:float):
	side_engine_power = clamp(val, -1.0, 1.0)
	set_applied_torque(max_torque * 50.0 * side_engine_power)

func shift_to(direction:Vector2):
	var a = Vector2.RIGHT.rotated(rotation).angle_to(direction)
	self.side_engine_power = sign(a) if abs(a) > 0.5 else a * 2.0

#length: 0.0 ~ 1.0
func shift_and_accelerate(force:Vector2):
	if force == Vector2.ZERO:
		self.main_engine_power = 0.0
		self.side_engine_power = 0.0
		return

	force = force.clamped(1.0)
	var a = Vector2.RIGHT.rotated(rotation).angle_to(force)
	self.main_engine_power = (0.2-abs(a))*(force.length()*5.0) if abs(a) < 0.2 else 0.0
	self.side_engine_power = sign(a) if abs(a)>0.5 else a*2.0

func seek(pos:Vector2) -> Vector2:
	return (pos - global_position).normalized()
	
func seperate(allies:Array, radius:float) -> Vector2:
	var f2 := Vector2.ZERO
	for a in allies:
		var v :Vector2 = global_position - a.global_position
		f2 += v.normalized() * (radius / v.length())
	return f2

func stop() -> Vector2:
	return -linear_velocity * 0.02

func arrive(pos:Vector2, slow_radius:float) -> Vector2:
	var v = pos - global_position
	var d = v.length()
	var target_velocity = max_linear_speed * v.normalized()
	if d < slow_radius:
		target_velocity *= (d / slow_radius)
	var diff = target_velocity - linear_velocity
	
	return diff * 0.01;

################################################
func update_states(delta: float) -> void:
	for w in $Weapons.get_children():
		w.update_weapon(delta)

	if $ShieldRecoverDelayTimer.is_stopped():
		self.shield = min(max_shield, shield + shield_recover_rate * delta)

	self.heat = max(0.0, self.heat - heat_cooldown_rate * delta)
	
	_last_frame_linear_velocity = linear_velocity

	for k in _damage_recorder.keys():
		var v :DamageRecord = _damage_recorder[k]
		v.delay -= delta
		if v.delay <= 0.0:
			Butler.summon_popup_msg().init("%.0f"%v.dmg, global_position + Vector2(rand_range(-20.0, 20.0), rand_range(-20.0, 20.0)), 1.5, team_colors[team])
# warning-ignore:return_value_discarded
			_damage_recorder.erase(k)

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	state.linear_velocity = state.linear_velocity.clamped(max_linear_speed)

func _update_afterburners(val:float) -> void:
	for c in $Afterburners.get_children():
		c.set_power(val)

func set_hp(val:float):
	val = clamp(val, 0.0, max_hp)
	if val == hp: return
	hp = val
	emit_signal("hp_changed", hp, max_hp)

	if hp <= 0.0:
		var dmg := 0.0
		for k in _damage_recorder.keys():
			dmg += _damage_recorder[k].dmg
		Butler.summon_popup_msg().init("%.0f"%dmg, global_position + Vector2(rand_range(-20.0, 20.0), rand_range(-20.0, 20.0)), 1.5, team_colors[team])

		Event.emit_signal("died", self)
		emit_signal("died", self)

func after_died():
	collision_layer = 0
	collision_mask = 0
	set_physics_process(false)
	set_process(false)
	set_process_input(false)
	set_process_unhandled_input(false)

	for c in get_children():
		if not (c.name in ["SPrite", "Animation"]):
			c.queue_free()

	for c in $SPrite/Chartlet.get_children():
		if c.has_method("set_light_mask"):
			c.set_light_mask(2)

	$SPrite/Chartlet.modulate = Color(0.2, 0.2, 0.2)
	$SPrite/CrackMask.show()
	$SPrite/Chartlet.material = null
	$Animation.play("fade_away")
	
	burst_into_bloom()

func burst_into_bloom():
	var e = Butler.summon_explosion(global_position)
	e.scale = Vector2(death_bloom_size, death_bloom_size)

func on_fade_away_animation_finished():
	queue_free()
	print("queue free %s" % name)

func set_shield(val:float):
	val = clamp(val, 0.0, max_shield)
	if val == shield: return

	if val > shield:
		if shield <= 0.0:
			$Animation.play("recover")
		if val == max_shield:
			$Animation.play("full")
	if val < shield:
		if val <= 0.0:
			$Animation.play("break")
		else:
			$Animation.stop()
			$Animation.play("shield")

	shield = val
	emit_signal("shield_changed", shield, max_shield)

func set_heat(val:float):
	val = max(0.0, val)
	if val == heat: return
	#overheat penalty
	if val > max_heat and val > heat:
		heat = max(heat, max_heat + heat_cooldown_rate * 2.0)
	else:
		heat = val

	emit_signal("heat_changed", heat, max_heat)

func is_overheat() -> bool:
	return heat > max_heat
	
func get_one_enemy_in_sight():
	return null
	
func get_collision_damage_multiplier():
	return collision_damage_multiplier

func get_team():
	return team

func is_dead():
	return hp <= 0.0

func hurt(dmg:float, src=null):
	if is_dead(): return
	if dmg <= 0.0: return
	
	if src == null: src = "unknown"
	Event.emit_signal("hurt", src, self, min(dmg, hp + shield))

	if !_damage_recorder.has(src):
		_damage_recorder[src] = DamageRecord.new()
	var r:DamageRecord = _damage_recorder[src]
	r.dmg += dmg
	r.delay = DamageRecord.default_delay

	$ShieldRecoverDelayTimer.start(shield_recover_delay)

	self.hp -= max(0.0, dmg - shield)
	self.shield -= min(shield, dmg)
	if hp <= 0.0: after_died()

func get_random_enemy():
	if _detected_enemies.empty(): return null
	return _detected_enemies[randi() % _detected_enemies.size()]

func get_first_enemy():
	if _detected_enemies.empty(): return null
	return _detected_enemies[0]

#collision damage
func _on_BaseShip_body_entered(body: Node) -> void:
	if body.has_method("get_team") and body.get_team() == team:
		return

	var a = (linear_velocity - _last_frame_linear_velocity).length()
	var dmg = int(a > collision_force_threshold) * (a - collision_force_threshold)
	dmg *= collision_resistance_multiplier
	dmg *= 1.0 if !body.has_method("get_collision_damage_multiplier") else body.get_collision_damage_multiplier()
	hurt(dmg, body)


func _on_EnemyDetector_body_entered(body: Node) -> void:
	_detected_enemies.append(body)

func _on_EnemyDetector_body_exited(body: Node) -> void:
	_detected_enemies.remove(_detected_enemies.find(body))
