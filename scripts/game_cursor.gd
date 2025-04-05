extends Node2D
class_name GameCursor


signal unit_selected(id: int)
signal unit_deselected(id: int)

@export
var box_color: Color = Color.AQUA
@export_range(0,1,0.01)
var box_alpha: float = 0.5
@export_range(0,1,0.01)
var box_outline_alpha: float = 0.9

var area_2d: Area2D
var collision_rect: RectangleShape2D


var is_dragging: bool = false
var dragging_coord: Vector2 = Vector2.ZERO
var selection_rect: Rect2


var selected_units: Dictionary[int, bool] = {}

func _ready() -> void:
	
	area_2d = Area2D.new()
	add_child(area_2d)
	
	var collision_shape := CollisionShape2D.new()
	collision_rect = RectangleShape2D.new()
	collision_shape.shape = collision_rect
	
	area_2d.add_child(collision_shape)
	
	area_2d.area_entered.connect(_area_entered)
	
	
	z_index = RenderingServer.CANVAS_ITEM_Z_MAX

func _area_entered(area: Area2D) -> void:
	selected_units[area.owner.get_instance_id()] = true

func _area_exited(area: Area2D) -> void:
	selected_units.erase(area.owner.get_instance_id())



func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index != MOUSE_BUTTON_LEFT:
			return
			
		# on click then enter drag
		if not is_dragging and event.pressed:
			is_dragging = true
			dragging_coord = get_viewport().get_mouse_position()
			for id in selected_units.keys():
				unit_deselected.emit(id)
			selected_units.clear()
		# on release and entered drag then stop drag
		elif is_dragging and not event.pressed:
			is_dragging = false
			area_2d.monitoring = false
			for id in selected_units.keys():
				unit_selected.emit(id)


func _process(_delta: float) -> void:
	
	if is_dragging:
	
		var mouse_pos: Vector2 = get_viewport().get_mouse_position()
		
		var pos: Vector2
		var size: Vector2
		
		var p_x: float
		var p_y: float
		var s_x: float
		var s_y: float
		
		if mouse_pos.x < dragging_coord.x:
			p_x = mouse_pos.x
			s_x = dragging_coord.x - mouse_pos.x
		else:
			p_x = dragging_coord.x
			s_x = mouse_pos.x - dragging_coord.x
		
		if mouse_pos.y < dragging_coord.y:
			p_y = mouse_pos.y
			s_y = dragging_coord.y - mouse_pos.y
		else:
			p_y = dragging_coord.y
			s_y = mouse_pos.y - dragging_coord.y
		
		pos = Vector2(p_x, p_y)
		size = Vector2(s_x, s_y)
		
		selection_rect = Rect2(pos, size)
		area_2d.monitoring = true
		area_2d.position = pos
		collision_rect.size = size
			
	
	
	queue_redraw()

func _draw() -> void:
	if is_dragging:
		draw_rect(selection_rect, Color(box_color, box_alpha))
		draw_rect(selection_rect, Color(box_color, box_outline_alpha), false, 2.0)
		
