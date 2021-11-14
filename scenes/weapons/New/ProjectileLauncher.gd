class_name ProjectileLauncher extends NWeapon

const projectiles_lib_path = "res://scenes/weapons/New/projectiles/"

export var weapon_name := "Blaster"
export var projectile_code := "Pulse02"

export var aim_assistance := false
export var max_cd := 0.5
export var burst_cd := 0.0
export var burst := 1
export var heat := 35.0
export var max_error := 0.05
export var max_ammo := 200.0

var _ammo :float
var _max_cd := max_cd
var _cd := 0.0
var _counter := 0
var _projectile:PackedScene

var p_initial_speed
var p_acceleration

func set_max_ammo(m:float):
	max_ammo = m

func get_weapon_info() -> Dictionary:
	var wi = .get_weapon_info()
	wi["projectile_initial_speed"] = p_initial_speed
	wi["projectile_acceleration"] = p_acceleration
	return wi

func get_weapon_name():
	return weapon_name

func setup(ship:BaseShip):
	_ship = ship
	_ammo = max_ammo
	$_Indicator.queue_free()
	_projectile = load(projectiles_lib_path + projectile_code + ".tscn")
	
	var p =  _projectile.instance()
	p_initial_speed = p.initial_speed
	p_acceleration = p.acceleration
	p.queue_free()
	
	max_cd /= fire_rate_ratio
	burst_cd /= fire_rate_ratio
	
func get_ammo():
	return _ammo
	
func get_max_ammo():
	return max_ammo
	
func get_cd():
	return _cd
	
func get_max_cd():
	return _max_cd

func update_weapon(delta:float):
	if _cd > 0.0: 
		_cd -= delta
		return

	if !_triggered or _ammo <= 0.0 or _ship.is_overheat(): 
		return
		

	var p = _projectile.instance()
	p.position = global_position
	p.rotation = global_rotation
	if aim_assistance and _ship.get_first_enemy():
		var dir = Utils.aim_predict(_ship.get_first_enemy().position, _ship.get_first_enemy().linear_velocity - _ship.linear_velocity, p.position, p.initial_speed, p.acceleration).angle()
		if Utils.angle_diff(dir, p.rotation) < 0.2:
			p.rotation = dir
	p.rotation += rand_range(-max_error, max_error)
	p.velocity = Vector2.RIGHT.rotated(p.rotation) * p.initial_speed + _ship.linear_velocity
	p.set_collision_masks((((1 << _ship.team) ^ (-1)) << 20) + 2)
	p.host_ship = _ship
	get_tree().current_scene.call_deferred("add_child", p)
	
	$Spark.rotation = rand_range(0, TAU)
	$AnimationPlayer.play("fire")

	_ship.heat += heat
	_ammo -= 1
	if _ammo <= 0.0:
		emit_signal("out_of_ammo")
	
	_counter += 1
	var a = (_counter % burst == 0) as int
	_max_cd = lerp(max_cd, burst_cd + max_cd, a)
	_cd += _max_cd
