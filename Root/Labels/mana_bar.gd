extends Sprite2D

func update_label(ManaAmount):
	for IsMana in 5:
		if IsMana == ManaAmount - 1:
			self.get_child(IsMana).visible = true
		else:
			self.get_child(IsMana).visible = false
