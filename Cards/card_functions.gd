extends Node

var SelfPosition
var SelfOwner

var PassDamage
var TurnPlayedOn

var ParentCard

var ChildToGet
static var MainNode
static var Table
var TweenNode

var CardsPath = "res://Cards/"

var SCPNumberScene = preload("res://Root/Labels/number_label.tscn")
var HealthLabelScene = preload("res://Root/Labels/health_label.tscn")
var DamageLabelScene = preload("res://Root/Labels/damage_label.tscn")
var CostLabelScene = preload("res://Root/Labels/cost_label.tscn")
@onready var RootNode = get_tree().root.get_child(0)

var SCPNumberLabel
var HealthLabel
var DamageLabel
var CostLabel

var AsyncActivateToTriggerStatusEffects = 0.25
var AsyncTriggerStatusEffectsToLabelUpdate = 0.10

static func send_main_node(GotMainNode):
	MainNode = GotMainNode
	Table = MainNode.get_child(0).get_child(0).get_child(1).get_child(1)

func amount_of_cards_on_table_changed():
	SignalManager.amount_of_cards_on_table_changed_signal.emit()

static func turn_passed():
	pass

func attack_animation(Self, Player):
	var Offset = 1
	if Player == 2:
		Offset = -1
	Self.position.y -= 50 * Offset
	var tween = get_tree().create_tween()
	tween.tween_property(Self, "position", Vector2.ZERO, 0.25)

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

func rotation_shake_animation(Self):
	var tween1 = get_tree().create_tween()
	tween1.tween_property(Self, "rotation", 0.25, 0.1)
	await get_tree().create_timer(0.1).timeout
	var tween2 = get_tree().create_tween()
	tween2.tween_property(Self, "rotation", -0.25, 0.1)
	await get_tree().create_timer(0.1).timeout
	var tween3 = get_tree().create_tween()
	tween3.tween_property(Self, "rotation", 0.25, 0.1)
	await get_tree().create_timer(0.1).timeout
	var tween4 = get_tree().create_tween()
	tween4.tween_property(Self, "rotation", 0, 0.1)

func fade_out_animation(Self, Length):
	var tween = get_tree().create_tween()
	tween.tween_property(Self, "modulate:a", 0, Length)
	await get_tree().create_timer(1).timeout

func evaded_attack_animation(Self):
	var tween1 = get_tree().create_tween()
	tween1.tween_property(Self, "modulate:a", 0.5, 0.25)
	await get_tree().create_timer(0.25).timeout
	var tween2 = get_tree().create_tween()
	tween2.tween_property(Self, "modulate:a", 1, 0.25)

func glow_animation(Self):
	TweenNode = Self.get_child(0).get_child(0)
	TweenNode.modulate.a = 0
	TweenNode.visible = true
	var TweenNodeModAlpha1 = get_tree().create_tween()
	TweenNodeModAlpha1.tween_property(TweenNode, "modulate:a", 1, 0.5)
	await get_tree().create_timer(0.75).timeout
	var TweenNodeModAlpha2 = get_tree().create_tween()
	TweenNodeModAlpha2.tween_property(TweenNode, "modulate:a", 0, 0.5)
	await get_tree().create_timer(0.75).timeout
	TweenNode.visible = false

func trigger_status_effects(Self):
	if Self.StatusEffects.get_child_count() != 0:
		for i in range(Self.StatusEffects.get_child(0).get_child_count()):
			Self.StatusEffects.get_child(0).get_child(i).get_child(0).activate()
			await get_tree().create_timer(0.5).timeout

func add_label(Self, LabelToAdd):
	var AmountOfChildren = Self.get_child_count()
	match LabelToAdd:
		"Damage":
			Self.add_child(DamageLabelScene.instantiate())
			DamageLabel = Self.get_child(AmountOfChildren)
			DamageLabel.update_label()
		"Health":
			Self.add_child(HealthLabelScene.instantiate())
			HealthLabel = Self.get_child(AmountOfChildren)
			HealthLabel.update_label()
		"Cost":
			Self.add_child(CostLabelScene.instantiate())
			CostLabel = Self.get_child(AmountOfChildren)
			CostLabel.update_label()

func update_self_position(GotPosition):
	SelfPosition = GotPosition

func update_self_owner(GotOwner):
	SelfOwner = GotOwner

func clear_status_effect(Type):
	match Type:
		"All":
			for i in range(self.StatusEffects.get_child(0).get_child_count()):
				self.StatusEffects.get_child(0).get_child(0).get_child(0).destroy()
				await get_tree().create_timer(0.5).timeout

func take_damage_basic(Self, Damage, DamageType):
	if "HealthAmount" in Self:	# Failsafe in case card doesnt have HealthAmount for some reason
		if DamageType == "InstaKill":
			Self.destroy()
		else:
			Self.HealthAmount -= Damage
			if Self.HealthAmount <= 0:
				Self.destroy()
		Self.HealthLabel.update_label()

func basic_common_attack(CardPosition, Damage, DamageType, Player, Card):
	attack_animation(Card, Player)
	
	if Table.get_child(Player).get_child(CardPosition).get_child(0).get_child_count() != 0:
		if Table.get_child(Player).get_child(CardPosition).get_child(0).get_child(0).PassDamage != true:
			Table.get_child(Player).get_child(CardPosition).get_child(0).get_child(0).take_damage(Damage, DamageType)
		else:
			MainNode.player_take_damage(Player, Damage)
	else:
		MainNode.player_take_damage(Player, Damage)

# Default card actions
func played(Card, GotOwner, GotPosition):
	TurnPlayedOn = MainNode.Turn
	amount_of_cards_on_table_changed()
	update_self_position(GotPosition)
	update_self_owner(GotOwner)
	if Card.CardType == "Effect":
		ParentCard = self.get_parent().get_parent().get_parent().get_parent()

func take_damage(Damage, DamageTakenType):
	take_damage_basic(self, Damage, DamageTakenType)

func destroy():
	match self.CardType:
		"Unit":
			self.queue_free()
			self.get_parent().remove_child(self)
			amount_of_cards_on_table_changed()
		"Effect":
			self.get_parent().queue_free()
			#self.get_parent().get_parent().remove_child(self)
		"Spell":
			self.queue_free()
