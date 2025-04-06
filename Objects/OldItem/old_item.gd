class_name OldItem extends RigidBody2D

@export var item_data: ItemData

@onready var item_sprite: Sprite2D = $ItemSprite
@onready var item_collision: CollisionShape2D = $ItemCollision


func _ready() -> void:
	item_sprite.scale *= item_data.custom_size
	item_collision.scale *= item_data.custom_size
	item_sprite.texture = item_data.texture
	item_collision.shape = item_data.hitbox
	mass = item_data.mass


func _process(delta: float) -> void:
	if position.y > 3000:
		get_parent().remove_child(self)
		self.queue_free()


func disable_collision() -> void:
	item_collision.disabled = true


func enable_collision() -> void:
	item_collision.disabled = false
