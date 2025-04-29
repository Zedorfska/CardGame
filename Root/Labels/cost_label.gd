extends Label

func update_label(Cost, SCPClass):
	self.set_text(str(Cost))
	if SCPClass == "Safe":
		self.set("theme_override_colors/font_color", get_tree().root.get_child(0).ColorSafe)
	elif SCPClass == "Euclid":
		self.set("theme_override_colors/font_color", get_tree().root.get_child(0).ColorEuclid)
	elif SCPClass == "Keter":
		self.set("theme_override_colors/font_color", get_tree().root.get_child(0).ColorKeter)
