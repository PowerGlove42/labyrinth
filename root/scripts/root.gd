extends Node2D

@onready var world = $YSort
func kill_all_enemies():
	for child in world.get_children():
		print(child)
		if child.is_in_group("enemies"):
			print(child)
			child.kill()

func _on_player_button_button_activated() -> void:
	kill_all_enemies()


func _on_player_character_player_death() -> void:
	get_tree().reload_current_scene()
