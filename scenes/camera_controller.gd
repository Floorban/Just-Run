extends Node2D

@export var target: Node2D
@onready var camera: Camera2D = $Camera

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	camera.global_position = lerp(camera.global_position, target.global_position, delta * 50.0)
