extends CharacterBody2D

@export var speed: float = 300.0
@onready var marker = $AnimatedSprite2D/Marker2D
@onready var sword = get_node_or_null("sword")
@onready var shield = $shield
@onready var anim = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	if get_tree().current_scene.name != "cutscene_1":
		var input_direction := Input.get_vector("left", "right", "up", "down")
		velocity = input_direction * speed
	else:
		velocity = Vector2.ZERO # Stop movement during cutscenes
	move_and_slide()
	if velocity != Vector2.ZERO:
		anim.play("walk")
	else:
		anim.play("default")
		

	# Sword follows the marker 
	if is_instance_valid(sword):
		sword.global_position = marker.global_position
