extends Node2D

onready var forestCondition = $Quest/ArrivedAtForest
onready var desertCondition = $Quest/ArrivedAtDesert
onready var valleyCondition = $Quest/ArrivedAtValley

func _ready():
	forestCondition.connect("reached", self, 'on_forest_reached')
	desertCondition.connect("reached", self, 'on_desert_reached')
	valleyCondition.connect("reached", self, 'on_valley_reached')
#	forestCondition._set_active(true)
	get_node("/root/SignalHub").emit_signal("s_string", 'arrived_at', 'valley')
	get_node("/root/SignalHub").emit_signal("s_string", 'arrived_at', 'forest')
	get_node("/root/SignalHub").emit_signal("s_string", 'arrived_at', 'desert')
	
	
	
func on_forest_reached():
	print('Ehy!! I reached the forest')

func on_desert_reached():
	print('Ehy!! I reached the desert')

func on_valley_reached():
	print('Ehy!! I reached the valley')

func _on_Quest_accomplished(quest_name):
	print('quest accomplished ' + str(quest_name))
