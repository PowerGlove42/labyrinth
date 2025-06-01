extends Button
@export_file() var level_path

func _on_pressed() -> void:
	get_tree().change_scene_to_file(level_path)
