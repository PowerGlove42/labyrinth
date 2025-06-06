extends Line2D

var enabled:bool = true

func disable():
	enabled = false

func enable():
	enabled = true

func _ready() -> void:
	texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	visible = false
	z_index = 100

func update_line(target:Node2D = null, other_target:Node2D = null):
	if target and other_target:
		clear_points()
		add_point(Vector2.ZERO)
		add_point(target.global_position - global_position)
		add_point(other_target.global_position - global_position)
	elif target:
		clear_points()
		add_point(Vector2.ZERO)
		add_point(target.global_position - global_position)

func _process(delta: float) -> void:
	if Input.is_action_pressed("drop") and enabled:
		visible = true
	elif Input.is_action_just_released("drop"):
		visible = false
