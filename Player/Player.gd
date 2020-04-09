extends KinematicBody2D

const SPEED = 500
const GRAVITY = 50
const JUMP_POWER = -1800
const FLOOR = Vector2(0, -1)

var velocity = Vector2.ZERO

onready var base = $RayCast2D
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.set_flip_h(false)
		$Area2D/attack.position.x = 134.244
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.set_flip_h(true)
		$Area2D/attack.position.x = -134.244
		
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("attack"):
		
		velocity.x = 0
		
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_POWER
		
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)


func _on_Area2D_body_entered(body):
	print(body)
	body.life -= 1
	body.animationPlayer.play('damage')
	pass
	#get_parent().get_node('Bug').life -= 1
	#get_parent().get_node('Bug').animationPlayer.play('damage')
