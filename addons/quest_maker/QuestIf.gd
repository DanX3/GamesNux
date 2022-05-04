tool
extends QuestNode

class_name QuestIf

func visited():
	if get_condition():
		go_to(null, get_child(0))
	
	go_to(self, _get_next_sibling())

func left():
	pass


func get_condition() -> bool:
	return true
