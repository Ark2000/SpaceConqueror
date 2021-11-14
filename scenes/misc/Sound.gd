extends AudioStreamPlayer2D

func _on_Sound_finished() -> void:
	queue_free()
