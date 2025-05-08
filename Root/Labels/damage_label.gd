extends Label

func update_label(Damage, SCPClass):
	self.set_text(str(Damage))
	match SCPClass:
		"Safe":
			self.set("theme_override_colors/font_color", get_tree().root.get_child(1).ColorSafe)
		"Euclid":
			self.set("theme_override_colors/font_color", get_tree().root.get_child(1).ColorEuclid)
		"Keter":
			self.set("theme_override_colors/font_color", get_tree().root.get_child(1).ColorKeter)
