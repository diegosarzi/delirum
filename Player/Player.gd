extends KinematicBody2D

const SPEED = 500
const GRAVITY = 50
const JUMP_POWER = -2000

const FLOOR = Vector2(0, -1)

var velocity = Vector2.ZERO

var life = 100

onready var base = $RayCast2D
onready var animationPlayer = $AnimationPlayer

func _physics_process(_delta):
	print(life)
	if life <= 0:
		queue_free()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.set_flip_h(false)
		$Area2D/attack.position.x = 150
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.set_flip_h(true)
		$Area2D/attack.position.x = -150
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("attack"):
		velocity.x = 0
		
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_POWER
		
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)

func _on_Area2D_body_entered(body):
	if body.position.x > position.x:
		body.position.x += 120
	elif body.position.x < position.x:
		body.position.x -= 120
		
	body.state_machine.travel('damage')
	body.life -= 1
	body.get_node("HealthBar")._on_health_updated(body.life,1)
