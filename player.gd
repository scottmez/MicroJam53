class_name Player
extends CharacterBody2D

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	var speed = 800
	var acceleration = 5000 #scott likey 5k
	var desired_velocity = direction * speed 
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	move_and_slide()
