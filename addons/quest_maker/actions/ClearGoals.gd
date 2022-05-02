tool
extends QuestAction

class_name ClearGoals

func execute():
	for child in get_quest().get_children():
		_disable_goals(child)

func _disable_goals(node: QuestNode):
	if node is QuestGoal and node.active:
		node.left()
	
	for child in get_children():
		_disable_goals(child)
