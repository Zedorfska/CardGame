extends Label

func update_label(Health, SCPClass):
	self.set_text(str(Health))
	if SCPClass == "Safe":
		self.set("theme_override_colors/font_color", get_tree().root.get_child(1).ColorSafe)
	elif SCPClass == "Euclid":
		self.set("theme_override_colors/font_color", get_tree().root.get_child(1).ColorEuclid)
	elif SCPClass == "Keter":
		self.set("theme_override_colors/font_color", get_tree().root.get_child(1).ColorKeter)
