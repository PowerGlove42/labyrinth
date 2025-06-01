extends Area2D
@onready var animation = $AnimatedSprite2D
signal win
func _ready() -> void:
	animation.play("default")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_character"):
		body.win()
