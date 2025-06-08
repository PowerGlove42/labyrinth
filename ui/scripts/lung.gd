extends Sprite2D
@onready var mask = $Mask

func _ready() -> void:
	mask.modulate.a = 0

func update(max:float = 0, current:float = 0):
	if max > 0:
		mask.modulate.a = 1 - current/max
