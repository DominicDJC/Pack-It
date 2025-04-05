class_name Background extends Node2D

@onready var background_sprite: Sprite2D = $BackgroundSprite

func set_background(background: BackgroundData) -> void:
	background_sprite.scale = Vector2(1, 1)
	background_sprite.texture = background.texture
	background_sprite.scale *= background.custom_size
