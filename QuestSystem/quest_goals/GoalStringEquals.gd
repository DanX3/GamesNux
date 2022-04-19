extends "res://QuestSystem/Goal.gd"

class_name GoalStringEquals

export (String) var string_value
export (String) var display_message\

func set_active(active: bool) -> void:
	if active:
		get_node("/root/SignalHub").connect("s_string", self, '_on_HUB_signal')
	else:
		get_node("/root/SignalHub").disconnect("s_string", self, '_on_HUB_signal')


func _on_HUB_signal(action, s):
	if self.action == action and s == string_value:
		emit_signal("reached")


func _get_display_message():
	if display_message.find("%s") != -1:
		return display_message % string_value.capitalize()
	else:
		return display_message
