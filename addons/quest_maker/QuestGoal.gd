tool
extends QuestNode

class_name QuestGoal

#export (bool) var optional = false
#export (bool) var exclusive = false
export (String) var signal_name

func visited():
	set_active(true)
	EventBus.connect_user_signal(signal_name, [], self, "on_signal")
#	if optional and not _is_node_last():
#		var next_node = get_parent().get_child(get_index() + 1)
#		process_next(false)
##		process_add(next_node)
#	set_goal(true)


func left():
	set_active(false)
#	go_to(self, _get_next_sibling())
#	set_goal(false)
#	if exclusive:
#		get_quest().clear_goals()

# this should setup the node in order to call the process_next() when the condition is met
#func set_goal(active: bool):
#	pass

func on_signal(args):
	pass
