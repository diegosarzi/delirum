extends KinematicBody2D

var SPEED = 500
const GRAVITY = 50
const JUMP_POWER = -2000
const FLOOR = Vector2(0, -1)
var velocity = Vector2.ZERO
var max_boost = 1200
var bost_time = 0
var weapon = null
var dist_attack = 150
var damage
var full_life = 100
var actual_life = full_life
var life = full_life
var direction = 1
var damage_on = true

onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	
	if life < actual_life:
		print('perdeu life')
		actual_life = life
		if (direction == 1):
			position.x = position.x - 100
			$AnimationPlayerDamage.play("damage")
			damage_on = false
			$Timer.start()
		else:
			position.x = position.x + 100
			$AnimationPlayerDamage.play("damage")
			damage_on = false
			$Timer.start()
			

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
		direction = 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.set_flip_h(true)
		$Area2D/attack.position.x = -dist_attack
		direction = 0
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
	body.life -= damage
	body.get_node("HealthBar")._on_health_updated(body.life,1)


func _on_Timer_timeout():
	damage_on = true
