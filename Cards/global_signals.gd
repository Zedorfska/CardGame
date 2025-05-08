extends Node

signal amount_of_cards_on_table_changed_signal

func amount_of_cards_on_table_changed():
	emit_signal("amount_of_cards_on_table_changed_signal")
