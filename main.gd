extends Control

@export var card_scene: PackedScene
@onready var card_grid = $GridContainer

var card_deck = ["butterfly","butterfly", "goldfish","goldfish","mockingbird","mockingbird","worm","worm","hummingbird","hummingbird","ladybug","ladybug","lotus","lotus","trout","trout"]
var current_hand = []
var pickedcards = 0
var matches = 0
var lock_board = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	card_deck.shuffle()
	print(card_deck)
	card_grid.add_theme_constant_override("h_separation", 24)
	card_grid.add_theme_constant_override("v_separation", 24)
	print_board()


func print_board():
	for item in card_deck:
		if card_scene:
			var card = card_scene.instantiate()
			card.id = item
			card.gamemaster = self
			# The GridContainer can only arrange Controls, so we give each Node2D card a Control wrapper. card.tscn itself is untouched.
			var card_size = card.get_sprite_frames().get_frame_texture("default", 0).get_size() * 2.5
			var wrapper = Control.new()
			wrapper.custom_minimum_size = card_size
			wrapper.mouse_filter = Control.MOUSE_FILTER_IGNORE
			card.scale = Vector2(2.5, 2.5)
			card.position = card_size / 2
			wrapper.add_child(card)
			card_grid.add_child(wrapper)

func my_turn(card):
	if lock_board or pickedcards >= 2 or card.matched or not card.face_down:
		return
	else:
		card.play(card.id)
		card.face_down = false
		current_hand.append(card)
		pickedcards += 1
	if pickedcards == 2:
		is_matching_hand()

func is_matching_hand():
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
