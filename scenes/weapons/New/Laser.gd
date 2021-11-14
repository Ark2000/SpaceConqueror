class_name Laser extends NWeapon

export var cast_speed := 2400.0
export var max_length := 700.0
export var growth_time := 0.2
export var damage := 120.0
export var max_ammo := 16.0
export var heat := 80.0
export var aim_assistance := true

onready var casting_particles := $CastingParticles2D
onready var collision_particles := $CollisionParticles2D
onready var beam_particles := $BeamParticles2D
onready var ray := $Ray
onready var fill := $FillLine2D
onready var tween := $Tween
onready var line_width: float = fill.width

var is_casting := false setget set_is_casting

var _ammo :float
var _update := false

func set_max_ammo(m:float):
	max_ammo = m

func get_weapon_name():
	return "Laser"
func setup(ship:BaseShip):
	_ship = ship
	_ammo = max_ammo
	max_ammo /= fire_rate_ratio
	_ammo = max_ammo
	damage *= fire_rate_ratio
	heat *= fire_rate_ratio
	cast_speed *= fire_rate_ratio
	growth_time *= fire_rate_ratio
	
	if !ray: yield(self, "ready")
	ray.collision_mask = ((1 << _ship.team) ^ (-1)) << 20

func set_triggered(val:bool):
	_triggered = val
	self.is_casting = val
func get_ammo():
	return _ammo
func get_max_ammo():
	return max_ammo
func get_cd():
	return 0.0
func get_max_cd():
	return 1.0
func update_weapon(delta:float):
	if !_update: return

	_ship.heat += heat * delta
	_ammo -= delta
	if _ship.is_overheat() or _ammo <= 0.0:
		self.is_casting = false
		return

	ray.cast_to = Vector2(min(max_length, ray.cast_to.x + cast_speed * delta), 0)
	cast_beam()

	#light jitter
	fill.default_color.v = 0.6 + rand_range(0.0, 0.3) * float(get_tree().get_frame()%2==0)

	if aim_assistance:
		var enemy = _ship.get_first_enemy()
		if enemy:
			var a = (enemy.global_position - global_position).angle()
			if Utils.angle_diff(a, global_rotation) < 0.2:
				global_rotation = a
		else:
			rotation = 0.0

	#do some damage
	if ray.is_colliding():
		var body = ray.get_collider()
		if body.has_method("hurt"):
			body.hurt(delta * damage, _ship)

func _ready() -> void:
	_update = false
	fill.points[1] = Vector2.ZERO
	
	$_Indicator.queue_free()
	
func set_is_casting(cast: bool) -> void:
	is_casting = cast
	$AudioStreamPlayer2D.playing = cast

	if is_casting:
		ray.cast_to = Vector2.ZERO
		fill.points[1] = ray.cast_to
		appear()
	else:
		collision_particles.emitting = false
		disappear()

	_update = is_casting
	beam_particles.emitting = is_casting
	casting_particles.emitting = is_casting


func cast_beam() -> void:
	var cast_point = ray.cast_to

	# Required, the raycast's collisions update one frame after moving otherwise, making the laser
	# overshoot the collision point.
	ray.force_raycast_update()
	if ray.is_colliding():
		cast_point = to_local(ray.get_collision_point())
		collision_particles.process_material.direction = Vector3(
			ray.get_collision_normal().x, ray.get_collision_normal().y, 0
		)

	collision_particles.emitting = ray.is_colliding()

	fill.points[1] = cast_point
	collision_particles.position = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5


func appear() -> void:
	tween.stop_all()
	tween.interpolate_property(fill, "width", 0, line_width, growth_time * 2)
	tween.start()


func disappear() -> void:
	tween.stop_all()
	tween.interpolate_property(fill, "width", fill.width, 0, growth_time)
	tween.start()
