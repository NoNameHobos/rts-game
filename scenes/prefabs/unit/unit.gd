extends Node2D
class_name Unit

@export var team: int = Teams.PLAYER_1
@export var PATH_DIST: float = 4.0
@export var MIN_DIST: float = 4.0
@export var MOVE_SPEED: float = 1.0

@onready var selector_sprite: Sprite2D = $Selector
@onready var sprite: Sprite2D = $Base
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	_init_nav_agent()

# Select Logic
var selected: bool = false


func _process(_delta: float) -> void:
	
	(selector_sprite.material as ShaderMaterial).set_shader_parameter("team_color", Teams.COLORS[team])

func select() -> void:
	selected = true
	selector_sprite.visible = true

func deselect() -> void:
	selected = false
	selector_sprite.visible = false

func _init_nav_agent():
	nav_agent.path_desired_distance = PATH_DIST
	nav_agent.target_desired_distance = MIN_DIST
	
	var init = func():
		# Wait for the first physics frame so the NavigationServer can sync.
		await get_tree().physics_frame
		
		# Now that the navigation map is no longer empty, set the movement target.
		move_to(self.position)
	init.call_deferred()
		
	
func move_to(movement_target: Vector2):
	nav_agent.target_position = movement_target

func _physics_process(delta):
	if not nav_agent.is_navigation_finished():
		move_path(delta)
		
func move_path(delta):
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()

	#velocity = current_agent_position.direction_to(next_path_position) * MOVE_SPEED
	#move_and_slide()
	self.position = self.position.move_toward(next_path_position, MOVE_SPEED)
