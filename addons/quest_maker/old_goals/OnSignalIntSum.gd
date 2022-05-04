tool
extends QuestGoal

class_name OnSignalIntSum

export (String) var signal__name
export (int) var amount

var counter = 0

func set_goal(active: bool) -> void:
#	print_stack()
	print("set OnSignal active: ", active)
	if active:
		get_node("/root/SignalHub").connect("s_int", self, "_on_signal")
	else:
		get_node("/root/SignalHub").disconnect("s_int", self, "_on_signal")
	
func _on_signal(action, i):
	counter += i
	if counter >= amount:
		process_next()

func _get_custom_name() -> String:
	return "OnSignal " + signal__name + "x" + str(amount)
