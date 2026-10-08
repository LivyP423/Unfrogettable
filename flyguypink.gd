extends CharacterBody2D
@onready var oscar = $"../Oscar"
@onready var box = $"../GUI/TextureRect"
@onready var label = $"../GUI/TextureRect/Label"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void: #PINKFlyGuy Area
	if body == oscar:
		box.show()
		label.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == oscar:
		await get_tree().create_timer(.5).timeout
		box.hide()
		label.hide()
