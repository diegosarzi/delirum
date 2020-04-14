extends AnimationTree

var playback : AnimationNodeStateMachinePlayback
var weapon = ""
func _ready():
	playback = get("parameters/playback")
	active = true
	
func _process(_delta):
	
	if Input.is_action_just_pressed("change_weapon") and (weapon == ""):
		weapon = "-sword"
		print('sword')
	elif Input.is_action_just_pressed("change_weapon"):
		weapon = ""
		print('null')
		
	if Input.is_action_just_pressed("attack"):
		playback.travel("attack")
	elif not Input.is_action_pressed("run") and (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		playback.travel("walk_right" + weapon)
		if Input.is_action_just_pressed("ui_up"):
			print(get_node("Playerds"))
			playback.travel("jump")
	elif Input.is_action_just_pressed("ui_up"):
		playback.travel("jump")
	elif Input.is_action_pressed("run") and (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		playback.travel("run" + weapon)
	else:
		playback.travel("idle" + weapon)
