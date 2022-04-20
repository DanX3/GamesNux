extends VBoxContainer

var panel = preload("res://QuestSystem/quest_list/QuestPanel.tscn")
var quests = {}

func track_quest(quest: Quest):
	quests[quest.quest_name] = quest
	var quest_panel = panel.instance()
	quest_panel.track_quest(quest)
	add_child(quest_panel)
