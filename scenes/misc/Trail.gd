extends Line2D

var target:Node2D

func track(node):
	if is_queued_for_deletion(): return
	target = node
	if target:
		if not target.is_connected("tree_exiting", self, "_on_target_tree_exiting"):
			assert(target.connect("tree_exiting", self, "_on_target_tree_exiting") == OK)
	else:
		$Tween.interpolate_property(self, "modulate", null, Color(1.0, 1.0, 1.0, 0.0), 1.0)
		$Tween.interpolate_callback(self, 1.0, "queue_free")
		$Tween.start()
	return self 

func _on_Timer_timeout() -> void:
	$Timer2.start()

func _on_Timer2_timeout() -> void:
	if points.empty():
		queue_free()
	else:
		remove_point(0)

func _on_Timer3_timeout() -> void:
	if target != null:
		add_point(target.global_position)

func _on_target_tree_exiting():
	target = null
