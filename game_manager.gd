extends Node2D

@onready var player : CharacterBody2D# = $Player
@onready var friend_nodes : Node2D#= %FriendNodes
var closest : Friend 

func _process(_delta):
	if friend_nodes and friend_nodes.get_child_count() > 0: #
		closest = find_closest_friend()
		player.look_at_friend(closest.global_position)
	

func find_closest_friend():
	var min_friend = friend_nodes.get_child(0)
	for i in friend_nodes.get_children():
		if player.global_position.distance_to(i.global_position) < player.global_position.distance_to(min_friend.global_position):
			min_friend = i 
	return min_friend
