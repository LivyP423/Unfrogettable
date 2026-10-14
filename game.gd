extends Node2D

@onready var oscar = $Oscar
@onready var flyguy = $flyguypink
@onready var box = $Oscar/Camera2D/GUI/TextureRect
@onready var label = $Oscar/Camera2D/GUI/TextureRect/Label
@onready var swordMarker = $Oscar/AnimatedSprite2D/Marker2D
@onready var castle = $world/Castle
@onready var castlePink = $world/Castle/pinkStone
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	castlePink.hide()
	swordMarker.position.x = 9.442
	swordMarker.position.y = 3.433
	box.hide()
	label.hide()
	oscar.scale.x = 1.75
	oscar.scale.y = 1.75
	flyguy.scale.x = 1.55
	flyguy.scale.y = 1.55
	

func castleDisplay():
	match gamemaster.gemCount:
		0:
			castlePink.hide()
		1:
			castlePink.show()
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	castleDisplay()
