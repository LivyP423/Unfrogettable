extends AnimatedSprite2D

@onready var castlePink = $pinkStone
@onready var castleBlue = $blueStone
@onready var castleGreen = $greenStone
@onready var castle = %Castle
@onready var oscar = get_node_or_null("../Oscar")
@onready var box = get_node_or_null("../Oscar/Camera2D/GUI/TextureRect")
@onready var label = get_node_or_null("../Oscar/Camera2D/GUI/TextureRect/Label")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	castle.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	castleDisplay()

func castleDisplay():
	match gamemaster.gemCount:
		0:
			castlePink.hide()
			castleBlue.hide()
			castleGreen.hide()
			castle.play("default")
		1:
			castlePink.show()
			castleBlue.hide()
			castleGreen.hide()
			castle.play("default")
		2:
			castlePink.show()
			castleBlue.show()
			castleGreen.hide()
			castle.play("default")
		3:
			castlePink.show()
			castleBlue.show()
			castleGreen.show()
			castle.play("unlocked")



func _on_area_2d_body_entered(body: Node2D) -> void:
	if oscar != null and body == oscar:
		if gamemaster.gemCount == 3:
			get_tree().change_scene_to_file("res://cutscene_3.tscn")
		elif box != null and label != null:
			box.show()
			label.text = "It's locked, I don't\nhave enough stones!"
			label.show()
			await get_tree().create_timer(3).timeout
			box.hide()
			label.hide()



func _on_area_2d_body_exited(body: Node2D) -> void:
	if oscar != null and body == oscar:
		if box != null and box.visible:
			box.hide()
		if label != null and label.visible:
			label.hide()
