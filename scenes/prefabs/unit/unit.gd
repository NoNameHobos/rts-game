extends Node2D
class_name Unit


@onready var sprite: Sprite2D = $Sprite2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var team: int = Teams.PLAYER_1
