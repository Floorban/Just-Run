extends Area2D
@export var win_speed := 300.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#没弄起
func _on_body_entered(body):
	print("2")
	if body is Player:
		print("1")
		if body.speed > win_speed:
			print("you win!")
