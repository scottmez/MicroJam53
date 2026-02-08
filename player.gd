class_name Player
extends CharacterBody2D

const steps_audio = preload("res://Sound/steps.mp3")

@onready var ap = $AnimationPlayer
@onready var iris_2 = $white2/iris2
@onready var iris = $white1/iris
@onready var text_panel = %TextPanel

var displaying_text : bool = true

func _ready():
	GameManager.player = self
	text_panel.displaying.connect(func() -> void: 
		displaying_text = true)
	text_panel.finished_displaying.connect(func() -> void: displaying_text = false)
	display_text_bubble("I need to go find my friends.")

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction.length_squared() > 0.0 and not displaying_text: #test to see if any inputs are being pressed
		walk_eyes()
	#else: 
	#would be nice to find a way to make the eyes go to neutral faster when we stop moving but stop is too fast
	#	ap.stop()
	var speed = 800
	var acceleration = 5000 #scott likey 5k
	var desired_velocity = direction * speed 
	if not displaying_text:
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	else:
		velocity = Vector2(0,0)
	move_and_slide()
	
func walk_eyes():
	ap.play("walk")
	if not SfxPlayer.is_playing_stream(steps_audio):
		SfxPlayer.play(steps_audio)
	text_panel.visible = false
	
func look_at_friend(pos : Vector2): 
	#pos is position of nearest friend
	var vec_to_nearest = pos - global_position
	vec_to_nearest = vec_to_nearest.normalized() * 10 #10 is # pixels iris will move
	iris.position = vec_to_nearest + Vector2(-4,1)
	iris_2.position = vec_to_nearest + Vector2(-5,1)
	#could make smoother later, but its pretty good 

func display_text_bubble(text : String):
	text_panel.display_text(text)
