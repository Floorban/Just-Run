extends Area2D

@export var is_static := false
var og_pos : Vector2
@export var respawn_delay := 2.0

@export var speed_rate := 0.2
@export var duration := 2.0

func _ready() -> void:
	og_pos = global_position
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if not visible:
		return
	if body is Player:
		body.speed_up(speed_rate, duration)
	#你放在条件外面意思是任何东西撞到都要消失哦，莫到时候又ei啷个有bug也
	#okok 晓得
	#敌人也可以吃 和你抢
	#okok 不影响你
	#queue_free()
	free_speed_ball()

func free_speed_ball() -> void:
	if is_static:
		hide_ball(true)
		respawn()
		return
	queue_free()

#给关卡里面的固定球 重新生成
func respawn() -> void:
	await get_tree().create_timer(respawn_delay).timeout
	global_position = og_pos
	hide_ball(false)

func hide_ball(hide: bool) -> void:
	visible = !hide
	#process_mode = Node.PROCESS_MODE_DISABLED if hide else PROCESS_MODE_INHERIT
