extends AudioStreamPlayer

func play_bgm(bgm):
	if stream == bgm: return
	$Tween.stop_all()
	$Tween.interpolate_property(self, "volume_db", null, -80.0, 2.0)
	$Tween.interpolate_callback(self, 2.0, "set", "stream", bgm)
	$Tween.interpolate_callback(self, 2.1, "set", "playing", true)
	$Tween.interpolate_property(self, "volume_db", null, 0.0, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN, 2.0)
	$Tween.start()
	
func play_sfx(sfx, position):
	var p = Res.sound.instance()
	p.stream = sfx
	p.bus = "SFX-BATTLE"
	p.position = position
	get_tree().current_scene.call_deferred("add_child", p)
