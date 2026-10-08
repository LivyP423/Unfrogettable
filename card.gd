extends AnimatedSprite2D

var gamemaster = null
var id = ""
var face_down = true
var matched = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$button.pressed.connect(_on_button_pressed)

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_pressed() -> void: #Button uses code from gamemaster
	gamemaster.my_turn(self)

func play_reversed(anim_name: String) -> void:
	animation = anim_name
	var count = sprite_frames.get_frame_count(anim_name)
	for i in range(count - 1, -1, -1):
		frame = i
		await get_tree().create_timer(0.07).timeout
		face_down = true
