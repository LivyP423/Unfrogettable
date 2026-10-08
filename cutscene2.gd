extends Node

@onready var animationplayer: AnimationPlayer = $AnimationPlayer
@onready var chest: AnimatedSprite2D = $chest
@onready var oscaranim: AnimatedSprite2D = $Oscar/AnimatedSprite2D
@onready var box = $GUI/TextureRect
@onready var label1 = $GUI/TextureRect/Label
@onready var key = $key
@onready var paper = $GUI/Paper
@onready var note = $GUI/Paper/Label3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	paper.hide()
	note.hide()
	key.hide()
	box.hide()
	label1.hide()
	animationplayer.animation_finished.connect(_on_animation_finished)
	animationplayer.play("new_animation")
	chest.play("default")
	oscaranim.play("walk")

func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"new_animation":
			_run_intro_cutscene()
		"collect":
			_on_collect_finished()

func _run_intro_cutscene() -> void:
	oscaranim.stop()
	chest.play("open")
	await get_tree().create_timer(1).timeout
	key.show()
	box.show()
	label1.show()
	await get_tree().create_timer(3).timeout
	label1.text = "Oh great, another note..."
	await get_tree().create_timer(2).timeout
	box.hide()
	label1.hide()
	paper.z_index = 10
	note.z_index = 11
	note.show()
	paper.show()
	await get_tree().create_timer(5).timeout
	note.hide()
	paper.hide()
	await get_tree().create_timer(1).timeout
	box.show()
	label1.text = "Looks like I'll need my sword \nand shield today..."
	label1.show()
	await get_tree().create_timer(3).timeout
	oscaranim.play("grab")
	box.hide()
	label1.hide()
	animationplayer.play("collect") # When this finishes, _on_animation_finished("collect") will trigger

func _on_collect_finished() -> void:
	oscaranim.play("default")
	await get_tree().create_timer(1).timeout
	oscaranim.play("walk")
	box.show()
	label1.text = "NOW LET'S GO!"
	label1.show()
	animationplayer.play("exit")
	
