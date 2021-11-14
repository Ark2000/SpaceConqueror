class_name MenuUI extends CanvasLayer

var _layouts_stack = []
var _elements = []
var _cur_ele := 0

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		select_prev()
		return
	if Input.is_action_just_pressed("ui_down"):
		select_next()
		return
	if Input.is_action_just_pressed("ui_accept"):
		confirm()
		return
	if Input.is_action_just_pressed("ui_cancel"):
		go_back()

func _on_layout_ready():
	set_process_input(true)

func load_layout(layout:Node, clear_history := false):
	if clear_history:
		for l in _layouts_stack:
			l.queue_free()
		_layouts_stack.clear()
	
	var old_layout = null
	if $ScrollContainer.has_node("LayoutContainer"):
		old_layout = $ScrollContainer.get_node("LayoutContainer")
		$ScrollContainer.remove_child(old_layout)
	if clear_history:
		old_layout = null

	if layout.has_method("init"): 
		layout.m = self
		layout.init()
	$ScrollContainer.call_deferred("add_child", layout)
	layout.request_ready()
	set_process_input(false)
	if !layout.is_connected("ready", self, "set_process_input"):
		assert(layout.connect("ready", self, "set_process_input", [true])==OK)

	_elements.clear()
	_cur_ele = 0
	var i := 0
	for c in layout.get_children():
		if c.has_method("set_active") and c.visible:
			_elements.push_back(c)
			if c.active: _cur_ele = i
			i += 1

	_elements[_cur_ele].call_deferred("set_active", true)

	if !_layouts_stack.empty() and _layouts_stack.back() == layout:
		_layouts_stack.pop_back()
		if old_layout: old_layout.queue_free()
	else:
		if old_layout:
			_layouts_stack.push_back(old_layout)

func _select(new_ele:int):
	if _elements.empty(): return
	if new_ele != _cur_ele:
		_elements[new_ele].call("set_active", true)
		_elements[_cur_ele].call("set_active", false)
		_cur_ele = new_ele

func select_prev():
	_select(_elements.size() - 1 if (_cur_ele == 0) else _cur_ele - 1)

func select_next():
	_select(0 if (_cur_ele == _elements.size() - 1) else _cur_ele + 1)

func confirm():

	if _elements.empty(): return
	_elements[_cur_ele].get_meta("callback").call_func()

func go_back():
	if _layouts_stack.empty(): return
	load_layout(_layouts_stack.back())

func _on_MenuUI_tree_exiting() -> void:
	for l in _layouts_stack:
		l.queue_free()
