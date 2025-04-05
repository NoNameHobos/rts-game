extends Node2D
class_name UnitManager


@export var cursor: GameCursor

var units_selected: Dictionary[int, bool] = {}

func _ready() -> void:
	cursor.unit_selected.connect(_unit_selected)
	cursor.unit_deselected.connect(_unit_deselected)


func _unit_selected(id: int) -> void:
	var unit = instance_from_id(id)
	if unit is Unit:
		unit.select()
	

func _unit_deselected(id: int) -> void:
	var unit = instance_from_id(id)
	if unit is Unit:
		unit.deselect()
