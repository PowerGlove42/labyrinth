extends Area2D
@onready var spright = $Sprite2D
@export var target0: Node2D = null
@export var trigger_value0: Node2D = null
@export var target1: Node2D = null
@export var trigger_value1: Node2D = null
@onready var blue_line = $BlueLine
@onready var yellow_line = $YellowLine
var mode = 0
signal button_activated
var is_ready:bool = true

func _ready() -> void:
	if target0 and trigger_value0:
		yellow_line.update_line(target0, trigger_value0)
	elif target0:
		yellow_line.update_line(target0, null)
	
	if target1 and trigger_value1:
		blue_line.update_line(target1, trigger_value1)
	elif target1:
		blue_line.update_line(target1, null)
	blue_line.disable()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_character") and is_ready:
		is_ready = false
		if mode == 0:
			if target0.has_method("trigger"):
				target0.trigger(trigger_value0)
				yellow_line.disable()
				blue_line.enable()
			mode = 1
			spright.frame = 1
		elif mode ==1:
			if target1.has_method("trigger"):
				target1.trigger(trigger_value1)
				blue_line.disable()
				yellow_line.enable ()
			mode = 0
			spright.frame = 0


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player_character"):
		is_ready = true
