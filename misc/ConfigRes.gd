class_name ConfigRes extends Resource

export var options_language := "en"

export var options_sound_effect_volume := 100 setget set_options_sound_effect_volume
export var options_music_volume := 100 setget set_options_music_volume 
export var options_overall_volume := 100 setget set_options_overall_volume

export var options_chromatic_aberration := true
export var options_depth_of_field := true
export var options_motion_blur := true
export var options_screen_shake := 50

export var options_vibrations := true

export var options_skip_opening_animation := false

export var highest_score := 0

func set_options_overall_volume(val:int):
	options_overall_volume = val
	set_bus_volume("Master", val)

func set_options_music_volume(val:int):
	options_music_volume = val
	set_bus_volume("BGM", val)

func set_options_sound_effect_volume(val:int):
	options_sound_effect_volume = val
	set_bus_volume("SFX", val)

func set_bus_volume(bus_name:String, val:int):
	if val > 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), (100-val) /100.0 * -40)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), true)
