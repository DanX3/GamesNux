extends Node2D

onready var forestCondition = $Quest/ArrivedAtForest
onready var desertCondition = $Quest/ArrivedAtDesert
onready var valleyCondition = $Quest/ArrivedAtValley


onready var deaths = $Quest/DieCounter

func _ready():
	forestCondition.connect("reached", self, 'on_forest_reached')
	desertCondition.connect("reached", self, 'on_desert_reached')
	valleyCondition.connect("reached", self, 'on_valley_reached')
	
#	get_node("/root/SignalHub").emit_signal("s_string", 'arrived_at', 'valley')
#	get_node("/root/SignalHub").emit_signal("s_string", 'arrived_at', 'forest')
#	get_node("/root/SignalHub").emit_signal("s_string", 'arrived_at', 'desert')
#	get_node("/root/SignalHub").emit_signal("s_string", 'defeated_enemy', 'ogre')
#	get_node("/root/SignalHub").emit_signal("s_empty", 'died')
#	get_node("/root/SignalHub").emit_signal("s_empty", 'died')
#	get_node("/root/SignalHub").emit_signal("s_empty", 'died')
	
func on_forest_reached():
	print('Ehy!! I reached the forest')

func on_desert_reached():
	print('Ehy!! I reached the desert')

func on_valley_reached():
	print('Ehy!! I reached the valley')

func _on_Quest_accomplished(quest_name):
	print('quest accomplished ' + str(quest_name))


func _on_EmptyButton_pressed():
	get_node("/root/SignalHub").emit_signal("s_empty",\
		$CanvasLayer/Empty/TextEdit.text)
	

func _on_IntButton_pressed():
	get_node("/root/SignalHub").emit_signal("s_int", \
		$CanvasLayer/Int/TextEdit.text,\
		int($CanvasLayer/Int/TextEdit2.text))


func _on_FloatButton_pressed():
	get_node("/root/SignalHub").emit_signal("s_float",\
		$CanvasLayer/Float/TextEdit.text,\
		float($CanvasLayer/Float/TextEdit2.text))


func _on_StringButton_pressed():
	get_node("/root/SignalHub").emit_signal("s_string",\
		$CanvasLayer/String/TextEdit.text,\
		$CanvasLayer/String/TextEdit2.text)


func _on_SaveButton_pressed():
	$Quest.save_status()


func _on_LoadButton_pressed():
	$Quest.load_status()
