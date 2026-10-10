extends Control
class_name Card

var gamemaster = null
var id: String = ""
var face_down: bool = true
var matched: bool = false

var sprite: AnimatedSprite2D
var button: Button


func _init() -> void:
	# Reserves grid slot size so layout stays fixed
	custom_minimum_size = Vector2(80, 100)


func _ready() -> void:
	# 1. Setup Sprite Node
	sprite = AnimatedSprite2D.new()
	
	# Load or assign your SpriteFrames resource here:
	sprite.sprite_frames = load("res://cardAnims.tres")
	
	sprite.position = custom_minimum_size / 2
	sprite.scale = Vector2(2.5, 2.5)
	add_child(sprite)

	# 2. Setup Overlay Button
	button = Button.new()
	button.set_anchors_preset(Control.PRESET_FULL_RECT)
	button.flat = true
	button.pressed.connect(_on_button_pressed)
	add_child(button)

	if not face_down and id != "":
		play(id)


func _on_button_pressed() -> void:
	if gamemaster and gamemaster.has_method("my_turn"):
		gamemaster.my_turn(self)


func play(anim_name: String) -> void:
	if sprite and sprite.sprite_frames and sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)


func flip_face_down() -> void:
	play_reversed(id)


func play_reversed(anim_name: String) -> void:
	if not sprite or not sprite.sprite_frames or not sprite.sprite_frames.has_animation(anim_name):
		face_down = true
		return
		
	sprite.animation = anim_name
	var count = sprite.sprite_frames.get_frame_count(anim_name)
	for i in range(count - 1, -1, -1):
		sprite.frame = i
		await get_tree().create_timer(0.07).timeout
	face_down = true
