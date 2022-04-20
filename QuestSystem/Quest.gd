extends Node

class_name Quest

signal accomplished(quest_name)
signal changed_goal

export (String) var quest_name
export (String) var display_name
export (Resource) var reward
var active_node_path

var current_goal: NodePath = ""
var display_messages := {}

func _ready():
	return
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
		emit_signal("changed_goal")
	else:
		display_messages.erase(path)
		goal.disconnect("reached", self, '_on_goal_reached')

func _on_goal_reached():
	_process_goals()


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
	resource.current_goal = current_goal
	var error = ResourceSaver.save('res://QuestSystem/statuses/%s.tres' % quest_name, resource)
	print(error)


func load_status():
	if current_goal != "":
		_set_goal_active(current_goal, false)
	var path = 'res://QuestSystem/statuses/%s.tres' % quest_name
	print('loaded ' + path)
	var status = ResourceLoader.load(path)
	for key in status.status.keys():
		print(status.status[key])
		get_node(key)._set_status(status.status[key])
	_set_goal_active(status.current_goal, true)
	current_goal = status.current_goal

func get_display_message() -> String:
	return "" if current_goal == null else get_node(current_goal).get_display_message()
