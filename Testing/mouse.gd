extends Node2D

@export var pin_joint: PinJoint2D

var items: Array[Item] = []


func _process(delta: float) -> void:
	position = get_global_mouse_position()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Item:
		print("Item entered")
		items.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body in items:
		print("Item exited")
		items.erase(body)


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			if items:
				pin_joint.node_a = items[0].get_path()
			print("MOUSE CLICKED HOLY SHIT")
		if event.is_released():
			pin_joint.node_a = NodePath("")
			print("MOUSE NOT CLICKED ANYMORE HOLY SHIT")
