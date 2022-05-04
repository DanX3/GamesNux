tool
extends "res://addons/quest_maker/Goal.gd"

export (float) var target 
var counter = 0.0

func set_active(active: bool) -> void:
	if active:
		get_node("/root/SignalHub").connect("s_float", self, '_on_HUB_signal')
	else:
		get_node("/root/SignalHub").disconnect("s_float", self, '_on_HUB_signal')


func _on_HUB_signal(action, i):
	if self.action == action:
		counter += i
	
	print("%.2f / %.2f" % [counter, target])
	if counter >= target:
		emit_signal("reached", self)


func get_formatter():
	return "%.2f"

func get_value():
	return counter

func get_status():
	return {'counter': counter}

func set_status(status):
	counter = status.counter
	print('set counter to %d' % status.counter)
