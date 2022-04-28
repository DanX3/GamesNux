extends StaticBody2D

export (Color) var color
export (String) var color_name

func _ready():
	modulate = color
	
