extends Node2D

@export var target: Node2D
@onready var camera: Camera2D = $Camera
var follow_damping := 10.0

func _physics_process(delta: float) -> void:
	camera.global_position = lerp(camera.global_position, target.global_position, delta * follow_damping)
