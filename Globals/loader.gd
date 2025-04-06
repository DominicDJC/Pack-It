extends Node

var root: Node2D

var items: Array[ItemData] = []

const ITEMS_PATH = "res://Assets/Items/ItemData"
const ITEM_OBJECT = preload("res://Objects/Item/item.tscn")

func _ready() -> void:
	randomize()
	for file in ResourceLoader.list_directory(ITEMS_PATH):
		var item: ItemData = ResourceLoader.load(ITEMS_PATH + "/" + file)
		items.append(item)


func get_item() -> Item:
	var item: Item = ITEM_OBJECT.instantiate()
	item.item_data = items[randi_range(0, items.size() - 1)]
	root.add_child(item)
	return item
