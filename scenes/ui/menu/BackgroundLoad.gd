extends CanvasLayer

const SIMULATED_DELAY_SEC = 0.05

var thread = null

onready var progress = $Progress

func _thread_load(path):
	var ril = ResourceLoader.load_interactive(path)
	assert(ril)
	var total = ril.get_stage_count()

	var res = null

	while true: #iterate until we have a resource
		# Update progress bar, use call deferred, which routes to main thread.
		progress.set_deferred("value", 100.0 * ril.get_stage() / total)
		# Simulate a delay.
		OS.delay_msec(int(SIMULATED_DELAY_SEC * 1000.0))
		# Poll (does a load step).
		var err = ril.poll()
		# If OK, then load another one. If EOF, it' s done. Otherwise there was an error.
		if err == ERR_FILE_EOF:
			# Loading done, fetch resource.
			res = ril.get_resource()
			break
		elif err != OK:
			# Not OK, there was an error.
			print("There was an error loading")
			break

	# Send whathever we did (or did not) get.
	call_deferred("_thread_done", res)

func _thread_done(resource):
	assert(resource)
	
	# Always wait for threads to finish, this is required on Windows.
	thread.wait_to_finish()

	# Hide the progress bar.
	layer = -1

	assert(get_tree().change_scene_to(resource) == OK)

func load_scene(path):
	layer = 11
	progress.value = 0.0
	thread = Thread.new()
	thread.start( self, "_thread_load", path)
