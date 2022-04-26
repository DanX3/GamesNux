tool
extends "res://addons/quest_maker/Goal.gd"

export (String) var value

func set_active(active: bool) -> void:
	if active:
		get_node("/root/SignalHub").connect("s_string", self, '_on_HUB_signal')
	else:
		get_node("/root/SignalHub").disconnect("s_string", self, '_on_HUB_signal')


func _on_HUB_signal(action, s):
	if self.action == action and s == value:
		emit_signal("reached", self)


func get_formatter():
	return "%s"

func get_value():
	return value
