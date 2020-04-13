extends KinematicBody2D

const GRAVITY = 50
const FLOOR = Vector2(0, -1)

onready var bar = $HealthBar
onready var life = 3
var velocity = Vector2.ZERO
var speed = 220
var die = false

onready var state_machine = $AnimationTree.get("parameters/playback")
onready var Player = get_parent().get_node("Player")
onready var animationPlayer = $AnimationPlayer

func _ready():
	bar._on_max_health_updated(3)
	bar.get_node("HealthBar").tint_progress = '#dc1d1d'
	$AnimationTree.set_active(true)

func _physics_process(_delta):
	
	if life <= 0:
		die = true
		$CollisionShape2D.hide()
		$attack_area.hide()
		velocity.x = 0
		state_machine.travel('die')

	if Player.position.x < position.x and die == false and Player.position.x - position.x > -1800:
		if velocity.x > 1:
			velocity.x = 0
			velocity.y = 0
		velocity.x = -speed
		$Sprite5.set_flip_h(false)
		
	elif Player.position.x > position.x and die == false and Player.position.x - position.x < 1800:
		if velocity.x < -1:
			velocity.x = 0
			velocity.y = 0
		velocity.x = speed
		$Sprite5.set_flip_h(true)
		
	else:
		velocity.x = 0

	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)

func _on_attack_area_body_entered(body):
	state_machine.travel('attack')
	
func _on_attack_area_body_exited(body):
	state_machine.travel("walk")

func _on_damage_area_body_entered(body):
	if body == get_parent().get_node("Player"):
		body.life -= 10
		body.get_node("HealthBar")._on_health_updated(body.life,1)
