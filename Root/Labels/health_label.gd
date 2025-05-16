extends Label

var RootNode

func _ready():
	RootNode = get_tree().root.get_child(1)

func update_label():
	self.set_text(str(get_parent().HealthAmount))
	match get_parent().ContainmentClass:
		"Safe":
			self.set("theme_override_colors/font_color", RootNode.ColorSafe)
		"Euclid":
			self.set("theme_override_colors/font_color", RootNode.ColorEuclid)
		"Keter":
			self.set("theme_override_colors/font_color", RootNode.ColorKeter)
