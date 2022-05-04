tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Quest", "Node", preload("Quest.gd"), preload("icons/quest.png"))
	add_custom_type("QuestNode", "Node", preload("QuestNode.gd"), null)
	add_custom_type("QuestGoal", "Node", preload("QuestGoal.gd"), preload("icons/condition.png"))
	add_custom_type("QuestAction", "Node", preload("QuestAction.gd"), preload("icons/action.png"))
	add_custom_type("IntSum", "Node", preload("old_goals/IntSum.gd"), preload("icons/condition.png"))
#	add_custom_type("FloatSum", "Node", preload("old_goals/FloatSum.gd"), preload("icons/condition.png"))
#	add_custom_type("EmptySum", "Node", preload("old_goals/EmptySum.gd"), preload("icons/condition.png"))
#	add_custom_type("StringEquals", "Node", preload("old_goals/StringEquals.gd"), preload("icons/condition.png"))
#	add_custom_type("CheckKey", "Node", preload("old_goals/CheckKey.gd"), preload("icons/condition.png"))
	
#	add_custom_type("FailQuest", "Node", preload("actions/FailQuest.gd"), preload("icons/action.png"))
	

func _exit_tree():
	remove_custom_type("Quest")
	remove_custom_type("QuestNode")
	remove_custom_type("QuestGoal")
	remove_custom_type("IntSum")
#	remove_custom_type("FloatSum")
#	remove_custom_type("EmptySum")
#	remove_custom_type("StringEquals")
#	remove_custom_type("CheckKey")
