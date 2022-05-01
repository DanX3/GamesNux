tool
extends QuestAction

class_name AddKey

export (String) var key

func execute():
	get_quest().keys[key] = true
	print("added key %s to quest" % key)

func _get_custom_name():
	return "AddKey_" + key
