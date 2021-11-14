extends Layout

var btn = preload("res://scenes/ui/menu/elements/ListButtonWithDesc.tscn")
var se = preload("res://scenes/ui/menu/elements/Separator.tscn")

var options = []
var current_option

func _ready() -> void:
	$ListButton.set_meta("callback", funcref(self, "_btn3"))

#a[0] text/title
func set_content(a:Array):
	var c = get_child(2)
	while c != $S:
		if c.is_connected("selected", self, "_on_option_selected"):
			c.disconnect("selected", self, "_on_option_selected")
			c.disconnect("unselected", self, "_on_option_unselected")
		c.queue_free()
	options.clear()
	
	for k in a:
		var b = btn.instance()
		b.set_text(k.text)
		b.set_title(k.title)
		b.set_meta("upgrade_callback", k.method)
		b.connect("selected", self, "_on_option_selected")
		b.connect("unselected", self, "_on_option_unselected")
		add_child_below_node($TopPlaceHolder, se.instance())
		add_child_below_node($TopPlaceHolder, b)
		options.append(b)

func _on_option_selected(o):
	if current_option:
		current_option.switch_desc()
	current_option = o

func _on_option_unselected(o):
	if o == current_option:
		current_option = null

func init() -> void:
	$ListButton/HBoxContainer/Left.text = "  " + Butler.get_text("CONFIRM")

func _btn3():
	if !current_option: return
	
	current_option.get_meta("upgrade_callback").call_func()

	m.layer = -10
	m.set_process_input(false)
	get_tree().paused = false
