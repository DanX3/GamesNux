tool
extends "res://addons/quest_maker/QuestAction.gd"

class_name FailQuest

func execute():
	get_quest().fail()
