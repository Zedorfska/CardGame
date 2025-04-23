extends Node2D

var MaxHealth = 5
var Health = 5
var Damage = 5
var AttackType = 0

func _ready():
	var DamageDisplay = $DamageDisplay
	var HealthDisplay = $HealthDisplay

	DamageDisplay.set_text(str(Damage))
	HealthDisplay.set_text(str(Health))
