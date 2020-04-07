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
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.set_flip_h(true)
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("attack"):
		
		velocity.x = 0
		
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_POWER
		
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
