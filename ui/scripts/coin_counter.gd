extends Sprite2D
var coins: int = 0
@onready var text = $RichTextLabel

func count():
	if coins < 9999:
		coins += 1
		text.text = str(coins)
