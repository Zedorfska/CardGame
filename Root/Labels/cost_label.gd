extends Node2D

func update_label(Cost):
	for i in 5:
		if i == Cost - 1:
			self.get_child(i).visible = true
		else:
			self.get_child(i).visible = false
