extends Sprite2D
const friend = preload("res://friend.tscn")
@onready var hb : HBoxContainer =  %HBoxContainer

func _ready():
	Event.friend_collected.connect(on_friend_collected)
	

func on_friend_collected():
	var contr : Control = Control.new()
	contr.custom_minimum_size.x = 120
	var new_friend = friend.instantiate()
	hb.add_child(contr)
	contr.add_child(new_friend)
	
