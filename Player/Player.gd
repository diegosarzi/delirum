extends KinematicBody2D

const SPEED = 500
const GRAVITY = 50
const JUMP_POWER = -1500
const FLOOR = Vector2(0, -1)

var velocity = Vector2.ZERO

var on_gound = false
var virar = false

onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.set_flip_h(false)
		if virar == false:
			animationPlayer.play("virada")
			virar = true
		animationPlayer.queue("walk_right")
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.set_flip_h(true)
		if virar == false:
			animationPlayer.play("virada")
			virar = true
		animationPlayer.queue("walk_right")
			
	else:
		animationPlayer.play("idle")
		virar = false
		velocity.x = 0
		
	if Input.is_action_pressed("ui_up"):
		if on_gound == true:
			velocity.y = JUMP_POWER
			on_gound = false
			
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_gound = true
	else:
		on_gound = false
	
	velocity = move_and_slide(velocity, FLOOR)
