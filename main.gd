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
@onready var turnToken = $"../../../turnToken"
@onready var oscarAnim = $"../../../OscarAnim"
@onready var oscarSpriteAnims = $"../../../Oscar/AnimatedSprite2D"
@onready var flySpriteAnims = $"../../../flyguy/AnimatedSprite2D"
@onready var flyAnims = $"../../../FlyAnim"
@onready var shield = $"../../../Oscar/shield"
@onready var sword = $"../../../Oscar/AnimatedSprite2D/Marker2D/sword"
@onready var gameOverDeathScreen = $"../../GameOverDeath"
@onready var keyAnim = $"../../GameOverWin/key"
@onready var gameOverWinScreen = $"../../GameOverWin"

var card_deck: Array = [
	"butterfly", "butterfly", "goldfish", "goldfish", "mockingbird", "mockingbird",
	"worm", "worm", "hummingbird", "hummingbird", "ladybug", "ladybug",
	"lotus", "lotus", "trout", "trout"
]
var current_hand: Array = []
var matches: int = 0
var current_state: GameState = GameState.STARTUP
var last_actor: GameState = GameState.PLAYER_TURN

func _ready() -> void:
	gameOverDeathScreen.hide()
	gameOverWinScreen.hide()
	flySpriteAnims.flip_h = true
	oscarSpriteAnims.flip_h = true
	flySpriteAnims.play("default")
	oscarSpriteAnims.play("default")
	randomize()
	card_deck.shuffle()
	
	if is_instance_valid(turnToken):
		turnToken.hide()
		turnToken.scale.x = 3.8
		turnToken.scale.y = 3.3
		turnToken.position.y = 372.0
		
	if card_grid:
		card_grid.add_theme_constant_override("h_separation", 12)
		card_grid.add_theme_constant_override("v_separation", 12)
		
	await print_board()
	
	if is_instance_valid(turnToken):
		turnToken.show()
	print("ready finished")	
	change_state(GameState.PLAYER_TURN)


func change_state(new_state: GameState) -> void:
	current_state = new_state
	
	match current_state:
		GameState.PLAYER_TURN:
			print("--- Player's Turn ---")
			if is_instance_valid(turnToken):
				turnToken.position.x = 184.0
				turnToken.rotation_degrees = -16.7
			
		GameState.AI_TURN:
			print("--- AI's Turn ---")
			if is_instance_valid(turnToken):
				turnToken.position.x = 967.0
				turnToken.rotation_degrees = 16.7
			run_ai_turn()
			
		GameState.CHECKING_MATCH:
			check_hand_match()
			
		GameState.GAME_OVER:
			card_grid.hide()
			print("--- Game Over ---")
			if gamemaster.oscarHealth <= 0:
				gameOverDeathScreen.show()
				oscarSpriteAnims.hide()
			elif gamemaster.flyHealth <= 0:
				flySpriteAnims.hide()
				gameOverWinScreen.show()
				keyAnim.play("shine")
				await get_tree().create_timer(5).timeout
				gamemaster.gemCount += 1
				get_tree().change_scene_to_file("res://game.tscn")


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

	await get_tree().create_timer(1.75).timeout
	
	for card in spawned_cards:
		if is_instance_valid(card):
			card.flip_face_down()


func my_turn(card) -> void:
	if current_state != GameState.PLAYER_TURN:
		return
		
	if not is_instance_valid(card) or card.matched or not card.face_down or card in current_hand or current_hand.size() >= 2:
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

	# Shuffle available cards and make the first pick
	available_cards.shuffle()
	flip_card(available_cards[0])
	
	await get_tree().create_timer(0.8).timeout
	
	# Make the second pick
	if available_cards.size() > 1 and is_instance_valid(available_cards[1]):
		flip_card(available_cards[1])
		
	await get_tree().create_timer(0.5).timeout
	change_state(GameState.CHECKING_MATCH)


func flip_card(card) -> void:
	if not is_instance_valid(card):
		return
		
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
		
		# Modify health variables on the Game Master if assigned
		if is_instance_valid(gamemaster):
			if who_just_played == GameState.PLAYER_TURN: #Oscar hits
				if "flyHealth" in gamemaster:
					if is_instance_valid(oscarAnim):
						oscarAnim.play("hit")
						oscarSpriteAnims.play("walk")
					await get_tree().create_timer(.75).timeout
					oscarSpriteAnims.play("default")
					gamemaster.flyHealth -= 1
					print("Player hit! AI Health: ", gamemaster.flyHealth)
					if is_instance_valid(oscarSpriteAnims):
						oscarSpriteAnims.z_index = 10
						shield.z_index = 11
						
						oscarSpriteAnims.play("hit")
						for i in range(3):
							flySpriteAnims.play("hurt")
							await get_tree().create_timer(.15).timeout
						
						await get_tree().create_timer(.35).timeout
					if is_instance_valid(oscarAnim):
						oscarAnim.play("return")
						oscarSpriteAnims.play("walk")
					await get_tree().create_timer(1.0).timeout
					oscarSpriteAnims.play("default")
					oscarSpriteAnims.z_index = 1
					flySpriteAnims.play("default")
			else:
				if "oscarHealth" in gamemaster: #Fly hits
					print("AI hit! Player Health: ", gamemaster.oscarHealth)
					if is_instance_valid(flyAnims):
						flySpriteAnims.z_index = 10
						flyAnims.play("hit")
						flySpriteAnims.play("walk")
						await get_tree().create_timer(0.65).timeout
						flySpriteAnims.play("default")
						gamemaster.oscarHealth -= 1
						for i in range(3):
							oscarSpriteAnims.play("hurt")
							await get_tree().create_timer(.15).timeout
						oscarSpriteAnims.play("default")
						flySpriteAnims.play("hit")
						await get_tree().create_timer(0.6).timeout
						flyAnims.play("return")
						flySpriteAnims.play("default")
						await get_tree().create_timer(0.85).timeout
						flySpriteAnims.z_index = 1
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

	# Game over conditions check
	var player_hp: int = gamemaster.oscarHealth if (is_instance_valid(gamemaster) and "oscarHealth" in gamemaster) else 1
	var ai_hp: int = gamemaster.flyHealth if (is_instance_valid(gamemaster) and "flyHealth" in gamemaster) else 1

	if matches >= card_deck.size() / 2.0 or player_hp <= 0 or ai_hp <= 0:
		change_state(GameState.GAME_OVER)
		return

	# Transition turn
	if who_just_played == GameState.PLAYER_TURN:
		change_state(GameState.AI_TURN)
	else:
		change_state(GameState.PLAYER_TURN)
