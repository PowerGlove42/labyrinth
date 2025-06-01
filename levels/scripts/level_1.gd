extends Node2D


func _on_player_character_player_death() -> void:
	get_tree().reload_current_scene()
