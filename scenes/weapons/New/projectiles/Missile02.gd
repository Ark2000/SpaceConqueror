class_name Missile02 extends NProjectile

export var explosion_scale := 1.0
export var explosion_damage := 72.0

func _ready() -> void:
	$AfterburnerFlame.power = 0.8

func self_destroy():
	var p = Butler.summon_explosion_02(global_position)
	p.scale = Vector2(explosion_scale, explosion_scale)
	p.damage = explosion_damage
	p.src = host_ship
	p.collision_mask = collision_mask

	queue_free()
