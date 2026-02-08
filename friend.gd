class_name Friend
extends Node2D

@export var found_message := "You found me!"

@onready var ap = $AnimationPlayer
@onready var ia = %"Interaction Area"
@onready var iris_2 = $white2/iris2
@onready var iris = $white1/iris
@onready var p = $"../../Player"

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
		player.display_text_bubble(found_message)
		queue_free() #replace with making friend go to plane
		
func _process(_delta):
	look_at_player()

func look_at_player():
	if p:
		var vec_to_player = p.global_position - global_position
		vec_to_player = vec_to_player.normalized() * 10 #10 is # pixels iris will move
		iris.position = vec_to_player + Vector2(-4,1)
		iris_2.position = vec_to_player + Vector2(-5,1)
	else:
		iris.position = Vector2(-4,1)
		iris_2.position = Vector2(-5,1)
