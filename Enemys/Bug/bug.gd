extends KinematicBody2D

const GRAVITY = 300
const FLOOR = Vector2(0, -1)

var life = 3
var velocity = Vector2.ZERO

onready var Player = get_parent().get_node("Player")
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	animationPlayer.queue("walk")
	
	#print(life)
	if life <= 0:
		queue_free()
	
	if Player.position.x < position.x:
		if velocity.x > 1:
			velocity.x = 0
			velocity.y = 0
		velocity.x = -200
		$Sprite5.set_flip_h(false)
		
	elif Player.position.x > position.x:
		if velocity.x < -1:
			velocity.x = 0
			velocity.y = 0			
		velocity.x = 200
		$Sprite5.set_flip_h(true)
		
	else:
		velocity = 0
	
	velocity.y += GRAVITY * delta
	velocity.x -= 0.5
	
	velocity = move_and_slide(velocity, FLOOR)
