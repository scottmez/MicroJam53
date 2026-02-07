class_name Friend
extends Node2D

@onready var ap = $AnimationPlayer
@onready var ia = %"Interaction Area"
var player : Player = null
var collected : bool = false

func _ready():
	ia.body_entered.connect(_on_player_enter)
	ia.body_exited.connect(_on_player_exit)
	
func _on_player_enter(body: Node2D):
	if body is Player:
		player = body

func _on_player_exit(body: Node2D):
	if body is Player:
		player = null
		

func _input(event):
	if event.is_action_pressed("interact") and player and not collected:
		collected = true
		Event.friend_collected.emit() 
		
		queue_free() #replace with making friend go to plane
