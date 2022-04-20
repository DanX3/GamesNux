extends Panel

var line = preload("res://QuestSystem/quest_list/QuestLine.tscn")

var quest: Quest

func track_quest(_quest: Quest):
	quest = _quest
	quest.connect("changed_goal", self, '_refresh_quest_goal')
	$Label.text = quest.quest_name
	_refresh_quest_goal()
	

func _refresh_quest_goal():
	for child in get_children():
		child.queue_free()
		
	var new_line = line.instance()
	new_line.text = quest.get_display_message()
	add_child(new_line)
