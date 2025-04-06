class_name Game extends Node2D

@export var timer_label: Label
@export var items_label: Label
@export var box: Box

var game_started: bool = false
var time: float = 0.0

const DOOR_GROUP = preload("res://Objects/DoorGroup/door_group.tscn")
const ROUND_TIME = 60


func _ready() -> void:
	LOADER.root = self
	start_game()


func _process(delta: float) -> void:
	if game_started:
		if time > 0:
			time -= delta
			if time < 0:
				time = 0
			timer_label.text = str(snapped(time, 0.01))
		items_label.text = str(box.count()) + " items"


func start_game() -> void:
	time = ROUND_TIME
	game_started = true
	call_items()


func call_items() -> void:
	var doors: DoorGroup = DOOR_GROUP.instantiate()
	add_child(doors)
