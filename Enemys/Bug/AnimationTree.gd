extends AnimationTree

var playback : AnimationNodeStateMachinePlayback

onready var position
 
func _ready():
	playback = get("parameters/playback")
	active = true
	
func _process(_delta):
	get_node('AnimationPlayer').play("attack")
	
	
	
	
	if Input.is_action_just_pressed("attack"):
		playback.travel("attack")
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		playback.travel("walk_right")
		if Input.is_action_just_pressed("ui_up"):
			playback.travel("jump")
	elif Input.is_action_just_pressed("ui_up"):
		playback.travel("jump")
	else:
		playback.travel('idle')
