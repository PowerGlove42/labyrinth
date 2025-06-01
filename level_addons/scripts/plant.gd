extends Area2D
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("bite")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_character"):
		body.kill()

func kill():
	animation_player.play("die")

func despawn():
	call_deferred_thread_group("queue_free")

func trigger(trigger_value = null):
	kill()
