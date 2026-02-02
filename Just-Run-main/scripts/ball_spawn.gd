extends Area2D

@export var spawn_time := 2.0
@export var ball_scene : PackedScene

@onready var ball_spawn_timer: Timer = $ball_spawn_timer
@onready var col: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	ball_spawn_timer.timeout.connect(_on_timer_timeout)
	ball_spawn_timer.start(spawn_time)

func _on_timer_timeout():
	var ball = ball_scene.instantiate()
	var ext = col.shape.extents
	var pos = Vector2(randf_range(-ext.x, ext.x), randf_range(-ext.y, ext.y))
	ball.position = pos
	add_child(ball)
