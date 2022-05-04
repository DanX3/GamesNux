tool
extends QuestAction

class_name RemoveKey

export (String) var key

func execute():
	get_quest().keys.erase(key)

func _get_custom_name():
	return "-Key " + key
