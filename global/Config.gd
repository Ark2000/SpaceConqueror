extends Node

const file_path = "user://config.tres"

var c:ConfigRes

func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	#load configs
	c = load(file_path)
	if !c: c = ConfigRes.new()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		#save configs
		assert(ResourceSaver.save(file_path, c) == OK)
		get_tree().quit()
