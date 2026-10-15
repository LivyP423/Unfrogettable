extends CharacterBody2D

@onready var oscar = $"../Oscar"
@onready var box = $"../Oscar/Camera2D/GUI/TextureRect"
@onready var label = $"../Oscar/Camera2D/GUI/TextureRect/Label"
@onready var flyAnim = $AnimatedSprite2D
@onready var stone = $Sprite2D
@onready var blueStone = $Sprite2D

# Track dialogue state to prevent overlapping timer bugs
var dialogue_active: bool = false

func _ready() -> void:
	flyAnim.show()
	flyAnim.play("default")
	display()

func _process(_delta: float) -> void:
	display()

func _on_area_2d_body_entered(body: Node2D) -> void: # PINKFlyGuy Area
	if body == oscar:
		match gamemaster.gemCount:
			0:
				stone.show()
				dialogue_active = true
				label.text = "You're too weak to go \nagainst the likes of I!"
				label.add_theme_color_override("font_color", Color.DARK_RED)
				box.show()
				label.show()
				await get_tree().create_timer(2.0).timeout
			1:
				stone.show()
				dialogue_active = true
				label.text = "Even with that stone, \nyou're no match for me!"
				label.add_theme_color_override("font_color", Color.DARK_RED)
				box.show()
				label.show()
				await get_tree().create_timer(2.0).timeout
				get_tree().change_scene_to_file("res://level_2.tscn")
			2,3:
				stone.hide()
				dialogue_active = true
				label.text = "Ugh..."
				label.add_theme_color_override("font_color", Color.DARK_RED)
				box.show()
				label.show()
				box.z_index = 10
				label.z_index = 11
				await get_tree().create_timer(2.0).timeout
				box.hide()
				label.hide()
				if not dialogue_active: return
				

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == oscar:
		dialogue_active = false
		await get_tree().create_timer(0.25).timeout
		if not dialogue_active:
			_hide_dialogue()


func _hide_dialogue() -> void:
	if is_instance_valid(box):
		box.hide()
	if is_instance_valid(label):
		label.hide()

func display():
	if gamemaster.gemCount == 0 or gamemaster.gemCount == 1:
		flyAnim.play("default")
		rotation_degrees = 0
		blueStone.show()
	else:
		flyAnim.play("defeat")
		rotation_degrees = -75
		blueStone.hide()
