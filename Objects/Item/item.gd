class_name Item extends RigidBody2D


func _ready() -> void:
	set_collision_layer_value(3, true)
	set_collision_mask_value(3, true)


func _process(delta: float) -> void:
	if position.y > 3000:
		get_parent().remove_child(self)
		self.queue_free()


func disable_collision() -> void:
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = true


func enable_collision() -> void:
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = false
