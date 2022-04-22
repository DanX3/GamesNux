extends Goal

export (int) var times
var counter = 0


func set_active(active: bool) -> void:
	if active:
		get_node("/root/SignalHub").connect("s_empty", self, '_on_HUB_signal')
	else:
		get_node("/root/SignalHub").disconnect("s_empty", self, '_on_HUB_signal')


func _on_HUB_signal(action):
	if self.action == action:
		counter += 1
	
	print("%d / %d" % [counter, times])
	if counter >= times:
		emit_signal("reached", self)


func get_formatter():
	return "%d"

func get_value():
	return times


func _get_status():
	return {'counter': counter}

func _set_status(status):
	counter = status.counter
