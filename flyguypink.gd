extends CharacterBody2D

@onready var oscar = $"../Oscar"
@onready var box = $"../Oscar/Camera2D/GUI/TextureRect"
@onready var label = $"../Oscar/Camera2D/GUI/TextureRect/Label"

# Track dialogue state to prevent overlapping timer bugs
var dialogue_active: bool = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void: # PINKFlyGuy Area
	if body == oscar:
		dialogue_active = true
		
		label.text = "Uh oh, it's Knight Oscar! Stay\naway from my pink stone!"
		label.add_theme_color_override("font_color", Color.DARK_MAGENTA)
		box.show()
		label.show()
		
		await get_tree().create_timer(2.0).timeout
		if not dialogue_active: return # Stop if player left area
		label.add_theme_color_override("font_color", Color.BLACK)
		label.text = "It's mine, it came from my\nkey!"
		await get_tree().create_timer(2.0).timeout
		if not dialogue_active: return
		label.text = "Let's battle for it!"
		await get_tree().create_timer(2.0).timeout
		if not dialogue_active: return
		_hide_dialogue()
		get_tree().change_scene_to_file("res://level_1.tscn")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == oscar:
		dialogue_active = false
		await get_tree().create_timer(0.5).timeout
		if not dialogue_active:
			_hide_dialogue()

func _hide_dialogue() -> void:
	if is_instance_valid(box):
		box.hide()
	if is_instance_valid(label):
		label.hide()
