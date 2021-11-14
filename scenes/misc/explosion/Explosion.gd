extends Node2D

func _ready() -> void:
	SoundPlayer.play_sfx(Res.sfx_explosions[randi()%Res.sfx_explosions.size()], global_position)
	var e = Butler.summon_smoke(global_position)
	e.scale = Vector2(3, 3)
	$Sprite.rotation = randf() * TAU

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	queue_free()
