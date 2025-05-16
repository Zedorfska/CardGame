extends Label

func update_label(SCPClass):
	self.set_text(str(get_parent().SCPNumber))
	if SCPClass == "Safe":
		self.set("theme_override_colors/font_color", get_tree().root.get_child(1).ColorSafe)
	elif SCPClass == "Euclid":
		self.set("theme_override_colors/font_color", get_tree().root.get_child(1).ColorEuclid)
	elif SCPClass == "Keter":
		self.set("theme_override_colors/font_color", get_tree().root.get_child(1).ColorKeter)
