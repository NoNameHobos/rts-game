extends Node2D
class_name GameCursor

@export
var box_color: Color = Color.AQUA
@export_range(0,1,0.01)
var box_alpha: float = 0.5
@export_range(0,1,0.01)
var box_outline_alpha: float = 0.9



var is_dragging: bool = false

var dragging_coord: Vector2 = Vector2.ZERO


func _ready() -> void:
	z_index = 10001000

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not is_dragging and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = true
			dragging_coord = get_viewport().get_mouse_position()
		elif is_dragging and not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = false


func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if is_dragging:
		print("Drawing!")
		var mouse_pos: Vector2 = get_viewport().get_mouse_position()
		
		var pos: Vector2
		var size: Vector2
		
		if mouse_pos.length_squared() < dragging_coord.length_squared():
			pos = mouse_pos
			size = dragging_coord-mouse_pos
		else:
			pos = dragging_coord
			size = mouse_pos-dragging_coord
		
		
		var rect := Rect2(pos, size)
		
		draw_rect(rect, Color(box_color, box_alpha))
		draw_rect(rect, Color(box_color, box_outline_alpha), false, 2.0)
		
