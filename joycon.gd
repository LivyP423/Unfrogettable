extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func display():
	var gem = gamemaster.gemCount
	if gem == 0:
		visible = true
		await get_tree().create_timer(5).timeout
		visible = false
