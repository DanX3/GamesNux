extends Node

class_name Quest

signal accomplished(quest_name)

export (String) var quest_name
export (String) var display_name
export (Resource) var reward
var state = {}
var active_node_path

var current_goal: NodePath = ""
var display_messages := {}

func _ready():
	_process_goals()
	
func _process_goals():
	if current_goal.is_empty() and get_child_count() > 0:
		current_goal = get_path_to(get_child(0))
		_set_goal_active(current_goal, true)
		return
	
	var goal = get_node(current_goal) as Goal
	
	# if the goal is the last of its parent, meaning it was the last goal
	if goal.get_parent().get_child_count() == goal.get_index() + 1:
		_set_goal_active(current_goal, false)
		get_node("/root/SignalHub").emit_signal("s_string", "quest_finished", quest_name)
		get_node("/root/SignalHub").emit_signal("s_resource", "item_obtained", reward)
		emit_signal("accomplished", quest_name)
		return
	
	# there is another goal to complete
	_set_goal_active(current_goal, false)
	var next_goal = goal.get_parent().get_child(goal.get_index() + 1) as Goal
	current_goal = get_path_to(next_goal)
	_set_goal_active(current_goal, true)
	
	
func _set_goal_active(path: NodePath, active: bool) -> void:
	print(' %s goal %s' % ['+' if active else '-', str(path)])
	var goal = get_node(path) as Goal
	goal.set_active(active)
	if active:
		display_messages[path] = goal.get_display_message()
		goal.connect("reached", self, '_on_goal_reached')
	else:
		display_messages.erase(path)
		goal.disconnect("reached", self, '_on_goal_reached')

func _on_goal_reached():
	_process_goals()

func save_state():
	state['key1'] = 4
	state['key2'] = false
	var resource = QuestState.new()
	resource.state = state
	var error = ResourceSaver.save('res://QuestSystem/states/%s.tres' % quest_name, resource)
	print(error)
