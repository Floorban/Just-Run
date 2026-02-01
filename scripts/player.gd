class_name Player extends CharacterBody2D

var is_dead := false
@export var min_move_dist := 60.0

var initial_speed := 100.0
@export var speed := 100.0
var target_speed := 0.0
var acc_time = 10.0
@onready var speed_up_duration: Timer = $speed_up_duration

@export var hp_bar: ProgressBar
@export var lose_hp_speed := 20.0
@export var lowest_limit_speed := 100.0
@export var speed_time_rate := 1.0

func _ready() -> void:
	hp_bar.value = 100.0
	speed_up_duration.timeout.connect(_on_timer_timeout)
	target_speed = speed

func _process(delta: float) -> void:
	if velocity.length() < lowest_limit_speed and not is_dead:
		hp_bar.value -= lose_hp_speed * delta
		if hp_bar.value <= 0: player_dead()

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	var distance = direction.length()
	if distance > min_move_dist:
		speed = lerp(speed, target_speed, delta * acc_time)
		velocity = direction.normalized() * speed 
	else:
		velocity = Vector2.ZERO
	
	lowest_limit_speed += speed_time_rate * delta
	move_and_slide()

func speed_up(speed_rate : float, duration : float):
	target_speed = target_speed * (1 + speed_rate)
	speed = target_speed * acc_time/4
	speed_up_duration.start(duration)
	hp_bar.value += hp_bar.max_value * speed_rate #这个可能有问题你可以研究一哈
	print(target_speed)

func _on_timer_timeout():
	speed = initial_speed
	target_speed = initial_speed
	speed_up_duration.stop()
	print("speed up finish. current speed is ",speed)

#最后 所有的加速度相关的都call上面那个speed up不要这里那里都在加速度后面没法dubug
# zhe ge you wenti
# 这里也在改速度 那里也在改
func kill_enemy(reward: float):
	initial_speed += reward
	speed = initial_speed
	target_speed = initial_speed
	print("you recevied ",reward," speed up")

func player_dead() -> void:
	if is_dead:
		return
	velocity = Vector2.ZERO
	is_dead = true
	print("--------------Game Over----------------")
