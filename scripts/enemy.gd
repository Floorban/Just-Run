extends Area2D

@export var kill_speed = 100.0
@export var kill_reward = kill_speed / 5

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is Player:
		if body.speed >= kill_speed:
			body.kill_enemy(kill_reward)
			print("enemy died")
			queue_free()
