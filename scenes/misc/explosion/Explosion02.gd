extends Area2D

var src
var damage = 100.0

onready var radius = $CollisionShape2D.shape.radius * scale.x

func _ready() -> void:
	SoundPlayer.play_sfx(Res.sfx_explosions2[randi()%Res.sfx_explosions2.size()], global_position)
	Butler.summon_smoke(global_position)

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	queue_free()

func _on_Explosion02_body_entered(body) -> void:
	var d2 = (body.global_position - global_position).length_squared()
	var f = 1.0 - d2 / (radius * radius)
	if body.has_method("hurt"):
		body.hurt(f * damage, src)
