extends Label

var RootNode

func _ready():
	RootNode = get_tree().root.get_child(1)

func update_label(Health, SCPClass):
	self.set_text(str(Health))
	if SCPClass == "Safe":
		self.set("theme_override_colors/font_color", RootNode.ColorSafe)
	elif SCPClass == "Euclid":
		self.set("theme_override_colors/font_color", RootNode.ColorEuclid)
	elif SCPClass == "Keter":
		self.set("theme_override_colors/font_color", RootNode.ColorKeter)
