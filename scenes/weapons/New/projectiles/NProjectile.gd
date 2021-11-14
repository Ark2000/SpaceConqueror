class_name NProjectile extends Area2D

export var initial_speed := 800.0
export var acceleration := 0.0
export var max_speed := 1200.0
export var life := 1.0
export var damage := 10.0
export var penetrable := false

export var homing := false
export var homing_max_angular_velocity := 0.8

export var fire_sound := ""

var host_ship:BaseShip = null
var homing_target:BaseShip
var velocity :Vector2

func set_collision_masks(m:int):
	collision_mask = m
	$RayCast2D.collision_mask = m

func _ready() -> void:
	assert(connect("body_entered", self, "_on_body_entered") == OK)
	assert($Timer.connect("timeout", self, "_on_Timer_timeout") == OK)
	$Timer.wait_time = life
	$Timer.start()
	if fire_sound != "":
		SoundPlayer.play_sfx(Res.get(fire_sound), global_position)

func _physics_process(delta: float) -> void:
	position += velocity * delta
	velocity += Vector2.RIGHT.rotated(rotation) * acceleration * delta
	velocity = velocity.clamped(max_speed)
	
	if homing:
		if is_instance_valid(homing_target) and !homing_target.is_dead():
			var dir = homing_target.global_position - global_position
			var diff = Utils.angle_diff(global_rotation, dir.angle()) 
			var r = sign(diff) * min(homing_max_angular_velocity * delta, abs(diff))
			velocity = velocity.rotated(r)
			global_rotation += r
		else:
			if host_ship and host_ship.get_first_enemy():
				homing_target = host_ship.get_first_enemy()
			else:
				homing_target = null

func _on_Timer_timeout() -> void:
	self_destroy()

func self_destroy():
	queue_free()

func _on_body_entered(body: Node) -> void:
	if body.has_method("hurt"): body.hurt(damage, host_ship)
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		var point = $RayCast2D.get_collision_point()
		Butler.summon_spark(point)
	if penetrable: return
	self_destroy()
