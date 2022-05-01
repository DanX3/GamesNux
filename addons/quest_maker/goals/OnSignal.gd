extends QuestGoal

class_name OnSignal

export (String) var signal_name

func set_goal(active: bool) -> void:
#	print_stack()
	print("set OnSignal active: ", active)
	if active:
		get_node("/root/SignalHub").connect("s_empty", self, "_on_signal", [], CONNECT_ONESHOT)
	
func _on_signal(action):
	process_next()

func _get_custom_name() -> String:
	return ("[Opt]" if optional else "") + "OnSignal_" + signal_name
