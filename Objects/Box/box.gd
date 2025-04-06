class_name Box extends Node2D

@onready var box_item_area: Area2D = $BoxItemArea

var items: Array[Item] = []

signal item_entered(item: Item)
signal item_exited(item: Item)


func _ready() -> void:
	box_item_area.body_entered.connect(_item_entered)
	box_item_area.body_exited.connect(_item_exited)


func count() -> int:
	return items.size()


func _item_entered(body: Node2D) -> void:
	if body is Item and body not in items:
		item_entered.emit(body)
		items.append(body)


func _item_exited(body: Node2D) -> void:
	if body in items:
		item_exited.emit(body)
		items.erase(body)
