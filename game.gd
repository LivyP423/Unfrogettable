extends Node2D

@onready var oscar = $Oscar
@onready var flyguy = $flyguypink
@onready var box = $GUI/TextureRect
@onready var label = $GUI/TextureRect/Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	box.hide()
	label.hide()
	oscar.scale.x = 1.75
	oscar.scale.y = 1.75
	flyguy.scale.x = 1.55
	flyguy.scale.y = 1.55
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
