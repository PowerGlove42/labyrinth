extends Area2D
@onready var animation = $Animation
@onready var collision = $CollisionShape2D
@onready var marker = $Marker2D

func _ready() -> void:
	animation.play("no_bridge")

func trigger(node:Node2D = null):
	animation.play("bridge")
	collision.set_deferred("disabled", true)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_character"):
		collision.set_deferred("disabled", true)
		body.global_position = marker.global_position
		body.kill()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("ladder"):
		trigger()
		area.call_deferred("queue_free")
