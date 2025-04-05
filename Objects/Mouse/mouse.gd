class_name Mouse extends Node2D

@onready var pin_joint: PinJoint2D = $PinJoint
@onready var target: Node2D = $Target


var items: Array[Item] = []


func _process(delta: float) -> void:
	position = get_global_mouse_position()


func _on_mouse_sensor_body_entered(body: Node2D) -> void:
	if body is Item:
		items.append(body)


func _on_mouse_sensor_body_exited(body: Node2D) -> void:
	if body in items:
		items.erase(body)


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			if items:
				pin_joint.node_a = items[0].get_path()
		if event.is_released():
			pin_joint.node_a = NodePath("")
