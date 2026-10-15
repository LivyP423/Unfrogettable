extends CharacterBody2D

@onready var flyAnim = $AnimatedSprite2D
@onready var greenStone = $Sprite2D
@onready var oscar = $"../Oscar"
@onready var box = $"../Oscar/Camera2D/GUI/TextureRect"
@onready var label = $"../Oscar/Camera2D/GUI/TextureRect/Label"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flyAnim.play("defeat")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	display()

func display():
	if gamemaster.gemCount == 0 or gamemaster.gemCount == 1 or gamemaster.gemCount == 2:
		flyAnim.play("defeat")
		rotation_degrees = 0
		greenStone.show()
	else:
		flyAnim.play("defeat")
		rotation_degrees = -75
		greenStone.hide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == oscar:
		if gamemaster.gemCount == 0:
			box.z_index = 10
			label.z_index = 11
			box.show()
			label.add_theme_color_override("font_color", Color.MIDNIGHT_BLUE)
			label.text = "You'll never get my pretty\nrock!"
			label.show()
			await get_tree().create_timer(2).timeout
			label.hide()
			box.hide()
		elif gamemaster.gemCount == 1:
			box.z_index = 10
			label.z_index = 11
			box.show()
			label.add_theme_color_override("font_color", Color.MIDNIGHT_BLUE)
			label.text = "You're still not worth my\ntime, come back when you\nare stronger."
			label.show()
			await get_tree().create_timer(2).timeout
			label.hide()
			box.hide()
		elif gamemaster.gemCount == 2:
			box.z_index = 10
			label.z_index = 11
			box.show()
			label.add_theme_color_override("font_color", Color.BLACK)
			label.text = "UNHAND MY GEMSTONE YOU FOUL\nFLY!"
			label.show()
			await get_tree().create_timer(2).timeout
			label.hide()
			box.hide()
			await get_tree().create_timer(1).timeout
			box.show()
			label.add_theme_color_override("font_color", Color.MIDNIGHT_BLUE)
			label.text = "Nuh uh, I found it fair and\nsquare. Plus it's green, my\nfavorite color!"
			label.show()
			await get_tree().create_timer(2).timeout
			label.hide()
			box.hide()
			await get_tree().create_timer(1).timeout
			box.show()
			label.add_theme_color_override("font_color", Color.BLACK)
			label.text = "It's my favorite color, too,\nso I'm not leaving here\nwithout it!"
			label.show()
			await get_tree().create_timer(2).timeout
			label.hide()
			box.hide()
			get_tree().change_scene_to_file("res://level_3.tscn")
		else:
				greenStone.hide()
				label.text = "Ugh..."
				label.add_theme_color_override("font_color", Color.MIDNIGHT_BLUE)
				box.show()
				label.show()
				box.z_index = 10
				label.z_index = 11
				await get_tree().create_timer(2.0).timeout
				box.hide()
				label.hide()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == oscar:
		await get_tree().create_timer(1).timeout
		box.hide()
		label.hide()
