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


func _ready():
	# if processing in game
	if not Engine.editor_hint:
		set_meta("quest", true)
		get_child(0).go_to(null, get_child(0))


func clear_goals():
	for child in get_children():
		_disable_goals(child)

func _disable_goals(node: QuestNode):
	if node.active:
		node.left()
	
	for child in node.get_children():
		_disable_goals(child)

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
	clear_goals()
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
	EventBus.emit_signal("s_string", "quest_failed", quest_name)
	name = Goal.labels[Goal.StateLabel.FAILED] + name
