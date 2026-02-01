extends Area2D

@export var speed_rate : float = 0.2
@export var duration := 2.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if body is Player:
		body.speed_up(speed_rate, duration)
	queue_free()
