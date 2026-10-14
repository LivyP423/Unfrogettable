extends CharacterBody2D

@onready var heart = $"../heart"
@onready var marker = $AnimatedSprite2D/Marker2D
@onready var sword = $AnimatedSprite2D/Marker2D/sword
@onready var animation = $AnimatedSprite2D

var health = gamemaster.oscarHealth
var last_fly_health: int = 3
var hitting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heart.value = health
	position.x = 359.0
	position.y = 109.0
	last_fly_health = gamemaster.flyHealth
	animation.animation_finished.connect(_on_animation_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	heart.value = gamemaster.oscarHealth
	# Oscar landed a hit (player matched a pair) -> play the hit animation
	if gamemaster.flyHealth != last_fly_health:
		if gamemaster.flyHealth < last_fly_health:
			hitting = true
			animation.play("hit")
		last_fly_health = gamemaster.flyHealth
	if hitting:
		hitMarkerPos()
	if is_instance_valid(sword):
		sword.global_position = marker.global_position

func hitMarkerPos():
	var currentFrame = animation.frame
	match currentFrame:
		0:
			marker.position.x = 15.73
			marker.position.y = 0.47
			sword.rotation_degrees = 15
		1:
			marker.position.x = 10.831
			marker.position.y = -3.433
			sword.rotation_degrees = 34
		2:
			marker.position.x = 11.163
			marker.position.y = -0.858
			sword.rotation_degrees = 54.4
		3:
			marker.position.x = 15.73
			marker.position.y = 0.47
			sword.rotation_degrees = 15

func _on_animation_finished():
	if animation.animation == "hit":
		hitting = false
		animation.play("default")
		marker.position.x = 15.73
		marker.position.y = 0.47
		sword.rotation_degrees = 15
