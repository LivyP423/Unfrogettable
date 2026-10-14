extends Node2D

@onready var oscar = $Oscar
@onready var flyguy = $flyguypink
@onready var box = $Oscar/Camera2D/GUI/TextureRect
@onready var label = $Oscar/Camera2D/GUI/TextureRect/Label
@onready var swordMarker = $Oscar/AnimatedSprite2D/Marker2D

# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	swordMarker.position.x = 9.442
	swordMarker.position.y = 3.433
	box.hide()
	label.hide()
	oscar.scale.x = 1.75
	oscar.scale.y = 1.75
	flyguy.scale.x = 1.55
	flyguy.scale.y = 1.55
	
