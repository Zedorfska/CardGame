extends Node

var AsyncActivateToTriggerStatusEffects = 0.75

func cant_activate_animation(Self):
	var Position = Vector2.ZERO
	Position.x -= 10
	var tween1 = get_tree().create_tween()
	tween1.tween_property(Self, "position", Position, 0.1)
	await get_tree().create_timer(0.1).timeout
	Position.x += 20
	var tween2 = get_tree().create_tween()
	tween2.tween_property(Self, "position", Position, 0.1)
	await get_tree().create_timer(0.1).timeout
	Position.x -= 20
	var tween3 = get_tree().create_tween()
	tween3.tween_property(Self, "position", Position, 0.1)
	await get_tree().create_timer(0.1).timeout
	Position.x += 10
	var tween4 = get_tree().create_tween()
	tween4.tween_property(Self, "position", Position, 0.1)

func trigger_status_effects(Self):
	if Self.StatusEffects.get_child_count() != 0:
		for i in range(Self.StatusEffects.get_child_count()):
			Self.StatusEffects.get_child(i).activate()
