extends Node

signal amount_of_cards_on_table_changed_signal

func amount_of_cards_on_table_changed():
	amount_of_cards_on_table_changed_signal.emit()
