extends CharacterBody2D

@export var speed: float = 300.0
@onready var animation = $AnimatedSprite2D

var is_moving: bool = false

func _physics_process(_delta: float) -> void:
	# 1. Handle movement input and cutscene check
	if get_tree().current_scene.name != "cutscene_1":
		var input_direction := Input.get_vector("left", "right", "up", "down")
		velocity = input_direction * speed
	else:
		velocity = Vector2.ZERO # Stop movement during cutscenes
	
	# 2. Move the character and handle wall collisions
	move_and_slide()
	
	# 3. Track if the character's movement state changed
	# (velocity.length() > 0 tells us if they are moving)
	var current_moving_state = velocity.length() > 0
	
	if current_moving_state != is_moving:
		if current_moving_state == true:
			animation.play("walk")
		else:
			animation.play("default") # This acts as your idle animation
			
		# Update the tracker for the next frame
		is_moving = current_moving_state
