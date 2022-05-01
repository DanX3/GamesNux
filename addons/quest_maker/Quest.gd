tool
extends Node

class_name Quest

signal accomplished(quest_name)
signal failed(quest_name)
signal goal_added
signal goal_removed

export (String) var quest_name
export (String) var display_name
export (Resource) var reward

var goals = []

#
# Quest navigation
#

func _ready():
	# if processing in game
	if not Engine.editor_hint:
		set_meta("quest", true)
		get_child(0).visited()
#	if not Engine.editor_hint:
#		print("processing goals")
#		_process_goals(null)
	
	
#func _process_goals(goal_reached: Goal):
#	# starts processing the first goal
#	if goal_reached == null and get_child_count() > 0:
#		_chain_activation(get_child(0))
#		return
#
#	if not (goal_reached is Goal):
#		printerr("Goal passed %s is not of Goal type" % goal_reached.name)
#
#	# disables the reached goal
#	goal_reached.set_state_label(Goal.StateLabel.REACHED)
#	_set_goal_active(goal_reached, false)
#	goals.erase(goal_reached)
#
#	# accomplish the mission if it was the last node in its parent
#	if _is_node_last(goal_reached) and goal_reached.get_child_count() == 0:
#		clear_goals()
#		get_node("/root/SignalHub").emit_signal("s_string", "quest_finished", quest_name)
#		get_node("/root/SignalHub").emit_signal("s_resource", "item_obtained", reward)
#		emit_signal("accomplished", quest_name)
#		name = Goal.labels[Goal.StateLabel.REACHED] + name
#		return
#
#	# if the goal has children, start tracking its children
#	if goal_reached.get_child_count() > 0:
#		# clear the active goals if the reached one say so
#		if goal_reached.clear_goals:
#			clear_goals(true)
#		_chain_activation(goal_reached.get_child(0))
#		return
#
#	if not goal_reached.optional:
#		var next_goal = _next_node(goal_reached) as Goal
#		if next_goal != null:
#			_chain_activation(next_goal)
#
#	print("#active goals: %d" % len(goals))
#
#
#func clear_goals(fail_goals = false):
#	for g in goals:
#		if fail_goals:
#			g.set_state_label(Goal.StateLabel.FAILED)
#		_set_goal_active(g, false)
#	goals.clear()
#
#func _chain_activation(goal: Goal):
#	goals.append(goal)
#	_set_goal_active(goal, true)
#	if goal.optional and not _is_node_last(goal):
#		_chain_activation(_next_node(goal))
#
#func _is_node_last(node: Node) -> bool:
#	return (node.get_index() + 1) == node.get_parent().get_child_count()
#
#func _next_node(node: Node) -> Node:
#	if _is_node_last(node):
#		printerr("asked the next goal from the last node")
#		return null
#
#	return node.get_parent().get_child(node.get_index() + 1)
#
#func _set_goal_active(goal: Goal, active: bool) -> void:
#	goal.set_active(active)
#	if active:
#		goal.set_state_label(Goal.StateLabel.ACTIVE)
#		goal.connect("reached", self, '_process_goals', [], CONNECT_ONESHOT)
#		emit_signal("goal_added")
#	else:
#		emit_signal("goal_removed")

#
# Status Management
#

var status = []

func _fill_status(target: Node):
	if not target is Goal:
		return
		
	var target_status = target.get_status()
	target_status['__statelabel__'] = target.statelabel
	status.append(target_status)
	
	for child in target.get_children():
		_fill_status(child)


const savepath = 'res://addons/quest_maker/questdata/%s.tres'

func save_status():
	status.clear()
	for child in get_children():
		_fill_status(child)
	print(status)
	var resource = QuestState.new()
	resource.status = status
	resource.keys = keys.keys()
	var error = ResourceSaver.save(savepath % quest_name, resource)
	print(error)


func load_status():
#	for goal in goals:
#		_set_goal_active(goal, false)
	goals.clear()
	var status = ResourceLoader.load(savepath % quest_name) as QuestState
	for child in get_children():
		_apply_status(status, child)

func _apply_status(status: QuestState, target: Node):
	if not target is Goal:
		return
	
	var target_status = status.status.pop_front()
	target.set_status(target_status)
	target.set_state_label(target_status['__statelabel__'])
#	if target_status['__statelabel__'] == Goal.StateLabel.ACTIVE:
#		_set_goal_active(target, true)
	
	for child in target.get_children():
#		_fill_status(child)
		_apply_status(status, child)


#
# Configuration warning
#

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
	
	return node is QuestNode


#
# Keys Management
#

var keys := {}

func key_add(key):
	if key is String:
		keys[key] = 0
	
	if key is Array:
		for k in key:
			key_add(k)

func key_remove(key: String) -> bool:
	return keys.erase(key)

func key_check(quest_name: String, key: String) -> bool:
	var quest_state = ResourceLoader.load(savepath % quest_name) as QuestState
	if quest_state == null:
		return false
	return quest_state.keys.has(key)


#
# Actions
#

# check if mission is failed
func succeed():
	pass
	
func fail():
#	clear_goals()
	emit_signal("failed", quest_name)
	get_node("/root/SignalHub").emit_signal("s_string", "quest_failed", quest_name)
	name = Goal.labels[Goal.StateLabel.FAILED] + name
