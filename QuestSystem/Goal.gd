extends Node

class_name Goal

signal reached(goal)

export (String) var display_message
export (String) var action
export (bool) var optional = false
export (bool) var fails_quest = false

func _get_status() -> Dictionary:
	return {}
	
func _set_status(status) -> void:
	return

func set_active(active: bool) -> void:
	return

func get_display_message():
	if display_message.find(get_formatter()) != -1:
		return display_message % get_value()
	else:
		return display_message

func get_formatter():
	return "%s"

func get_value():
	return null
