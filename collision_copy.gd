extends StaticBody2D
@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D

func _ready():
	polygon_2d.polygon = collision_polygon_2d.polygon
	polygon_2d.position = collision_polygon_2d.position
	collision_polygon_2d.build_mode = CollisionPolygon2D.BUILD_SEGMENTS
