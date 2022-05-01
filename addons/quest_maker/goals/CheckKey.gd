tool
extends "res://addons/quest_maker/Goal.gd"

export (String) var quest_name
export (String) var key

func set_active(active: bool) -> void:
	var state = ResourceLoader.load(savepath % quest_name) as QuestState
	if state.keys.has(key):
		emit_signal("reached", self)
