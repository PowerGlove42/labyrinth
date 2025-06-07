extends Area2D
enum animations {
	black_white,
	blue_red,
	cyan_orange,
	green_purple,
	green_red,
	purple_orange,
	yellow_purple
}
@export var other_portal:Node2D = self
@export var current_animation:animations = animations.black_white
@onready var animation_player = $AnimationPlayer
@onready var line = $Line2D
var recieved:bool = false
var visited:bool = false

func change_anim(number:int):
	match number:
		0:
			animation_player.play("black_white")
		1:
			animation_player.play("blue_red")
		2:
			animation_player.play("cyan_orange")
		3:
			animation_player.play("green_purple")
		4:
			animation_player.play("green_red")
		5:
			animation_player.play("purple_orange")
		6:
			animation_player.play("yellow_purple")

func _ready() -> void:
	change_anim(current_animation)
	if other_portal:
		line.update_line(other_portal)
		idle()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_character"):
		if recieved:
			pass
		else:
			if other_portal.is_in_group("portal"):
				other_portal.recieve()
				body.teleport(other_portal)

func recieve():
	recieved = true


func _on_body_exited(body: Node2D) -> void:
	recieved = false
	idle()

func trigger(next:Node2D = other_portal):
	if next:
		if next.is_in_group("portal"):
			other_portal = next
			current_animation = other_portal.current_animation
			change_anim(current_animation)
			update(other_portal)
			line.update_line(other_portal)



func update(origin:Area2D = self, depth:int = 5):
	if depth > 0:
		current_animation = origin.current_animation
		change_anim(current_animation)
		other_portal.update(origin, depth -1)

func highlight():
	modulate.a = 1

func idle():
	if not recieved:
		modulate.a = 0.5

func _on_highlighter_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_character"):
		highlight()
		if other_portal:
			other_portal.highlight()

func _on_highlighter_body_exited(body: Node2D) -> void:
	if body.is_in_group("player_character"):
		idle()
		if other_portal:
			other_portal.idle()
