class_name Door extends Node2D

@export var target: Node2D
@export var door_data: DoorData

@onready var door_pin_point: StaticBody2D = $DoorPinPoint
@onready var door_frame: RigidBody2D = $DoorFrame
@onready var door_frame_hitbox: CollisionShape2D = $DoorFrame/DoorFrameHitbox
@onready var item_pin: PinJoint2D = $DoorFrame/ItemPin
@onready var door_sprite: Sprite2D = $DoorFrame/DoorSprite

const ITEM = preload("res://Objects/Item/item.tscn")

var _current_item: Item
var opened: bool = false


func _ready() -> void:
	door_sprite.scale *= door_data.custom_size
	door_sprite.texture = door_data.closed_texture
	disable_collision()
	var item: Item = LOADER.get_item()
	item.global_position = item_pin.global_position
	item_pin.node_a = item.get_path()
	item.visible = false
	_current_item = item


func _process(delta: float) -> void:
	door_pin_point.position = target.position


func disable_collision() -> void:
	visible = false
	door_frame_hitbox.disabled = true


func enable_collision() -> void:
	visible = true
	door_frame_hitbox.disabled = false


func open_door() -> void:
	door_sprite.texture = door_data.open_texture
	item_pin.node_a = NodePath("")
	_current_item.visible = true
	opened = true


func _on_click_area_mouse_entered() -> void:
	pass


func _on_click_area_mouse_exited() -> void:
	pass


func _on_click_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Door clicked")
			open_door()
