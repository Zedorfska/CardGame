extends Node2D

func update_label():
	for i in 5:
		if i == get_parent().CostAmount - 1:
			self.get_child(i).visible = true
		else:
			self.get_child(i).visible = false
