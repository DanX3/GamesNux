tool
extends "res://addons/quest_maker/QuestNode.gd"

class_name QuestAction

func visited():
	execute()
	process_next()

func execute():
	pass
