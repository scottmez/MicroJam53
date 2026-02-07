class_name Player
extends CharacterBody2D

@onready var ap = $AnimationPlayer

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction.length_squared() > 0.0: #test to see if any inputs are being pressed
		walk_eyes()
	#else: 
	#would be nice to find a way to make the eyes go to neutral faster when we stop moving but stop is too fast
	#	ap.stop()
	var speed = 800
	var acceleration = 5000 #scott likey 5k
	var desired_velocity = direction * speed 
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	move_and_slide()
	
func walk_eyes():
	ap.play("walk")
