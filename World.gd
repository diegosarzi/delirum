extends Node2D

var direction
onready var anim_player = $Vagalume/AnimationPlayer2
var zoom = false
var value = null

func _physics_process(_delta):
	# sem player
	if not $Player:
		return get_tree().reload_current_scene()
	#######################################################################
	##### ANIMATE FOLLOW VAGALUME
	#if $Vagalume.position.x < $Player.position.x:
	#	$Vagalume.get_node("Sprite/AnimatedSprite").set_flip_h(false)
	#	direction = -200
	#else:
	#	$Vagalume.get_node("Sprite/AnimatedSprite").set_flip_h(true)
	#	direction = 200
		
	#$Tween.interpolate_property($Vagalume,"position",$Vagalume.position,$Player.position + Vector2(direction,-500),2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	#$Tween.start()
	######################################################################
	if Input.is_action_just_pressed("zoom"):
		if zoom == false:
			camera_zoom('in')
			zoom = true
		else:
			camera_zoom('out')
			zoom = false

	
## areas de mensagem ( tutorial )
func _on_gui_up_area_body_entered(_body):
	$GUI_UP_KEY/AnimationPlayer.play("start")

## area de mensagem ( tutorial - punch )
func _on_gui_punch_area_body_entered(_body):
	$GUI_PUNCH/AnimationPlayer.play("start")

## area de mensagem ( tutorial - run )
func _on_gui_run_area_body_entered(body):
	if(body == $Player):
		$GUI_RUN/AnimationPlayer.play("start")
	
# player die ( cair da plataforma )
func _on_die_body_entered(body):
	if(body == $Player):
		return get_tree().reload_current_scene()

# encontro com vagalume
func _on_Vagalume_body_entered(_body):
	$Vagalume/CollisionShape2D.queue_free()
	$Vagalume/AnimationPlayer2.play("textos")
	#$Player/Camera2D.set_zoom(Vector2(1,1))
	camera_zoom('in')

# animation vagalume ( encontro )
func _on_AnimationPlayer2_animation_finished(anim_name):
	if(anim_name == 'textos'):
		anim_player.play("out")
	elif(anim_name == 'out'):
		camera_zoom('out')
		$Vagalume.queue_free()

func camera_zoom(arg):
	if arg == 'in':
		value = Vector2(1,1)
	else:
		value = Vector2(2,2)
	$Tween.interpolate_property($Player/Camera2D, "zoom", $Player/Camera2D.zoom,value,1,Tween.TRANS_BACK,Tween.EASE_IN_OUT)
	$Tween.start()



