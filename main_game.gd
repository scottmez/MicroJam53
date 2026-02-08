extends Node2D

@onready var friend_nodes = %FriendNodes
var friends_remaining = 1
#we need a reference to all lights to turn them off to get the fade to black effect
#LIGHTS
@onready var player_light = $Player/PlayerLight
@onready var light_1 = $Lighting/Light1
@onready var light_2 = $Lighting/Light2
@onready var light_3 = $Lighting/Light3
var fade_time : float  = 4.0
@onready var canvas_modulate = $CanvasModulate


func _ready():
	friends_remaining = friend_nodes.get_child_count()
	Event.friend_collected.connect(on_friend_collected)
	
#when friends_remaining == 0: transition to end scene
func on_friend_collected():
	friends_remaining -= 1
	if friends_remaining == 0:
		#transition to end game scene
		#if we have like a nice little ending noise, play that here
		var tween := create_tween()
		tween.parallel().tween_property(player_light, "energy", 0, fade_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.parallel().tween_property(light_1, "energy", 0, fade_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.parallel().tween_property(light_2, "energy", 0, fade_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.parallel().tween_property(light_3, "energy", 0, fade_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.finished.connect(func() -> void:
			var tween2 := create_tween()
			tween2.tween_property(canvas_modulate, "color", Color(0,0,0,1), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			get_tree().create_timer(2.0).timeout.connect(func() -> void: get_tree().change_scene_to_file("res://end_scene.tscn"))
		)
