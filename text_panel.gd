class_name TextPanel
extends Panel

signal displaying
signal finished_displaying

@onready var text_label = $TextLabel
@export var text : String = ""
@export var char_per_second : float = 35

func display_text(t:String = ""):
	displaying.emit()
	text = t
	visible = true
	text_label.text = text
	text_label.visible_ratio = 0.0
	var text_speed : float = len(text) / char_per_second
	
	var tween := create_tween()
	tween.tween_property(text_label,"visible_ratio",1.0,text_speed)
	tween.finished.connect(func() -> void: finished_displaying.emit())
