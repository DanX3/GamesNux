tool
extends QuestNode

class_name QuestAction

func visited():
	execute()
	go_to(self, _get_next_sibling())
#	process_next()

func execute():
	pass
