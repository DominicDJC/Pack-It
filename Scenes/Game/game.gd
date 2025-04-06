class_name Game extends Node2D

@export var timer_label: Label
@export var items_label: Label
@export var box: Box
@export var boss: Boss

@onready var animation_player: AnimationPlayer = $GameUI/AnimationPlayer
@onready var rail_container: Node2D = $RailContainer
@onready var background: Sprite2D = $Background
@onready var ground: Sprite2D = $BoxContainer/Ground


var playing: bool = false
var time: float = 0.0
var last_liner: int = 0.0
var score: int = 0

const DOOR_GROUP = preload("res://Objects/DoorGroup/door_group.tscn")
const ROUND_TIME = 60


func _ready() -> void:
	LOADER.root = self
	var scene_data: SceneData = LOADER.get_scene()
	background.texture = scene_data.background_texture
	background.scale *= scene_data.background_size
	background.position += scene_data.background_offset
	ground.texture = scene_data.ground_texture
	ground.scale *= scene_data.ground_size
	ground.position += scene_data.ground_offset
	box.item_entered.connect(increase_counter)
	box.item_exited.connect(decrease_counter)
	animation_player.play("Open")
	await animation_player.animation_finished
	start_game()


func _process(delta: float) -> void:
	if playing:
		if time > 0:
			time -= delta
			if time <= 0:
				end_game()
				return
			timer_label.text = str(snapped(time, 0))
		if !boss.free:
			last_liner = time
		elif last_liner - time > 5.0:
			last_liner = time
			boss.idle()
		if boss.free and time < 10.0:
			boss.time_warning()


func start_game() -> void:
	time = ROUND_TIME
	last_liner = ROUND_TIME
	await boss.open()
	playing = true
	while time > 0:
		await call_items()
		await get_tree().create_timer(1)


func end_game() -> void:
	score = box.count()
	update_counter(score)
	playing = false
	animation_player.play("Results")
	await animation_player.animation_finished
	boss.game_over(score)
	# Return to main menu after


func call_items() -> void:
	var doors: DoorGroup = DOOR_GROUP.instantiate()
	rail_container.add_child(doors)
	await doors.doors_gone


func update_counter(count: int) -> void:
	items_label.text = str(box.count()) + (" items" if count != 1 else " item")


func increase_counter(item: Item) -> void:
	if playing:
		update_counter(box.count())
		animation_player.play("AddItem")


func decrease_counter(item: Item) -> void:
	if playing:
		update_counter(box.count())
		animation_player.play("RemoveItem")
