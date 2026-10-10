extends CharacterBody2D


@onready var heart = $heart
var health = gamemaster.oscarHealth


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heart.value = health
	position.x = 359.0
	position.y = 109.0

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
