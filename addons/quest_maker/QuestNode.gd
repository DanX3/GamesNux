tool
extends Node

class_name QuestNode

var active := false

func _ready():
	if not Engine.editor_hint:
		name = '  ' + name
	else:
		# set node's custom name if provided
		var custom_name = _get_custom_name()
		if custom_name != "":
			name = custom_name


func _get_custom_name() -> String:
	return ""
	
func visited():
	pass

func left():
	pass

func process_next(leave = true):
	_next(self, leave)

#func process_stop():
#	set_active(false)

func process_add(node: QuestNode):
#	_set_active(node, true)
	node.visited()
	

static func _next(node: QuestNode, leave: bool):
#	_set_active(node, false)
	if leave:
		node.left()
	
	var next_node = _get_next(node)
	
	if next_node == null:
		_get_quest(node).succeed()
		return
	
	print('>> ', next_node.name)
#	_set_active(next_node, true)
	next_node.visited()
#
func go_to(from: QuestNode, to: QuestNode):
	if from != null:
		from.left()
		print("<< ", from.name)
	
		if to == null:
			_get_quest(from).succeed()
			return
	
	print(">> ", to.name)
	to.visited()

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

func _get_next_sibling() -> QuestNode:
	if _is_node_last():
		return null
	return get_parent().get_child(get_index() + 1) as QuestNode
