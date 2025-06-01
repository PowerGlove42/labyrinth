extends Area2D
var occupied:bool = false
var item:Area2D = null

func drop():
	if item:
		item.queue_free()
		occupied = false
		item = null

func _on_area_entered(area: Area2D) -> void:
	if not occupied:
		if area.is_in_group("items"):
			occupied = true
			if area.get_parent():
				area.get_parent().remove_child(area)
				item = area
			call_deferred("add_child", area)
			area.position = Vector2.ZERO

func _on_child_exiting_tree(node: Node) -> void:
	if node.is_in_group("items"):
		print ("in items")
		occupied = false
		item = null
