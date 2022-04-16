extends Node2D

signal fire(action, params)
export (Resource) var goal

func _ready():
	connect("fire", goal, "onUnlockSignal")
	goal.connect('reached', self, 'goalReached')
	emit_signal("fire", 'reach_area', 'forest')
	
func goalReached(action, _a, _b, _c, _d):
	print("%s: %d" % [action, _a])
