extends Node2D

var direction

func _physics_process(delta):
	#######################################################################
	##### ANIMATE FOLLOW VAGALUME
	if $Vagalume.position.x < $Player.position.x:
		$Vagalume.get_node("Sprite/AnimatedSprite").set_flip_h(false)
		direction = -200
	else:
		$Vagalume.get_node("Sprite/AnimatedSprite").set_flip_h(true)
		direction = 200
		
	$Tween.interpolate_property($Vagalume,"position",$Vagalume.position,$Player.position + Vector2(direction,-500),2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	#######################################################################
