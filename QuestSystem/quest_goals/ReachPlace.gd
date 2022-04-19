extends "res://QuestSystem/Goal.gd"

class_name ReachPlace

export (String) var place

func set_active(active: bool) -> void:
	if active:
		get_node("/root/SignalHub").connect("s_string", self, '_on_HUB_signal')
	else:
		get_node("/root/SignalHub").disconnect("s_string", self, '_on_HUB_signal')


func _on_HUB_signal(action, s):
	if action == 'arrived_at' and s == place:
		emit_signal("reached")


func _get_display_message():
	return 'Arrive at the %s' %  place.capitalize()
