extends Control

# State Machine States
enum GameState {
	STARTUP,
	PLAYER_TURN,
	AI_TURN,
	CHECKING_MATCH,
	GAME_OVER
}

@onready var card_grid: GridContainer = $GridContainer

var card_deck: Array = [
	"butterfly", "butterfly", "goldfish", "goldfish", "mockingbird", "mockingbird",
	"worm", "worm", "hummingbird", "hummingbird", "ladybug", "ladybug",
	"lotus", "lotus", "trout", "trout"
]

var current_hand: Array = []
var matches: int = 0
var current_state: GameState = GameState.STARTUP
var last_actor: GameState = GameState.PLAYER_TURN

# Set this reference from your main scene or parent node
var gamemaster: Node = null


func _ready() -> void:
	randomize()
	card_deck.shuffle()
	
	if card_grid:
		card_grid.add_theme_constant_override("h_separation", 12)
		card_grid.add_theme_constant_override("v_separation", 12)
		
	await print_board()
	change_state(GameState.PLAYER_TURN)


func change_state(new_state: GameState) -> void:
	current_state = new_state
	
	match current_state:
		GameState.PLAYER_TURN:
			print("--- Player's Turn ---")
			
		GameState.AI_TURN:
			print("--- AI's Turn ---")
			run_ai_turn()
			
		GameState.CHECKING_MATCH:
			check_hand_match()
			
		GameState.GAME_OVER:
			print("Game Over!")


func print_board() -> void:
	current_state = GameState.STARTUP
	var spawned_cards: Array = []
	
	for child in card_grid.get_children():
		child.queue_free()

	for item in card_deck:
		await get_tree().create_timer(0.05).timeout
		
		var card = Card.new()
		card.id = item
		card.gamemaster = self
		card.face_down = false
		
		card_grid.add_child(card)
		
		if card.has_method("play"):
			card.play(card.id)
			
		spawned_cards.append(card)

	await get_tree().create_timer(2.5).timeout
	
	for card in spawned_cards:
		if is_instance_valid(card):
			card.flip_face_down()


func my_turn(card) -> void:
	if current_state != GameState.PLAYER_TURN:
		return
		
	if card.matched or not card.face_down or card in current_hand or current_hand.size() >= 2:
		return
		
	flip_card(card)
	
	if current_hand.size() == 2:
		change_state(GameState.CHECKING_MATCH)


func run_ai_turn() -> void:
	await get_tree().create_timer(0.8).timeout
	
	var available_cards: Array = []
	for child in card_grid.get_children():
		if is_instance_valid(child) and not child.matched and child.face_down:
			available_cards.append(child)
			
	if available_cards.size() < 2:
		change_state(GameState.GAME_OVER)
		return
		
	available_cards.shuffle()
	
	# Pick 1st card
	flip_card(available_cards[0])
	await get_tree().create_timer(0.8).timeout
	
	# Pick 2nd card
	flip_card(available_cards[1])
	await get_tree().create_timer(0.5).timeout
	
	change_state(GameState.CHECKING_MATCH)


func flip_card(card) -> void:
	last_actor = current_state
	card.play(card.id)
	card.face_down = false
	current_hand.append(card)


func check_hand_match() -> void:
	if current_hand.size() < 2:
		current_hand.clear()
		change_state(GameState.PLAYER_TURN)
		return

	var who_just_played: GameState = last_actor
	var is_match: bool = (current_hand[0].id == current_hand[1].id)

	await get_tree().create_timer(1.0).timeout

	if is_match:
		matches += 1
		
		# Safely modify the gamemaster health variables directly
		if is_instance_valid(gamemaster):
			if who_just_played == GameState.PLAYER_TURN:
				gamemaster.flyHealth -= 1
				print("Player hit! AI Health: ", gamemaster.flyHealth)
			else:
				gamemaster.oscarHealth -= 1
				print("AI hit! Player Health: ", gamemaster.oscarHealth)
		else:
			print("Warning: gamemaster reference is null!")
			
		for item in current_hand:
			if is_instance_valid(item):
				item.matched = true
				item.modulate.a = 0
	else:
		print("Not a match.")
		for item in current_hand:
			if is_instance_valid(item):
				item.play_reversed(item.id)
				item.face_down = true
			
	current_hand.clear()

	# Check for game over condition
	var player_hp = gamemaster.oscarHealth if is_instance_valid(gamemaster) else 1
	var ai_hp = gamemaster.flyHealth if is_instance_valid(gamemaster) else 1

	if matches >= card_deck.size() / 2.0 or player_hp <= 0 or ai_hp <= 0:
		change_state(GameState.GAME_OVER)
		return

	# Strictly alternate turns
	if who_just_played == GameState.PLAYER_TURN:
		change_state(GameState.AI_TURN)
	else:
		change_state(GameState.PLAYER_TURN)
