extends Control

@export var card_scene: PackedScene 
@onready var card_grid = $GridContainer

var card_deck = ["butterfly","butterfly", "goldfish","goldfish","mockingbird","mockingbird","worm","worm","hummingbird","hummingbird","ladybug","ladybug","lotus","lotus","trout","trout"]
var current_hand = []
var pickedcards = 0
var matches = 0
var lock_board = false

func _ready():
	randomize()
	card_deck.shuffle()
	print(card_deck)
	
	if card_grid:
		card_grid.add_theme_constant_override("h_separation", 24)
		card_grid.add_theme_constant_override("v_separation", 24)
		
	print_board()


func print_board():
	lock_board = true # Stop player from clicking while cards are revealing
	var spawned_cards = [] # Keeps track of all cards to flip them collectively later
	
	if not card_scene:
		push_error("Card Scene is missing! Make sure res://card.tscn exists.")
		return

	for item in card_deck:
		await get_tree().create_timer(0.1).timeout # Reduced delay for faster initial layout pass
		
		var card = card_scene.instantiate()
		
		# Set Z-index high so Node2D renders over world background elements
		card.z_index = 10 
		card.z_as_relative = false # Ignores parent Control Z-index restrictions
		
		# Start face up so the player sees what it is
		card.face_down = false
		card.id = item
		card.gamemaster = self
		
		# GridContainer layout wrapper setup
		var card_size = card.get_sprite_frames().get_frame_texture("default", 0).get_size() * 2.5
		var wrapper = Control.new()
		wrapper.custom_minimum_size = card_size
		wrapper.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
		card.scale = Vector2(2.5, 2.5)
		card.position = card_size / 2
		
		wrapper.add_child(card)
		card_grid.add_child(wrapper)
		
		# Trigger visual update after parent addition
		if card.has_method("play"):
			card.play(card.id)
			
		spawned_cards.append(card)

	# All cards are on the board; wait before flipping down
	await get_tree().create_timer(1.5).timeout
	
	for card in spawned_cards:
		if is_instance_valid(card):
			card.flip_face_down()
		
	lock_board = false


func my_turn(card):
	if lock_board or pickedcards >= 2 or card.matched or not card.face_down:
		return
		
	card.play(card.id)
	card.face_down = false
	current_hand.append(card)
	pickedcards += 1
		
	if pickedcards == 2:
		is_matching_hand()


func is_matching_hand():
	# Safely compare card 0 against card 1 in the hand
	if current_hand[0].id == current_hand[1].id:
		print("MATCH!")
		matches += 1
		await get_tree().create_timer(1.0).timeout
		for item in current_hand:
			item.matched = true
			item.visible = false
	else:
		print("Not a match.")
		lock_board = true
		await get_tree().create_timer(1.0).timeout
		for item in current_hand:
			item.play_reversed(item.id)
		lock_board = false
			
	current_hand.clear()
	pickedcards = 0
	
	if matches == card_deck.size() / 2:
		print("You win!")
