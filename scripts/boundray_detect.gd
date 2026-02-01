extends Area2D

@export var win_speed := 300.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	pass

#collision shape是boundary就就不得行 已修复 👍大拇哥
func _on_body_entered(body):
	if body is Player:
		if body.speed > win_speed:
			print("you win!")
