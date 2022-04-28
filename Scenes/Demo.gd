extends Node2D

export (Dictionary) var coins

func _ready():
	for coin_color in coins.keys():
		spawn_coin("collected", coin_color)
	get_node("/root/SignalHub").connect("s_string", self, "spawn_coin")

func spawn_coin(action, coin_color):
	if action != "collected":
		return
		
	var s = get_viewport_rect().size
	var pos = Vector2(rand_range(0, s.x), rand_range(0, s.y))
	var new_coin = coins[coin_color].instance()
	new_coin.position = pos
	add_child(new_coin)
	
