extends CharacterBody2D

@onready var heart = $"../heartFly"
@onready var flyAnim = $AnimatedSprite2D
var health = gamemaster.flyHealth

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = gamemaster.maxHealth
	heart.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	health = gamemaster.flyHealth
	heart.value = gamemaster.flyHealth
