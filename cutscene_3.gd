extends Node2D

@onready var princessMochi = $princess
@onready var animation = $AnimationPlayer
@onready var dialogueBox = $GUI/TextureRect
@onready var dialogue = $GUI/TextureRect/Label
@onready var oscarAnims = $Oscar/AnimatedSprite2D
@onready var curtainCall = $Curtain
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curtainCall.hide()
	oscarAnims.play("walk")
	dialogueBox.show()
	dialogue.show()
	princessMochi.play("sadWedding")
	animation.play("enter")
	await get_tree().create_timer(2.45).timeout
	oscarAnims.play("default")
	dialogue.text = "..."
	await get_tree().create_timer(2).timeout
	dialogue.text = "Princess Mochi? Why are you\nso sad? I just saved you and\nAnova Kingdom!"
	await get_tree().create_timer(3).timeout
	dialogue.hide()
	dialogueBox.hide()
	await get_tree().create_timer(1).timeout
	princessMochi.play("sad2")
	dialogue.add_theme_color_override("font_color", Color.DEEP_PINK)
	dialogue.text = "Oh Oscar, my dearest Knight...\nI'm sad because you forgot\nabout me!"
	dialogueBox.show()
	dialogue.show()
	await get_tree().create_timer(3).timeout
	princessMochi.play("sadWedding")
	dialogue.text = "In fact, I bet you don't even\nremember what day it is!"
	await get_tree().create_timer(3).timeout
	dialogue.hide()
	dialogueBox.hide()
	await get_tree().create_timer(.25).timeout
	dialogue.add_theme_color_override("font_color", Color.BLACK)
	dialogue.text = "Why of course I do! It's the\nday of your wedding!"
	dialogue.show()
	dialogueBox.show()
	await get_tree().create_timer(2.5).timeout
	dialogue.hide()
	dialogueBox.hide()
	await get_tree().create_timer(.25).timeout
	dialogue.add_theme_color_override("font_color", Color.DEEP_PINK)
	dialogue.text = "Oscar, it's your wedding\ntoo!"
	dialogue.show()
	dialogueBox.show()
	await get_tree().create_timer(3).timeout
	princessMochi.play("sad2")
	dialogue.hide()
	dialogueBox.hide()
	await get_tree().create_timer(.25).timeout
	dialogue.add_theme_color_override("font_color", Color.BLACK)
	dialogue.text = ".."
	dialogue.show()
	dialogueBox.show()
	await get_tree().create_timer(.33).timeout
	dialogue.text="...."
	await get_tree().create_timer(.45).timeout
	dialogue.text=".........."
	await get_tree().create_timer(.75).timeout
	dialogue.text="..............."
	await get_tree().create_timer(2).timeout
	dialogue.text = "I'm so sorry I forgot about\nour wedding, but I promise, I\nnever forgot about you."
	dialogueBox.show()
	dialogue.show()
	princessMochi.play("sadWedding")
	await get_tree().create_timer(3).timeout
	dialogue.text = "My love, everything I've\ndone today was for you!"
	await get_tree().create_timer(1).timeout
	princessMochi.play("happyWedding")
	await get_tree().create_timer(2).timeout
	dialogue.add_theme_color_override("font_color", Color.DEEP_PINK)
	dialogue.text = "Really? Is that true?"
	await get_tree().create_timer(2).timeout

	dialogue.add_theme_color_override("font_color", Color.BLACK)
	dialogue.text = "It's true, you never left my\nmind nor my heart. I promise\nI'll do better about\nremembering things that"
	dialogue.show()
	dialogueBox.show()
	await get_tree().create_timer(4).timeout
	dialogue.text = "are important, Princess.\nPlease give me one more\nchance?" 
	await get_tree().create_timer(3).timeout
	dialogue.hide()
	dialogueBox.hide()
	dialogue.add_theme_color_override("font_color", Color.DEEP_PINK)
	await get_tree().create_timer(1).timeout
	dialogue.text = "Oh Oscar, my Knight, how I\nlove you so! You are a\nreal hero!"
	dialogueBox.show()
	dialogue.show()
	await get_tree().create_timer(3).timeout
	animation.play("endGame")
	await get_tree().create_timer(1.5).timeout
	curtainCall.show()
	curtainCall.play("default")
	
	
	
