extends Control

onready var health_bar = $HealthBar
onready var tween = $Tween

func _on_health_updated(health, _amount):
	#health_bar.value = health
	tween.interpolate_property(health_bar,"value",health_bar.value, health, 0.4, tween.TRANS_SINE, tween.EASE_IN_OUT)
	tween.start()
	
func _on_max_health_updated(max_health):
	health_bar.max_value = max_health
