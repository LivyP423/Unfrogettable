extends AnimatedSprite2D

var gamemaster = null
var id = ""
var face_down = true
var matched = false

func _ready() -> void:
	if has_node("button"):
		$button.pressed.connect(_on_button_pressed)
	
	# If spawned face up, ensure it displays the assigned animation immediately
	if not face_down and id != "":
		play(id)

func _on_button_pressed() -> void: 
	if gamemaster and gamemaster.has_method("my_turn"):
		gamemaster.my_turn(self)

func flip_face_down() -> void:
	play_reversed(id)

func play_reversed(anim_name: String) -> void:
	if not sprite_frames or not sprite_frames.has_animation(anim_name):
		return
		
	animation = anim_name
	var count = sprite_frames.get_frame_count(anim_name)
	for i in range(count - 1, -1, -1):
		frame = i
		await get_tree().create_timer(0.07).timeout
	face_down = true
