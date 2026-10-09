extends CharacterBody2D

@onready var oscar = $"../Oscar"
@onready var box = $"../GUI/TextureRect"
@onready var label = $"../GUI/TextureRect/Label"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void: # PINKFlyGuy Area
	if body == oscar:
		label.text = "Uh oh, it's Knight Oscar! Stay\naway from my pink stone!"
		label.add_theme_color_override("font_color", Color.DARK_MAGENTA)
		box.show()
		label.show()
		await get_tree().create_timer(3.0).timeout
		label.add_theme_color_override("font_color", Color.BLACK)
		label.text = "It's mine, it came from my
		key!"
		await get_tree().create_timer(3.0).timeout
		label.text = "Let's battle for it!"
		await get_tree().create_timer(3.0).timeout
		label.hide()
		box.hide()
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == oscar:
		await get_tree().create_timer(0.5).timeout
		box.hide()
		label.hide()
