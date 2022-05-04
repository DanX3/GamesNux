tool
extends QuestGoal

class_name OnSignal

func on_signal(args):
	go_to(self, _get_next_sibling())

func _get_custom_name() -> String:
	return "OnSignal " + signal_name
