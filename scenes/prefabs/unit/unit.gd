extends Node2D
class_name Unit

@onready var selector_sprite: Sprite2D = $Selector
@onready var sprite: Sprite2D = $Base
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var team: int = Teams.PLAYER_1
var selected: bool = false

func select() -> void:
	selected = true
	selector_sprite.visible = true
	## DRAW STUFF


func deselect() -> void:
	selected = false
	selector_sprite.visible = false
	## UNDRAW SOME STUFF
