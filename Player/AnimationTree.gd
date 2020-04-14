extends AnimationTree

var playback : AnimationNodeStateMachinePlayback
var weapon = ""
var weapon_anim = ""
var is_floor
func _ready():
	playback = get("parameters/playback")
	active = true
	
func _process(_delta):

	if Input.is_action_just_pressed("change_weapon") and (weapon == ""):
		weapon = "sword"
		weapon_anim = "-" + weapon
		print('sword')
	elif Input.is_action_just_pressed("change_weapon"):
		weapon = ""
		weapon_anim = ""
		print('null')
		
	if Input.is_action_just_pressed("attack"):
		playback.travel("attack" + weapon_anim)
	elif not Input.is_action_pressed("run") and (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		playback.travel("walk_right" + weapon_anim)
		if Input.is_action_just_pressed("ui_up"):
			print(get_node("Playerds"))
			playback.travel("jump")
	elif Input.is_action_just_pressed("ui_up"):
		playback.travel("jump")
	elif Input.is_action_pressed("run") and (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		playback.travel("run" + weapon_anim)
	else:
		playback.travel("idle" + weapon_anim)
