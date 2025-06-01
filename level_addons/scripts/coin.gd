extends Area2D

@onready var animation = $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer2D
@onready var collission = $CollisionShape2D
@onready var shadow = $Sprite2D

func _ready() -> void:
	animation.play("default")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_character"):
		animation.play("off")
		collission.set_deferred("disabled", true)
		#collission.disabled = true
		shadow.texture = null
		audio.play()

func _on_audio_stream_player_2d_finished() -> void:
	call_deferred("queue_free")
