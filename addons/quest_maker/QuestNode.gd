tool
extends Node

class_name QuestNode

var active := false

func process_next():
#	set_active(false)
#	if get_child_count() > 0:
#		get_child(0).set_active(true)
#		get_child(0).visited()
#		return
#
#	if _is_node_last():
#		get_quest().succeed()
#		return
#
#	var next_node = _get_next_node()
#	next_node.set_active(true)
#	next_node.visited()
	_next(self)

func process_stop():
	name = labels[false] + name.substr(2)
	active = false


func process_add(node: QuestNode):
	_set_active(node, true)
	node.visited()
	

static func _next(node: QuestNode):
	_set_active(node, false)
	
	var next_node = _get_next(node)
	
	if next_node == null:
		_get_quest(node).succeed()
		return
	
	print('visiting ', next_node.name)
	_set_active(next_node, true)
	
	next_node.visited()
	
	
static func _get_next(node: QuestNode) -> QuestNode:
	if node.get_child_count() > 0:
		return node.get_child(0) as QuestNode
	
	# is node last
	if node.get_index() + 1 == node.get_parent().get_child_count():
		return null
	
	return node.get_parent().get_child(node.get_index() + 1) as QuestNode

static func _set_active(node, active):
	node.name = labels[active] + node.name.substr(2)
	node.active = active

func visited():
	pass

enum StateLabel { UNCHECKED, ACTIVE, REACHED, FAILED }
const labels = {
	false: '  ',
	true: '→ ',
#	StateLabel.REACHED: '✓ ',
#	StateLabel.FAILED: 'X '
}

func set_active(active: bool):
	self.active = active
	name = labels[active] + name.substr(2)


func _ready():
	print("ready ", name)
	if not Engine.editor_hint:
		name = '  ' + name
	else:
		var custom_name = _get_custom_name()
#		print("node %s got %s" % [name, custom_name])
		if custom_name != "":
			name = custom_name
#			print('set custom name ', custom_name)


func _get_custom_name() -> String:
	return ""

var statelabel = StateLabel.UNCHECKED

func set_state_label(statelabel):
	name = labels[statelabel] + name.substr(2)
	self.statelabel = statelabel

func get_quest():
	return _get_quest(self)

static func _get_quest(node: Node):
	if node.has_meta("quest"):
		return node
	if node.get_parent() == null:
		return null
	return _get_quest(node.get_parent())


func _is_node_last() -> bool:
	return (get_index() + 1) == get_parent().get_child_count()

func _get_next_node() -> QuestNode:
	return get_parent().get_child(get_index() + 1) as QuestNode
