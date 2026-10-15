extends CanvasLayer

@onready var gemstone = $Gemstone
@onready var key = $key

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gemDisplay()

func gemDisplay():
	# The win screen shows BEFORE gemCount goes up, so gemCount can't tell
	# us which level we won — the scene name can.
	match get_tree().current_scene.name:
		"Level2":
			gemstone.play("blue")
			key.play("shineBlue")
		"Level1":
			gemstone.play("pink")
			key.play("shine")
		"Level3":
			gemstone.play("green")
			key.play("shineGreen")
