extends KinematicBody2D

onready var player = get_parent().get_node("Player")
const speed = 300
const distance = 300

var dir2

var velocity
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var dir = (player.position - position).normalized()
	
	if dir.x > 0:
		dir2 = ((player.position - Vector2(distance,500)) - position).normalized()
		get_node("Sprite/AnimatedSprite").set_flip_h(false)		
	else:
		dir2 = ((player.position - Vector2(-distance,500)) - position).normalized()
		get_node("Sprite/AnimatedSprite").set_flip_h(true)
		
	print(dir.y)

	velocity = Vector2( dir2.x * speed , dir2.y * speed)

	move_and_slide(velocity,Vector2(0,-1))
