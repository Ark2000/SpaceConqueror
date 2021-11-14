extends Node

func _ready() -> void:
	print("[GAME START]")
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(preload("res://scenes/ui/Intro.tscn"))
