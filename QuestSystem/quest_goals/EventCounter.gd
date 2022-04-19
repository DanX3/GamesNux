extends Goal

export (int) var times
export (String) var display_message
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
		emit_signal("reached")


func _get_display_message():
	if display_message.find("%d") != -1:
		return display_message % times
	else:
		return display_message
