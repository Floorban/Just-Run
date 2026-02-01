extends CharacterBody2D
class_name Player
var initial_speed := 100.0
@export var speed := 100.0
var target_speed := 0.0
var acc_time = 10.0
@onready var speed_up_duration: Timer = $speed_up_duration
@onready var hp: ProgressBar = $hp
@export var hp_decrease := 20.0
@export var lowest_limit_speed := 90.0
@export var speed_time_rate := 1.0

func _ready() -> void:
	hp.value = 100.0
	speed_up_duration.timeout.connect(_on_timer_timeout)
	target_speed = speed

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	var distance = direction.length()
	if distance > 5:
		speed = lerp(speed, target_speed, delta * acc_time)
		velocity = direction.normalized() * speed 
	else:
		velocity = Vector2.ZERO
	
	lowest_limit_speed += speed_time_rate * delta
	move_and_slide()
	if velocity.length() < lowest_limit_speed:
		hp.value -= hp_decrease * delta
		if hp.value == 0:
			#print("die")
			pass

func speed_up(speed_rate : float, duration : float):
	target_speed = target_speed * (1 + speed_rate)
	print(target_speed)
	speed = target_speed * acc_time/4
	speed_up_duration.start(duration)

func _on_timer_timeout():
	speed = initial_speed
	target_speed = initial_speed
	speed_up_duration.stop()
	print("speed up finish. current speed is ",speed)
	
func kill_enemy(reward: float):
	initial_speed += reward
	speed = initial_speed
	target_speed = initial_speed
	print("you recevied ",reward," speed up")
