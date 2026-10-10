extends Node

@onready var animationplayer1 = $AnimationPlayer
@onready var animationplayer2 = $AnimationPlayer2
@onready var oscarsanimations = $Oscar/AnimatedSprite2D
@onready var dialoguebox = $GUI/TextureRect
@onready var label1 = $GUI/TextureRect/Label
@onready var label2 = $GUI/TextureRect/Label2
@onready var label4 = $GUI/TextureRect/Label4
@onready var paper = $GUI/Paper
@onready var oscar = $Oscar

var cutscene1Finished = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cutscene1Finished = false
	oscar.position.x = 494
	oscar.position.y = 213
	paper.hide()
	dialoguebox.hide()
	label1.hide()
	label2.hide()
	label4.hide()
	await get_tree().create_timer(1).timeout
	dialoguebox.show()
	label1.show()
	await get_tree().create_timer(2).timeout
	dialoguebox.hide()
	label1.hide()
	animationplayer1.play("new_animation")
	oscarsanimations.play("walk")
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_animation_finished(_anim_name: String) -> void:
	oscarsanimations.stop()
	dialoguebox.show()
	label2.show()
	await get_tree().create_timer(2).timeout
	dialoguebox.hide()
	label2.hide()
	paper.z_index = 3
	paper.show()
	await get_tree().create_timer(5).timeout
	paper.hide()
	dialoguebox.show()
	label4.show()
	await get_tree().create_timer(1).timeout
	animationplayer2.play("exitscene")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://cutscene2.tscn")
