extends Node

#class_name SignalHUB

signal s_empty(action, args)
signal s_int(action, args)
signal s_float(action, args)
signal s_string(action, args)
signal s_resource(action, args)
signal s_signal(action, args)
#func _ready():
#	pass

func broadcast_s_empty(action: String):
	emit_signal("s_empty", action, null)

func connect_user_signal(signal_name: String, args: Array, object, func_name: String):
	if not has_signal(signal_name):
		add_user_signal(signal_name, args)
	connect(signal_name, object, func_name)
	

func broadcast_user_signal(signal_name: String, args: Array):
	emit_signal(signal_name, args)
