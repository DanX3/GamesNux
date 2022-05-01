tool
extends Node

class_name Goal

signal reached(goal)
signal failed(goal)

const savepath = 'res://addons/quest_maker/questdata/%s.tres'

export (String) var action
export (String) var display_message
export (bool) var optional = false


func _ready():
	if not Engine.editor_hint:
		set_meta("goal", true)
		name = '  ' + name

func get_status() -> Dictionary:
	return {}
	
func set_status(status) -> void:
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


enum StateLabel { UNCHECKED, ACTIVE, REACHED, FAILED }
const labels = {
	StateLabel.UNCHECKED: '  ',
	StateLabel.ACTIVE: '→ ',
	StateLabel.REACHED: '✓ ',
	StateLabel.FAILED: 'X '
}

var statelabel = StateLabel.UNCHECKED

func set_state_label(statelabel):
	name = labels[statelabel] + name.substr(2)
	self.statelabel = statelabel
