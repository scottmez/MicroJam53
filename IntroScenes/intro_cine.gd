class_name IntroCine
extends Node2D

const SUNSET_COLOR := Color("#c6b39458")
const NIGHT_COLOR := Color("#0b0f2bb5")
const BLACKOUT_COLOR := Color("#000000")

@export var sky_transition_time: float = 14.0
@export var plane_down_time: float = 2.2
@export var plane_down_offset: float = 200.0
@export var cloud_speed: float = 60.0
@export var cloud_reset_margin: float = 200.0

@onready var sky = %Sky
@onready var clouds: Node2D = $Clouds
@onready var plane: Node2D = $Plane
@onready var smoke_particle_1 = $Plane/SmokeParticle1
@onready var smoke_particle_2 = $Plane/SmokeParticle2
@onready var lightning_flash: ColorRect = %LightningFlash
@onready var lightning = $Lightning

var bob := create_tween().set_loops()
var _viewport_size: Vector2
var _cloud_sprites: Array[Node2D] = []

func _ready() -> void:
	_viewport_size = get_viewport_rect().size
	_cloud_sprites = []
	for child in clouds.get_children():
		_cloud_sprites.append(child)
	_update_sky()
	_start_plane_flight()

func _process(delta: float) -> void:
	for cloud in _cloud_sprites:
		cloud.position.x -= cloud_speed * delta
		if cloud.position.x < -cloud_reset_margin:
			cloud.position.x = _viewport_size.x + cloud_reset_margin
			cloud.position.y = randf_range(30, _viewport_size.y-30)

func _update_sky() -> void:
	sky.color = SUNSET_COLOR
	var tween := create_tween()
	tween.tween_property(sky, "color", NIGHT_COLOR, sky_transition_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(_plane_down)
	get_tree().create_timer(sky_transition_time - 1.0).timeout.connect(_lightning_strike)
	
func _start_plane_flight() -> void:
	var base_y := plane.position.y
	bob.tween_property(plane, "position:y", base_y - 8.0, 1.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	bob.tween_property(plane, "position:y", base_y + 8.0, 1.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _plane_down():
	bob.kill()
	smoke_particle_1.emitting = true
	smoke_particle_2.emitting = true
	var target_y := _viewport_size.y + plane_down_offset
	var tween := create_tween()
	tween.tween_property(plane, "position:y", target_y, plane_down_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.finished.connect(func() -> void:
		sky.color = BLACKOUT_COLOR
		get_tree().create_timer(1.0).timeout.connect(func() -> void: get_tree().change_scene_to_file("res://main_game.tscn"))
	)

func _lightning_strike() -> void:
	var flash_tween := create_tween()
	flash_tween.tween_property(lightning_flash, "color:a", 0.8, 0.05)
	flash_tween.tween_property(lightning_flash, "color:a", 0.0, 0.1)

	flash_tween.tween_interval(0.08)
	flash_tween.tween_callback(func() -> void: lightning.visible = true)
	flash_tween.tween_property(lightning_flash, "color:a", 0.7, 0.04)
	flash_tween.tween_callback(func() -> void: lightning.visible = false)
	flash_tween.tween_property(lightning_flash, "color:a", 0.0, 0.2)

	flash_tween.tween_interval(0.05)
	flash_tween.tween_property(lightning_flash, "color:a", 0.4, 0.02)
	flash_tween.tween_property(lightning_flash, "color:a", 0.0, 0.2)
