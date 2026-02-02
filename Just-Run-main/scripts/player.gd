class_name Player extends CharacterBody2D

var is_dead := false
@export var min_move_dist := 100.0

var base_speed := 100.0
@export var current_speed := 100.0
var target_speed := 0.0
var acc_time = 10.0
@onready var speed_up_duration: Timer = $speed_up_duration
@export var hp_bar: ProgressBar
@export var lose_hp_speed := 20.0
@export var lowest_limit_speed := 90.0
@export var speed_time_rate := 2.0
@export var speed_label : Label
@export var limit_speed_label : Label

func _ready() -> void:
	hp_bar.value = 100.0
	speed_up_duration.timeout.connect(_on_timer_timeout)
	target_speed = current_speed

func _process(delta: float) -> void:
	speed_label.text = "speed : " + str(round(velocity.length()))
	limit_speed_label.text = "limit speed : " + str(round(lowest_limit_speed))
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
		current_speed = lerp(current_speed, target_speed, delta * acc_time)
		velocity = direction.normalized() * current_speed 
	else:
		velocity = direction.normalized() * current_speed * (distance/min_move_dist)
	
	lowest_limit_speed += speed_time_rate * delta
	move_and_slide()

func speed_up(speed_rate : float, duration : float):
	target_speed = target_speed * (1 + speed_rate)
	current_speed = target_speed * acc_time/4
	speed_up_duration.start(duration)
	#hp_bar.value += hp_bar.max_value * speed_rate #这个可能有问题你可以研究一哈                     没懂 现在就是吃了可以回20血 不晓得你要实现啥子
	print("speed is ",target_speed)

func _on_timer_timeout():
	target_speed = base_speed
	speed_up_duration.stop()
	print("current_speed up finish  speed is ",target_speed)

#最后 所有的加速度相关的都call上面那个speed up不要这里那里都在加速度后面没法dubug
# zhe ge you wenti
# 这里也在改速度 那里也在改
func kill_enemy(reward: float):
	base_speed += reward
	target_speed = base_speed
	print("you recevied ",reward,"base speed up "," speed is ",target_speed)

func player_dead() -> void:
	if is_dead:
		return
	velocity = Vector2.ZERO
	is_dead = true
	print("--------------Game Over----------------")
