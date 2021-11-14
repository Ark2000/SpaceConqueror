extends Control

func _ready() -> void:
	$MenuUI.load_layout(Res.layout_01.instance())
	get_tree().paused = false
	SoundPlayer.play_bgm(Res.bgm_01)
