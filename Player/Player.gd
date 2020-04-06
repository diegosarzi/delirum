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
		walk_right()
	elif Input.is_action_pressed("ui_left"):
		walk_left()
	else:
		if on_gound == false:
			animationPlayer.queue('idle')
		else:
			animationPlayer.play("idle")
		virar = false
		velocity.x = 0
		
	if Input.is_action_pressed("ui_up"):
		if on_gound == true:
			jump()
			
	if is_on_floor():
		if virar == false:
			animationPlayer.play("idle")
		on_gound = true
	else:
		on_gound = false
	
	print(velocity.y)
	if velocity.y <= 1400 and velocity.y >= 200:
		if !is_on_floor():
			animationPlayer.play("jump_down")
		
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)


func jump():
	velocity.y = JUMP_POWER
	if !is_on_floor():
		animationPlayer.play("jump")
	on_gound = false
	
func walk_left():
	velocity.x = -SPEED
	$Sprite.set_flip_h(true)
	if on_gound == true:	
		if virar == false:
			animationPlayer.play("virada")
			virar = true
		animationPlayer.queue("walk_right")
	
func walk_right():
	velocity.x = SPEED
	$Sprite.set_flip_h(false)
	if on_gound == true:
		if virar == false:
			animationPlayer.play("virada")
			virar = true
		animationPlayer.queue("walk_right")
