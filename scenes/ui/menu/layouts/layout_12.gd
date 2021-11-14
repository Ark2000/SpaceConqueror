extends Layout

func _ready() -> void:
	$ListButton2.set_meta("callback", funcref(self, "_btn2"))

func init() -> void:
	$ListButton2/HBoxContainer/Left.text = "  " + Butler.get_text("GO_BACK")
	$Paragraph/Clip/RichTextLabel.bbcode_text = Butler.get_text("HELP_TEXT")
	
func _btn2():
	m.go_back()
