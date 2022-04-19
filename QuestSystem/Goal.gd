extends Node

class_name Goal
signal reached
enum SignalType {EMPTY, INT, FLOAT, STRING}

export (String) var action

func _get_status() -> Dictionary:
	return {}
	
func _set_status(status) -> void:
	return

func set_active(active: bool) -> void:
	return

func get_display_message():
	return '<DISPLAY MESSAGE>'
