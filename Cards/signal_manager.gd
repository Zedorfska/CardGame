extends Node

signal amount_of_cards_on_table_changed_signal
signal card_played_signal

func amount_of_cards_on_table_changed():
	amount_of_cards_on_table_changed_signal.emit()

func card_played():
	card_played_signal.emit()
