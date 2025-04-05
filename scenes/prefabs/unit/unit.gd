extends Node2D
class_name Unit


@onready var sprite: Sprite2D = $Sprite2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var team: int = Teams.PLAYER_1
var selected: bool = false

func select() -> void:
	selected = true
	## DRAW SOME STUFF, ALSO TELL THE UNIT MANAGER


func deselect() -> void:
	selected = false
	## UNDRAW SOME STUFF, ALSO TELL THE UNIT MANAGER
