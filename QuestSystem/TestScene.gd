extends Node2D

onready var quest = $AnotherQuest

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
	quest.save_status()


func _on_LoadButton_pressed():
	quest.load_status()


func _on_TheFryingPan_accomplished(quest_name):
	print("Accomplished mission ", quest_name)
