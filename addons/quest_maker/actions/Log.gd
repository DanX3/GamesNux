tool
extends QuestAction

class_name Log

export (String) var message

func execute():
	print(message)
