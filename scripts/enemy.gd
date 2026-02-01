extends Area2D

@export var kill_speed = 100.0
@export var kill_reward = kill_speed / 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body):
	if body is Player:
		if body.speed > kill_speed:
			body.kill_enemy(kill_reward)
			print("enemy died")
			queue_free()
