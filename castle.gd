extends AnimatedSprite2D

@onready var castlePink = $pinkStone
@onready var castleBlue = $blueStone
@onready var castleGreen = $greenStone
@onready var castle = %Castle
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	castle.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	castleDisplay()

func castleDisplay():
	match gamemaster.gemCount:
		0:
			castlePink.hide()
			castleBlue.hide()
			castleGreen.hide()
			castle.play("default")
		1:
			castlePink.show()
			castleBlue.hide()
			castleGreen.hide()
			castle.play("default")
		2:
			castlePink.show()
			castleBlue.show()
			castleGreen.hide()
			castle.play("default")
		3:
			castlePink.show()
			castleBlue.show()
			castleGreen.show()
			castle.play("unlocked")
		
