extends Node2D

var oscarHealth: int = 3
var flyHealth: int = 3
var level: int = 1

# Safe node lookups: checks relative paths first, then root paths
@onready var oscarHeart = _find_heart_node(["../Oscar/heart", "Oscar/heart"])
@onready var flyHeart = _find_heart_node(["../flyguy/heartFly", "flyguy/heartFly"])

func _ready() -> void:
	healthDisplay()


func _process(_delta: float) -> void:
	healthDisplay()


func healthDisplay() -> void:
	# Guard check: only update if both heart UI nodes actually exist
	if is_instance_valid(oscarHeart) and is_instance_valid(flyHeart):
		oscarHeart.value = oscarHealth
		flyHeart.value = flyHealth


# Helper function to prevent "Node not found" crashes
func _find_heart_node(paths: Array) -> Node:
	for path in paths:
		if has_node(path):
			return get_node(path)
	return null
