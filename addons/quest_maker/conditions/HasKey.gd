tool
extends QuestIf

class_name HasKey

export (String) var key

func get_condition() -> bool:
	return get_quest().keys.has(key)
	
func _get_custom_name():
	return "HasKey " + key
