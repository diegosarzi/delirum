extends KinematicBody2D

var SPEED = 500
const GRAVITY = 50
const JUMP_POWER = -2000

const FLOOR = Vector2(0, -1)

var velocity = Vector2.ZERO

var life = 100
var max_boost = 1200
var bost_time = 0

var weapon = null
var dist_attack = 150

var damage

onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):

	if $AnimationTree.weapon == "sword":
		damage = 3
		dist_attack = 190
	else:
		damage = 1
		dist_attack = 150
	
	if life <= 0:
		return get_tree().reload_current_scene()
		
	# correr!
	if Input.is_action_pressed("run"):
		if(SPEED < max_boost):
			SPEED += SPEED * delta
	else:
		if(SPEED > 600):
			SPEED -= SPEED * delta
			velocity.x = SPEED
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.set_flip_h(false)
		$Area2D/attack.position.x = dist_attack
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.set_flip_h(true)
		$Area2D/attack.position.x = -dist_attack
	else:
		velocity.x = 0
		
	if is_on_floor():
		$AnimationTree.is_floor = true
	else:
		$AnimationTree.is_floor = false
	
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
	print(damage)
	body.life -= damage
	body.get_node("HealthBar")._on_health_updated(body.life,1)
