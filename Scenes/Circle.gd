extends Sprite


func _ready():
	pass

const SPEED = 300.0
var dir

func _physics_process(delta):
	dir = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		dir.x -= 1.0
	if Input.is_action_pressed("move_right"):
		dir.x += 1.0
	if Input.is_action_pressed("move_up"):
		dir.y -= 1.0
	if Input.is_action_pressed("move_down"):
		dir.y += 1.0
	position += delta * SPEED * dir.normalized()
	
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)



func _on_Area2D2_body_entered(body):
	print(body.color_name)
	get_node("/root/SignalHub").emit_signal("s_string", "collected", body.color_name)
	body.queue_free()
