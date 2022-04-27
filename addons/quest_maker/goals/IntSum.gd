tool
extends "res://addons/quest_maker/Goal.gd"

export (int) var target
var counter = 0

func set_active(active: bool) -> void:
	if active:
		get_node("/root/SignalHub").connect("s_int", self, '_on_HUB_signal')
	else:
		get_node("/root/SignalHub").disconnect("s_int", self, '_on_HUB_signal')


func _on_HUB_signal(action, i):
	if self.action == action:
		counter += i
	
	print("%d / %d" % [counter, target])
	if counter >= target:
		emit_signal("reached", self)

func get_formatter():
	return "%d"

func get_value():
	return counter

func get_status() -> Dictionary:
	return {'counter': counter}

func set_status(status):
	counter = status.counter
	print('set counter to %d' % status.counter)
