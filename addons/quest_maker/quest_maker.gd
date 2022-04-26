tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Quest", "Node", preload("Quest.gd"), preload("icons/quest.png"))
#	add_custom_type("Goal", "Node", preload("Goal.gd"), preload("icons/goal.png"))
	add_custom_type("IntSum", "Node", preload("goals/IntSum.gd"), preload("icons/goal.png"))
	add_custom_type("FloatSum", "Node", preload("goals/FloatSum.gd"), preload("icons/goal.png"))
	add_custom_type("EmptySum", "Node", preload("goals/EmptySum.gd"), preload("icons/goal.png"))
	add_custom_type("StringEquals", "Node", preload("goals/StringEquals.gd"), preload("icons/goal.png"))
	

func _exit_tree():
	remove_custom_type("Quest")
#	remove_custom_type("Goal")
	remove_custom_type("IntSum")
	remove_custom_type("FloatSum")
	remove_custom_type("EmptySum")
	remove_custom_type("StringEquals")
