tool
extends QuestGoal

class_name HasKey

export (String) var key

func set_goal(active: bool):
	print("quest has key %s: %s" % [key, str(get_quest().keys.has(key))])
	if get_quest().keys.has(key):
		process_next()
	else:
		set_active(false)

func _get_custom_name():
	return "HasKey_" + key
