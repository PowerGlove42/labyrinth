extends Area2D
@onready var spright = $Sprite2D
var done = false
@export var target: Node2D = null
@export var trigger_value: Node2D = null
signal button_activated

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_character"):
		if not done:
			done = true
			if target:
				if target.has_method("trigger"):
					target.trigger(trigger_value)
			spright.frame = 5
			emit_signal("button_activated")
