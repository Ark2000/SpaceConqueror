extends Control

func _ready() -> void:
	SoundPlayer.play_bgm(Res.bgm_01)

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(preload("res://scenes/ui/MainMenu.tscn"))
