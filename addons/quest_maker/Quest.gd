tool
extends Node

signal accomplished(quest_name)
signal failed(quest_name)
signal goal_added
signal goal_removed

export (String) var quest_name
export (String) var display_name
export (Resource) var reward
var active_node_path

var goals = []
var display_messages := {}

func _ready():
	_process_goals(null)
	
func _process_goals(goal_reached: Goal):
	# starts processing the first goal
	if goal_reached == null and get_child_count() > 0:
		_chain_activation(get_child(0))
		return
		
	if not (goal_reached is Goal):
		printerr("Goal passed %s is not of Goal type" % goal_reached.name)
	
	# disables the reached goal
	_set_goal_active(goal_reached, false)
	goals.erase(goal_reached)
	
	# check if mission is failed
	if goal_reached.fails_quest:
		_clear_goals()
		emit_signal("failed", quest_name)
		get_node("/root/SignalHub").emit_signal("s_string", "quest_failed", quest_name)
		return
	
	# accomplish the mission if it was the last node in its parent
	if _is_node_last(goal_reached) and goal_reached.get_child_count() == 0:
		_clear_goals()
		get_node("/root/SignalHub").emit_signal("s_string", "quest_finished", quest_name)
		get_node("/root/SignalHub").emit_signal("s_resource", "item_obtained", reward)
		emit_signal("accomplished", quest_name)
		return
	
	# if the goal has children, disable all goals and start tracking its children
	if goal_reached.get_child_count() > 0:
		if goal_reached.clear_goals:
			_clear_goals()
		_chain_activation(goal_reached.get_child(0))
		return
	
	if not goal_reached.optional:
		var next_goal = goal_reached.get_parent().get_child(goal_reached.get_index() + 1) as Goal
		_chain_activation(next_goal)
		
	print("#active goals: %d" % len(goals))
	

func _clear_goals():
	for g in goals:
		_set_goal_active(g, false)
	goals.clear()

func _chain_activation(goal: Goal):
	goals.append(goal)
	_set_goal_active(goal, true)
	if goal.optional and not _is_node_last(goal):
		_chain_activation(_next_node(goal))

func _is_node_last(node: Node) -> bool:
	return (node.get_index() + 1) == node.get_parent().get_child_count()

func _next_node(node: Node) -> Node:
	if _is_node_last(node):
		printerr("asked the next goal from the last node")
		return null
	
	return node.get_parent().get_child(node.get_index() + 1)
	
func _set_goal_active(goal: Goal, active: bool) -> void:
	var path = get_path_to(goal)
	print(' %s goal %s' % ['+' if active else '-', str(path)])
	goal.set_active(active)
	if active:
		display_messages[path] = goal.get_display_message()
		goal.connect("reached", self, '_process_goals')
		emit_signal("goal_added")
	else:
		display_messages.erase(path)
		goal.disconnect("reached", self, '_process_goals')
		emit_signal("goal_removed")
	

var status = {}

func _fill_status(parent: Node, target: Node):
	for child in target.get_children():
		if child.has_method('_get_status'):
			var child_status = child._get_status()
			if not child_status.empty():
				status[parent.get_path_to(child)] = child_status
		if child.get_child_count() > 0:
			_fill_status(parent, child)
	

func save_status():
	status.clear()
	_fill_status(self, self)
	print(status)
	var resource = QuestState.new()
	resource.status = status
	for goal in goals:
		resource.active_goals.append(get_path_to(goal))
	var error = ResourceSaver.save('res://QuestSystem/statuses/%s.tres' % quest_name, resource)
	print(error)


func load_status():
	for goal in goals:
		_set_goal_active(goal, false)
	goals.clear()
	var res_path = 'res://QuestSystem/statuses/%s.tres' % quest_name
	print('loaded ' + res_path)
	var status = ResourceLoader.load(res_path) as QuestState
	for key in status.status.keys():
		print(status.status[key])
		get_node(key)._set_status(status.status[key])
	for path in status.active_goals:
		goals.append(get_node(path))
		_set_goal_active(get_node(path), true)

func _get_configuration_warning():
	if get_child_count() == 0:
		return "The quest has no Goals"
	
	for child in get_children():
		if not _is_goal_recursive(child):
			return "One of the children is not a Goal"
	
	return ""

func _is_goal_recursive(node: Node) -> bool:
	for child in node.get_children():
		if not _is_goal_recursive(child):
			return false
	
	print(node.name, node is Goal)
	return node is Goal
