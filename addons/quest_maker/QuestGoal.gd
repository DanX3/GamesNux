tool
extends QuestNode

class_name QuestGoal

export (bool) var optional = false

func visited():
	set_active(true)
	set_goal(true)
	if optional and not _is_node_last():
		var next_node = get_parent().get_child(get_index() + 1)
		process_add(next_node)


func left():
	set_active(false)
	set_goal(false)

# this should setup the node in order to call the process_next() when the condition is met
func set_goal(active: bool):
	pass
