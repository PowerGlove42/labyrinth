extends CharacterBody2D
@export var MAX_SPEED = 50
@export var SPRINT_SPEED = 70
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@export var respawn_location: Node2D
@export_file() var level_selector = "res://levels/scenes/level_selector.tscn"
@onready var smoke = $Smoke
@onready var win_timer = $WinDelay
@onready var smoke_timer = $SmokeTimer
@onready var smoke_warning_timer = $SmokeWarningTimer
@onready var warning_animation = $Warning
@onready var walk_sound = $Walk
@onready var soundtrack = $Soundtrack
@onready var item_slot = $ItemSlot
@onready var camera = $Camera2D
@onready var lung = $Lung
signal player_death
var rooted:bool = false
var smoke_time:float = 10

func _ready() -> void:
	smoke.play("default")
	soundtrack.play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("respawn"):
		kill()
	if Input.is_action_just_pressed("smoke"):
		smoke_now()
	if Input.is_action_just_pressed("exit"):
		call_deferred("quit")
	if Input.is_action_just_pressed("drop"):
		zoom_out(true)
	elif Input.is_action_just_released("drop"):
		zoom_out(false)
	pass

func _physics_process(delta: float) -> void:
	lung.global_position = get_viewport().get_camera_2d().get_screen_center_position() - Vector2(60, 40)
	var input_vector = Input.get_vector("left", "right", "up", "down", -1)
	if rooted:
		velocity = Vector2.ZERO
	else:
		if Input.is_action_pressed("sprint"):
			velocity.y = lerp(velocity.y, input_vector.y * SPRINT_SPEED, 1)
			velocity.x = lerp(velocity.x, input_vector.x * SPRINT_SPEED, 1)
		else:
			velocity.y = lerp(velocity.y, input_vector.y * MAX_SPEED, 1)
			velocity.x = lerp(velocity.x, input_vector.x * MAX_SPEED, 1)
	
	if velocity.length() != 0:
		item_slot.position = input_vector * 8
		if walk_sound.playing == false:
			walk_sound.play()
	else:
		walk_sound.stop()
	animation_tree.set("parameters/blend_position", velocity.normalized())
	move_and_slide()

func zoom_out(val:bool = false):
	if val:
		camera.zoom = Vector2(1, 1)
		camera.global_position = Vector2.ZERO
		rooted = true
	else:
		camera.zoom = Vector2(2.5, 2.5)
		camera.position = Vector2.ZERO
		rooted = false

func quit():
	get_tree().change_scene_to_file(level_selector)

func kill():
	rooted = true
	animation_tree.active = false
	animation_player.play("die")

func reset():
	call_deferred("emit_signal", "player_death")

func teleport(target:Node2D):
	global_position = target.global_position

func win():
	rooted = true
	smoke_timer.stop()
	smoke.play("smoke")
	win_timer.start()

func smoke_now():
	if smoke.animation == "smoke":
		pass
	else:
		smoke_time *= 0.97
		if smoke_time > 3:
			smoke_warning_timer.start(smoke_time - 3)
			warning_animation.play("none")
			lung.update(10 - 3, smoke_time - 3,)
		else:
			lung.update(1, 0)
		smoke_timer.start(smoke_time)
		smoke.play("smoke")

func _on_win_delay_timeout() -> void:
	call_deferred("quit")

func _on_smoke_timer_timeout() -> void:
	kill()


func _on_smoke_warning_timer_timeout() -> void:
	warning_animation.play("warn")

func _on_smoke_animation_finished() -> void:
	smoke.play("default")

func trigger(node:Node2D = null):
	kill()
