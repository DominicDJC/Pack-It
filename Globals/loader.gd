extends Node

var root: Node2D

var items: Array[PackedScene] = []
var scenes: Array[SceneData] = []
var doors: Array[DoorData] = []
var boxes: Array[PackedScene] = []

const ITEMS_PATH = "res://Assets/Items/ItemData"
const SCENE_PATH = "res://Assets/Scenes/SceneData"
const DOOR_PATH = "res://Assets/Doors/DoorData"
const BOXES_PATH = "res://Assets/Boxes/Boxes"


signal loaded


func _ready() -> void:
	randomize()
	for file in ResourceLoader.list_directory(ITEMS_PATH):
		var scene = load(ITEMS_PATH + "/" + file)
		items.append(scene)
	for file in ResourceLoader.list_directory(SCENE_PATH):
		var scene: SceneData = ResourceLoader.load(SCENE_PATH + "/" + file)
		scenes.append(scene)
	for file in ResourceLoader.list_directory(DOOR_PATH):
		var door: DoorData = ResourceLoader.load(DOOR_PATH + "/" + file)
		doors.append(door)
	for file in ResourceLoader.list_directory(BOXES_PATH):
		var scene = load(BOXES_PATH + "/" + file)
		boxes.append(scene)
	loaded.emit()


func get_item() -> Item:
	var item: Item = items[randi_range(0, items.size() - 1)].instantiate()
	root.add_child(item)
	return item


func get_scene() -> SceneData:
	return scenes[randi_range(0, scenes.size() - 1)]


func get_door() -> DoorData:
	return doors[randi_range(0, doors.size() - 1)]


func get_box() -> Box:
	var box: Box = boxes[randi_range(0, boxes.size() - 1)].instantiate()
	return box
