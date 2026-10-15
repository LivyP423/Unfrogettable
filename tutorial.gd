extends TextureRect
@onready var tutorialBox = $"."
@onready var tutorialLabel = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var active_scene = get_tree().current_scene
	if active_scene.scene_file_path == "res://level_1.tscn":
		tutorialBox.show()
		tutorialLabel.show()
		await get_tree().create_timer(7).timeout
		tutorialBox.hide()
		tutorialLabel.hide()
	elif active_scene.scene_file_path == "res://level_2.tscn":
		tutorialBox.show()
		tutorialLabel.text = "Now, you only \nhave 10 seconds\n per turn!"
		tutorialLabel.show()
		await get_tree().create_timer(7).timeout
		tutorialBox.hide()
		tutorialLabel.hide()
	else:
		tutorialLabel.add_theme_color_override("font_color", Color.MIDNIGHT_BLUE)
		tutorialBox.hide()
		tutorialLabel.hide()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
