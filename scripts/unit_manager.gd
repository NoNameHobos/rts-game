extends Node2D
class_name UnitManager


@export var cursor: GameCursor

var units_selected: Dictionary[int, bool] = {}

func _ready() -> void:
	cursor.drag_start.connect(_deselect_units)
	cursor.drag_end.connect(_select_units)


func _select_units(ids: Dictionary[int, bool]) -> void:
	print(ids)
	for id in ids.keys():
		print(id)
		var unit = instance_from_id(id)
		
		if unit is Unit:
			unit.select()
			units_selected[id] = true
	

func _deselect_units() -> void:
	for id in units_selected.keys():
		var unit = instance_from_id(id)
		if unit is Unit:
			unit.deselect()
			units_selected.erase(id)
