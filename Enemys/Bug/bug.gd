extends KinematicBody2D

const GRAVITY = 50
const FLOOR = Vector2(0, -1)

onready var life = 3
var velocity = Vector2.ZERO
var die = false

onready var state_machine = $AnimationTree.get("parameters/playback")
onready var Player = get_parent().get_node("Player")
onready var animationPlayer = $AnimationPlayer

func _physics_process(_delta):
	
	if life <= 0:
		die = true
		$CollisionShape2D.hide()
		$attack_area.hide()
		velocity.x = 0
		state_machine.travel('die')

	if Player.position.x < position.x and die == false:
		if velocity.x > 1:
			velocity.x = 0
			velocity.y = 0
		velocity.x = -150
		$Sprite5.set_flip_h(false)
		
	elif Player.position.x > position.x and die == false:
		if velocity.x < -1:
			velocity.x = 0
			velocity.y = 0
		velocity.x = 150
		$Sprite5.set_flip_h(true)

	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)

func _on_attack_area_body_entered(body):
	state_machine.travel('attack')
	
func _on_attack_area_body_exited(body):
	state_machine.travel("walk")
